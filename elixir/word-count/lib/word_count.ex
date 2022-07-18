defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^\p{L}\d\-']+/u)
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(&(&1 |> String.trim_leading("'") |> String.trim_trailing("'")))
    |> Enum.group_by(& &1)
    |> Stream.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> Map.new()
  end
end
