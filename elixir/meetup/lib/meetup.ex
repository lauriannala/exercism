defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @teenths 13..19 |> Enum.to_list()
  @weekdays [
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday,
    :sunday
  ]

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth
  @schedules %{
    first: 0,
    second: 1,
    third: 2,
    fourth: 3,
    last: 4
  }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    base = Date.new!(year, month, 1)
    month_begin = Date.beginning_of_month(base)
    month_end = Date.end_of_month(base)
    dates = month_begin |> Date.range(month_end) |> transform()

    do_meetup(schedule, dates, weekday)
  end

  defp transform(dates) do
    Enum.map(dates, fn date ->
      weekday = Enum.at(@weekdays, Date.day_of_week(date) - 1)
      teenth? = date.day in @teenths
      {weekday, teenth?, date}
    end)
  end

  defp do_meetup(:teenth, dates, target_weekday) do
    {_, _, result} =
      dates
      |> Enum.find(fn {weekday, teenth?, _} ->
        weekday == target_weekday and teenth?
      end)

    result
  end

  defp do_meetup(schedule, dates, target_weekday) do
    results =
      Enum.filter(dates, fn {weekday, _, _} ->
        weekday == target_weekday
      end)

    index = @schedules[schedule]

    {_, _, result} =
      case schedule do
        :first -> List.first(results)
        :last -> List.last(results)
        _ -> Enum.at(results, index)
      end

    result
  end
end
