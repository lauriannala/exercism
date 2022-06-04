defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(elapsed), do: expected_minutes_in_oven() - elapsed

  def preparation_time_in_minutes(layer_count), do: layer_count * 2

  def total_time_in_minutes(layer_count, elapsed), do: preparation_time_in_minutes(layer_count) + elapsed

  def alarm(), do: "Ding!"
end
