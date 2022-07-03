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
    |> Enum.map(fn char ->
      cond do
        char in @digits -> {:digit, char}
        char -> {:alpha, char}
      end
    end)
    |> Enum.chunk_by(fn
      {:alpha, _} = alpha ->
        alpha

      {:digit, _} ->
        :digit
    end)
    |> Enum.map(fn
      [{:digit, _} | _] = list ->
        {:digit, list |> Enum.map(fn {_, val} -> val end) |> List.to_integer()}

      [{:alpha, alpha}] ->
        {:alpha, List.to_string([alpha])}
    end)
    |> Enum.reduce([], fn
      {:alpha, alpha}, [{:digit, count} | acc] ->
        [String.duplicate(alpha, count) | acc]

      {:alpha, alpha}, acc ->
        [alpha | acc]

      {:digit, _} = digit, acc ->
        [digit | acc]
    end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
