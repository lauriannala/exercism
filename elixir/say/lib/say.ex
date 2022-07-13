defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number)

  def in_english(number) when number < 0, do: {:error, "number is out of range"}
  def in_english(number) when number >= 1_000_000_000_000, do: {:error, "number is out of range"}

  def in_english(number) do
    result =
      number
      |> Integer.digits()
      |> Enum.reverse()
      |> Stream.chunk_every(3)
      |> Stream.with_index()
      |> Enum.reverse()
      |> Stream.map(fn {values, index} -> {index, Enum.reverse(values)} end)
      |> Stream.map(&translate/1)
      |> Stream.filter(&(&1 != ""))
      |> Enum.join(" ")

    {:ok, result}
  end

  defp translate([0, 0]), do: ""

  defp translate([0, n]), do: translate([n])

  defp translate([0, n, m]), do: translate([n, m])

  defp translate([n, 0, 0]), do: translate([n]) <> " hundred"

  defp translate({_, [0, 0]}), do: ""

  defp translate({index, [_ | _] = digits}) do
    digits = translate(digits)

    cond do
      digits == "" -> ""
      index == 0 -> digits
      index == 1 -> digits <> " thousand"
      index == 2 -> digits <> " million"
      index == 3 -> digits <> " billion"
    end
  end

  defp translate([n, tens, ones]) do
    translate([n]) <> " hundred " <> translate([tens, ones])
  end

  defp translate([1, _] = two_digits) do
    case Integer.undigits(two_digits) do
      10 -> "ten"
      11 -> "eleven"
      12 -> "twelve"
      13 -> "thirteen"
      14 -> "fourteen"
      15 -> "fifteen"
      16 -> "sixteen"
      17 -> "seventeen"
      18 -> "eighteen"
      19 -> "nineteen"
    end
  end

  defp translate([digit]) do
    case digit do
      0 -> "zero"
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"
    end
  end

  defp translate([tens, n]) do
    prefix =
      case tens do
        2 -> "twenty"
        3 -> "thirty"
        4 -> "forty"
        5 -> "fifty"
        6 -> "sixty"
        7 -> "seventy"
        8 -> "eighty"
        9 -> "ninety"
      end

    if n == 0 do
      prefix
    else
      prefix <> "-" <> translate([n])
    end
  end
end
