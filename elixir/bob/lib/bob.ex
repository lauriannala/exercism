defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    alpha? = Regex.match?(~r/\p{L}/, input)
    shout? = alpha? and input == String.upcase(input)
    question? = "?" == input |> String.trim() |> String.last()
    empty? = "" == String.trim(input)

    cond do
      shout? and question? -> "Calm down, I know what I'm doing!"
      shout? -> "Whoa, chill out!"
      question? -> "Sure."
      empty? -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
