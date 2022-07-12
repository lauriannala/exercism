defmodule ResistorColorTrio do
  @band_colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    colors
    |> Enum.map(&@band_colors[&1])
    |> with_zeros()
  end

  defp with_zeros([c1, c2, 0]), do: {Integer.undigits([c1, c2]), :ohms}
  defp with_zeros([c1, c2, 1]), do: {Integer.undigits([c1, c2, 0]), :ohms}
  defp with_zeros([c1, 0, 2]), do: {Integer.undigits([c1]), :kiloohms}
  defp with_zeros([c1, c2, 2]), do: {Integer.undigits([c1, c2, 0]), :ohms}
  defp with_zeros([c1, c2, 3]), do: {Integer.undigits([c1, c2]), :kiloohms}
  defp with_zeros([c1, c2, 4]), do: {Integer.undigits([c1, c2, 0]), :kiloohms}
end
