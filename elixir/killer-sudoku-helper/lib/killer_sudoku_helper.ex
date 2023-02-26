defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(%{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) do
    case size do
      1 -> [[sum]]
      _ -> combinations(exclude, size, sum)
    end
  end

  @spec combinations(integer, integer, integer) :: [[integer]]
  defp combinations(exclude, size, sum) do
    1..9
    |> Enum.to_list()
    |> combine(9, size, [], [])
    |> Stream.filter(fn permutation ->
      Enum.sum(permutation) == sum && Enum.all?(permutation, &(&1 not in exclude))
    end)
    |> Stream.map(fn permutation -> Enum.sort(permutation) end)
    |> Enum.sort_by(&hd(&1))
  end

  defp combine(_list, _list_length, 0, _pick_acc, _acc), do: [[]]
  defp combine(list, _list_length, 1, _pick_acc, _acc), do: list

  defp combine(list, list_length, size, pick_acc, acc) do
    list
    |> Stream.unfold(fn [head | tail] -> {{head, tail}, tail} end)
    |> Enum.take(list_length)
    |> Enum.reduce(acc, fn {current, sublist}, acc ->
      new_pick_acc = [current | pick_acc]

      if Enum.count(new_pick_acc) == size do
        [new_pick_acc | acc]
      else
        combine(sublist, Enum.count(sublist), size, new_pick_acc, acc)
      end
    end)
  end
end
