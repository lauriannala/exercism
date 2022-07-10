defmodule House do
  @template [
    {"lay in", "the house that Jack built."},
    {"ate", "the malt"},
    {"killed", "the rat"},
    {"worried", "the cat"},
    {"tossed", "the dog"},
    {"milked", "the cow with the crumpled horn"},
    {"kissed", "the maiden all forlorn"},
    {"married", "the man all tattered and torn"},
    {"woke", "the priest all shaven and shorn"},
    {"kept", "the rooster that crowed in the morn"},
    {"belonged to", "the farmer sowing his corn"},
    {"", "the horse and the hound and the horn"}
  ]

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    do_recite(start, start, stop, "")
  end

  defp do_recite(start, current, stop, acc) when current == 1 do
    {clause, noun} = get_index(current - 1)
    acc = acc <> prefix(start, current, clause) <> noun <> "\n"

    if stop > start do
      do_recite(start + 1, start + 1, stop, acc)
    else
      acc
    end
  end

  defp do_recite(start, current, stop, acc) do
    {clause, noun} = get_index(current - 1)
    acc = acc <> prefix(start, current, clause) <> noun
    do_recite(start, current - 1, stop, acc)
  end

  defp prefix(start, current, _) when start == current, do: "This is "
  defp prefix(_, _, clause), do: " that " <> clause <> " "

  defp get_index(index) do
    Enum.at(@template, index)
  end
end
