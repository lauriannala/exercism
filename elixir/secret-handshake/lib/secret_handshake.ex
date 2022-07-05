defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> wink(code)
    |> double_blink(code)
    |> close_your_eyes(code)
    |> jump(code)
    |> reverse(code)
    |> Enum.reverse()
  end

  def wink(acc, code) when band(code, 0b01) == 0b01 do
    ["wink" | acc]
  end

  def wink(acc, _), do: acc

  def double_blink(acc, code) when band(code, 0b10) == 0b10 do
    ["double blink" | acc]
  end

  def double_blink(acc, _), do: acc

  def close_your_eyes(acc, code) when band(code, 0b100) == 0b100 do
    ["close your eyes" | acc]
  end

  def close_your_eyes(acc, _), do: acc

  def jump(acc, code) when band(code, 0b1000) == 0b1000 do
    ["jump" | acc]
  end

  def jump(acc, _), do: acc

  def reverse(acc, code) when band(code, 0b10000) == 0b10000 do
    Enum.reverse(acc)
  end

  def reverse(acc, _), do: acc
end
