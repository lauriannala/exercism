defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal

  def compare(a, b) do
    cond do
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  def sublist?(_, []), do: false

  def sublist?(l1, [_ | tail] = l2) do
    List.starts_with?(l2, l1) or sublist?(l1, tail)
  end
end
