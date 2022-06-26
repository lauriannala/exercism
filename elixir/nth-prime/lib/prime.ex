defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    2
    |> Stream.unfold(fn n ->
      is_prime = prime?(n)
      {%{n: n, prime?: is_prime}, n + 1}
    end)
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

    case not_composite? do
      true when current < square_root_of_n ->
        do_trial_division(n, square_root_of_n, current + 1)

      _ ->
        not_composite?
    end
  end
end
