defmodule TwelveDays do
  @verses [
            {"first", "a Partridge in a Pear Tree"},
            {"second", "two Turtle Doves"},
            {"third", "three French Hens"},
            {"fourth", "four Calling Birds"},
            {"fifth", "five Gold Rings"},
            {"sixth", "six Geese-a-Laying"},
            {"seventh", "seven Swans-a-Swimming"},
            {"eighth", "eight Maids-a-Milking"},
            {"ninth", "nine Ladies Dancing"},
            {"tenth", "ten Lords-a-Leaping"},
            {"eleventh", "eleven Pipers Piping"},
            {"twelfth", "twelve Drummers Drumming"}
          ]
          |> Enum.with_index()
          |> Map.new(fn {val, key} -> {key, val} end)

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    {nth, _} = @verses[number - 1]

    gifts =
      1..number
      |> Stream.map(&@verses[&1 - 1])
      |> Enum.map(&elem(&1, 1))
      |> then(fn
        [el] -> [el]
        [head | tail] -> ["and " <> head | tail]
      end)
      |> Enum.reverse()
      |> Enum.join(", ")

    "On the #{nth} day of Christmas my true love gave to me: #{gifts}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
