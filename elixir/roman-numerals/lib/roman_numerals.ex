defmodule RomanNumerals do
  @roman %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    @roman
    |> Map.keys()
    |> Enum.sort(&(&1 >= &2))
    |> to_roman(number, "")
  end

  def to_roman([], _, acc), do: acc

  def to_roman([max | rest] = keys, number, acc) do
    if number >= max do
      to_roman(keys, number - max, acc <> @roman[max])
    else
      to_roman(rest, number, acc)
    end
  end
end
