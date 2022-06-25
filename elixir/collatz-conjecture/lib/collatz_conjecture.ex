defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    Stream.unfold(input, fn
      acc when rem(acc, 2) == 0 ->
        {acc, div(acc, 2)}
      acc ->
        {acc, acc * 3 + 1}
    end)
    |> Enum.take_while(fn number -> number != 1 end)
    |> Enum.count()
  end
end
