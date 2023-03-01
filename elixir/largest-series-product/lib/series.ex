defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product("", 0), do: 1
  def largest_product(_, 0), do: 1

  def largest_product(number_string, size) do
    if String.length(number_string) < size or size < 0 do
      raise ArgumentError
    else
      do_largest_product(number_string, size)
    end
  end

  defp do_largest_product(number_string, size) do
    number_string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&Enum.product/1)
    |> Enum.max()
  end
end
