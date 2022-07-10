defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/(-| )/, "")
    |> String.downcase()
    |> String.graphemes()
    |> Enum.group_by(& &1)
    |> Enum.map(&Enum.count(elem(&1, 1)))
    |> Enum.all?(&(&1 == 1))
  end
end
