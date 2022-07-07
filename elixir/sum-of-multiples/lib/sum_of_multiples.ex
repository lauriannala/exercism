defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.reduce(1..(limit - 1), 0, fn
      from, acc ->
        if multiple_of?(from, factors) do
          acc + from
        else
          acc
        end
    end)
  end

  def multiple_of?(0, _), do: false

  def multiple_of?(_, []), do: false

  def multiple_of?(_, [0 | _]), do: false

  def multiple_of?(from, [number | numbers]) do
    rem(from, number) == 0 or multiple_of?(from, numbers)
  end
end
