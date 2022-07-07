defmodule Atbash do
  @cipher Enum.reverse(?a..?z)

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.replace(~r/\s|,|\./, "")
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.map(&Enum.at(@cipher, &1 - ?a, &1))
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(~r/\s/, "")
    |> String.to_charlist()
    |> Enum.map(fn
      char ->
        @cipher
        |> Enum.find_index(&(&1 == char))
        |> then(fn
          nil -> char
          index -> ?a + index
        end)
    end)
    |> List.to_string()
  end
end
