defmodule BirdCount do
  def today([]), do: nil

  def today([todays_count | _]), do: todays_count

  def increment_day_count([]), do: [1]

  def increment_day_count([todays_count | rest]) do
    [todays_count + 1 | rest]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  def total(list) do
    do_total(list, 0)
  end

  defp do_total([], sum), do: sum
  defp do_total([head | tail], sum), do: do_total(tail, head + sum)

  def busy_days(list) do
    do_busy_days(list, 0)
  end

  defp do_busy_days([], count), do: count
  defp do_busy_days([head | tail], count) when head >= 5, do: do_busy_days(tail, count + 1)
  defp do_busy_days([_ | tail], count), do: do_busy_days(tail, count)
end
