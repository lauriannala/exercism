defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) do
    downcased = String.downcase(word)
    consonant? = starts_with_consonant?(downcased)

    %{
      vowel?: starts_with_vowel?(downcased) or starts_with_x_or_y_with_followed?(downcased),
      consonant?: consonant?,
      qu?: starts_with_qu?(downcased),
      qu_with_preceding?: consonant? and starts_with_qu_and_preceding?(downcased)
    }
    |> do_translate(word)
  end

  def do_translate(%{qu_with_preceding?: true}, word) do
    <<preceding::utf8, _::utf8, _::utf8>> <> rest = word
    translate_word(rest <> <<preceding::utf8>> <> "qu")
  end

  def do_translate(%{qu?: true}, word) do
    <<_::utf8, _::utf8>> <> rest = word
    translate_word(rest <> "qu")
  end

  def do_translate(%{vowel?: true}, word) do
    word <> "ay"
  end

  def do_translate(%{consonant?: true}, word) do
    <<first::utf8>> <> rest = word
    translate_word(rest <> <<first::utf8>>)
  end

  def starts_with_x_or_y_with_followed?("x" <> followed), do: starts_with_consonant?(followed)

  def starts_with_x_or_y_with_followed?("y" <> followed), do: starts_with_consonant?(followed)

  def starts_with_x_or_y_with_followed?(_), do: false

  def starts_with_qu_and_preceding?(<<_::utf8>> <> rest), do: starts_with_qu?(rest)
  def starts_with_qu?(word), do: String.starts_with?(word, "qu")

  def starts_with_vowel?(word) do
    "aeiou" =~ String.first(word)
  end

  def starts_with_consonant?(word) do
    "bcdfghklmnpqrstxzy" =~ String.first(word)
  end
end
