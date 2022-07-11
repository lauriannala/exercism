defmodule MatchingBrackets do
  defmodule Node do
    @enforce_keys [:type, :position]
    defstruct @enforce_keys

    @type t :: %__MODULE__{
            type: :brackets | :braces | :parentheses,
            position: :start | :end
          }

    @spec new(String.t()) :: t()
    def new(string) when is_binary(string) do
      case string do
        "[" -> %__MODULE__{type: :brackets, position: :start}
        "]" -> %__MODULE__{type: :brackets, position: :end}
        "{" -> %__MODULE__{type: :braces, position: :start}
        "}" -> %__MODULE__{type: :braces, position: :end}
        "(" -> %__MODULE__{type: :parentheses, position: :start}
        ")" -> %__MODULE__{type: :parentheses, position: :end}
      end
    end
  end

  @pair_match ~r/\[|\]|\{|\}|\(|\)/

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&Regex.match?(@pair_match, &1))
    |> Enum.map(&Node.new/1)
    |> iterate([])
  end

  defp iterate([%Node{position: :start} = node | tail], stack) do
    iterate(tail, [node | stack])
  end

  defp iterate([%Node{position: :end} = node | tail], [pair | stack]) do
    if check(pair, node) do
      iterate(tail, stack)
    else
      false
    end
  end

  defp iterate([%Node{position: :end} | _], []), do: false

  defp iterate([], []), do: true

  defp iterate([], [_ | _]), do: false

  defp check(%{type: type, position: :start}, %{type: type, position: :end}), do: true
  defp check(_, _), do: false
end
