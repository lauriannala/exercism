defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([_ | list]) do
    list
  end

  def first([head | _]) do
    head
  end

  def count(list) do
    length(list)
  end

  def functional_list?([]), do: false
  def functional_list?(["Elixir" | _tail]), do: true
  def functional_list?([_ | tail]), do: functional_list?(tail)
end
