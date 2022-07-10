defmodule IsbnVerifier do
  @regex ~r/^(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d|X)$/

  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn = String.replace(isbn, "-", "")

    if Regex.match?(@regex, isbn) do
      [[_ | groups]] = Regex.scan(@regex, isbn)

      [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10] =
        groups
        |> Enum.with_index()
        |> Enum.map(fn
          {"X", 9} ->
            10

          {val, _} ->
            String.to_integer(val)
        end)

      rem(
        d1 * 10 + d2 * 9 + d3 * 8 + d4 * 7 + d5 * 6 + d6 * 5 + d7 * 4 + d8 * 3 + d9 * 2 + d10 * 1,
        11
      ) == 0
    else
      false
    end
  end
end
