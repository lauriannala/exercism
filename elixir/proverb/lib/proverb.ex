defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings)

  def recite([]), do: ""

  def recite([head | _] = strings) do
    strings = rows(strings, [])

    ["And all for the want of a #{head}.\n" | strings]
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp rows([_], acc), do: acc

  defp rows([want, lost | tail], acc) do
    acc = [template(want, lost) | acc]
    rows([lost | tail], acc)
  end

  defp template(want, lost), do: "For want of a #{want} the #{lost} was lost."
end
