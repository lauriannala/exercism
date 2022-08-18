defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?([head | tail]) do
    do_chain(head, tail)
  end

  defp do_chain({match, match}, []), do: true
  defp do_chain(_, []), do: false

  defp do_chain({chain_begin, match}, rest) do
    Stream.map(rest, fn
      {^match, chain_end} = current ->
        do_chain({chain_begin, chain_end}, List.delete(rest, current))

      {chain_end, ^match} = current ->
        do_chain({chain_begin, chain_end}, List.delete(rest, current))

      _ ->
        false
    end)
    |> Enum.any?(& &1)
  end
end
