defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Stream.iterate([1], fn [head | _] = list ->
      list = Enum.chunk_every(list, 2, 1)

      Enum.map([[head] | list], &Enum.sum/1)
    end)
    |> Enum.take(num)
  end
end
