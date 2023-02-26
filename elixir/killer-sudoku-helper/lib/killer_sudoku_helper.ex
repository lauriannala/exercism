defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(%{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) do
    1..9
    |> Enum.reject(&(&1 in exclude))
    |> combine(size)
    |> Enum.filter(&(Enum.sum(&1) == sum))
  end

  defp combine(_list, 0), do: [[]]
  defp combine([] = list, _n), do: list

  defp combine([head | tail], n) do
    Enum.map(combine(tail, n - 1), fn el -> [head | el] end) ++ combine(tail, n)
  end
end
