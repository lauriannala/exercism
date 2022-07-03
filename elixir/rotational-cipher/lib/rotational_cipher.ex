defmodule RotationalCipher do
  @lower_range ?a..?z
  @upper_range ?A..?Z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn char ->
      cond do
        char in @lower_range -> rem(char - ?a + shift, 26) + ?a
        char in @upper_range -> rem(char - ?A + shift, 26) + ?A
        char -> char
      end
    end)
    |> List.to_string()
  end
end
