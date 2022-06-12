defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_return = if before_noon?(checkout_datetime), do: 28, else: 29

    Date.add(checkout_datetime, days_to_return)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    if diff > 0, do: diff, else: 0
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    planned_return_date = checkout |> datetime_from_string() |> return_date()
    return_date = datetime_from_string(return)
    days = days_late(planned_return_date, return_date)

    fee = days * rate

    if monday?(return_date), do: (0.50 * fee) |> trunc(), else: fee
  end
end
