defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: 8.0 * hourly_rate

  def apply_discount(before_discount, discount), do: before_discount - discount * before_discount * 0.01

  def monthly_rate(hourly_rate, discount) do
    daily = daily_rate(hourly_rate)
    monthly = daily * 22
    apply_discount(monthly, discount) |> :math.ceil() |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily = daily_rate(hourly_rate) |> apply_discount(discount)
    (budget / daily) |> Float.floor(1)
  end
end
