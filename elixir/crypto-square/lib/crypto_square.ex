defmodule CryptoSquare do
  import :math, only: [sqrt: 1]

  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    normalized =
      ~r/\s|[^\p{L}|\d]+/
      |> Regex.replace(str, "")
      |> String.downcase()
      |> String.to_charlist()

    dimension =
      normalized
      |> length()
      |> get_dimension()

    chunks =
      normalized
      |> Stream.chunk_every(dimension)
      |> Stream.map(&Enum.with_index/1)
      |> Enum.map(&Map.new(&1, fn {val, key} -> {key, val} end))

    0..(dimension - 1)
    |> Stream.map(fn column ->
      chunks
      |> Enum.map(&(&1[column] || ' '))
      |> List.to_string()
    end)
    |> Stream.reject(&(&1 == ""))
    |> Enum.join(" ")
  end

  @spec get_dimension(integer()) :: integer()
  defp get_dimension(length) do
    length
    |> sqrt()
    |> ceil()
    |> trunc()
  end
end
