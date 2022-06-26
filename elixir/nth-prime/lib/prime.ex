defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    2
    |> Stream.unfold(&{%{n: &1, prime?: prime?(&1)}, &1 + 1})
    |> Stream.filter(& &1.prime?)
    |> Enum.take(count)
    |> Enum.reverse()
    |> hd()
    |> then(& &1.n)
  end

  defp prime?(2), do: true

  defp prime?(n) do
    square_root_of_n = :math.sqrt(n)
    do_trial_division(n, square_root_of_n, 2)
  end

  defp do_trial_division(n, square_root_of_n, current) do
    not_composite? = rem(n, current) != 0

    if not_composite? and current < square_root_of_n do
      do_trial_division(n, square_root_of_n, current + 1)
    else
      not_composite?
    end
  end
end
