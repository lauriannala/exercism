defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) when is_list(word) do
    downcased = Enum.map(word, &String.downcase/1)
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
    [preceding, _, _ | rest] = word
    translate_word(rest ++ [preceding | ~w(q u)])
  end

  def do_translate(%{qu?: true}, word) do
    [_, _ | rest] = word

    translate_word(rest ++ ~w(q u))
  end

  def do_translate(%{vowel?: true}, word) do
    word ++ ~w(a y)
  end

  def do_translate(%{consonant?: true}, word) do
    [first | rest] = word
    translate_word(rest ++ [first])
  end

  def starts_with_x_or_y_with_followed?(["x" | followed]), do: starts_with_consonant?(followed)

  def starts_with_x_or_y_with_followed?(["y" | followed]), do: starts_with_consonant?(followed)

  def starts_with_x_or_y_with_followed?(_), do: false

  def starts_with_qu_and_preceding?([_ | rest]), do: starts_with_qu?(rest)
  def starts_with_qu?(["q", "u" | _]), do: true
  def starts_with_qu?(_), do: false

  def starts_with_vowel?([first | _]) do
    first in ~w(a e i o u)
  end

  def starts_with_consonant?(word) do
    not starts_with_vowel?(word)
  end
end
