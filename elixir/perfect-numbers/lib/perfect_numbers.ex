defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number)

  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    aliquot_sum =
      1..number
      |> Enum.reduce(0, fn el, acc ->
        cond do
          el >= number -> acc
          factor?(number, el) -> acc + el
          true -> acc
        end
      end)

    result =
      case aliquot_sum do
        ^number -> :perfect
        sum when sum > number -> :abundant
        _ -> :deficient
      end

    {:ok, result}
  end

  defp factor?(number, candidate), do: rem(number, candidate) == 0
end
