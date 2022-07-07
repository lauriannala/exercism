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
  end
end
