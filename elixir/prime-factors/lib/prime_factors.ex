defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number
    |> do_factors_for(2, [])
    |> Enum.reverse()
  end

  defp do_factors_for(number, current, acc) do
    cond do
      current > number -> acc
      factor?(number, current) -> do_factors_for(div(number, current), current, [current | acc])
      true -> do_factors_for(number, current + 1, acc)
    end
  end

  defp factor?(number, candidate), do: rem(number, candidate) == 0
end
