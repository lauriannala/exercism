defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram_of?(base, &1))
  end

  def anagram_of?(base, candidate) do
    base = String.downcase(base)
    candidate = String.downcase(candidate)

    base != candidate and sorted(base) == sorted(candidate)
  end

  def sorted(string) do
    string |> String.to_charlist() |> Enum.sort()
  end
end
