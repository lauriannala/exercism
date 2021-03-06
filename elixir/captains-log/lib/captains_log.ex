defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    1000..9999
    |> Enum.random()
    |> then(&"NCC-#{&1}")
  end

  def random_stardate() do
    (:rand.uniform() * 1000) + 41_000
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> to_string()
  end
end
