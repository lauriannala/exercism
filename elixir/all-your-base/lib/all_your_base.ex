defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base)

  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    digits
    |> to_decimal(input_base)
    |> decimal_to_base(output_base)
  end

  defp to_decimal(input, input_base) do
    input = Enum.reverse(input)
    do_to_decimal(input, 0, input_base, 0)
  end

  defp do_to_decimal([], _, _, acc), do: acc

  defp do_to_decimal([digit | _], _, input_base, _) when digit < 0 or digit >= input_base,
    do: {:error, "all digits must be >= 0 and < input base"}

  defp do_to_decimal([digit | tail], index, input_base, acc) do
    value = digit * :math.pow(input_base, index)
    do_to_decimal(tail, index + 1, input_base, acc + value)
  end

  defp decimal_to_base({:error, _} = error, _), do: error
  defp decimal_to_base(decimal, output_base), do: do_decimal_to_base(decimal, output_base, [])

  defp do_decimal_to_base(0, _, acc), do: {:ok, acc}

  defp do_decimal_to_base(decimal, output_base, acc) do
    decimal = trunc(decimal)
    result = div(decimal, output_base)
    remainder = rem(decimal, output_base)

    do_decimal_to_base(result, output_base, [remainder | acc])
  end
end
