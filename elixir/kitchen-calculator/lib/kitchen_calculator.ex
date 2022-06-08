defmodule KitchenCalculator do
  def get_volume({_, num}), do: num

  def to_milliliter({:milliliter, _} = pair), do: pair
  def to_milliliter({unit, _} = pair), do: {:milliliter, get_volume(pair) * ratio(unit)}

  def from_milliliter({:milliliter, _} = pair, :milliliter), do: pair
  def from_milliliter({:milliliter, _} = pair, unit), do: {unit, get_volume(pair) / ratio(unit)}

  def convert({:milliliter, _} = pair, unit), do: from_milliliter(pair, unit)

  def convert({_, _} = pair, unit) do
    pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

  def ratio(:cup), do: 240
  def ratio(:fluid_ounce), do: 30
  def ratio(:teaspoon), do: 5
  def ratio(:tablespoon), do: 15
end
