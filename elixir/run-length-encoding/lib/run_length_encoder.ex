defmodule RunLengthEncoder do
  @digits ?0..?9

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.to_charlist()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn [key | _] = values ->
      count = Enum.count(values)

      if count != 1 do
        Integer.to_string(count) <> List.to_string([key])
      else
        List.to_string([key])
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.to_charlist()
    |> Enum.chunk_by(fn
      char when char in @digits ->
        :digit

      alpha ->
        alpha
    end)
    |> Enum.map(fn
      [char | _] = list when char in @digits ->
        List.to_integer(list)

      [alpha] ->
        List.to_string([alpha])
    end)
    |> Enum.reduce([], fn
      alpha, [count | acc] when is_binary(alpha) and is_integer(count) ->
        [String.duplicate(alpha, count) | acc]

      char, acc ->
        [char | acc]
    end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
