defmodule Username do
  @ascii_upper_limit ?z
  @ascii_lower_limit ?a
  @german_characters 'äöüß'

  def sanitize(username) do
    do_sanitize(username, '')
  end

  defp do_sanitize([], acc), do: Enum.reverse(acc)

  defp do_sanitize([letter | tail], acc) do
    acc =
      case letter do
        ?_ ->
          [letter | acc]

        _ when letter in @german_characters ->
          (letter |> german_to_latin |> Enum.reverse()) ++ acc

        _ when letter > @ascii_upper_limit ->
          acc

        _ when letter < @ascii_lower_limit ->
          acc

        _ ->
          [letter | acc]
      end

    do_sanitize(tail, acc)
  end

  defp german_to_latin(letter) when letter in @german_characters do
    case letter do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
    end
  end
end
