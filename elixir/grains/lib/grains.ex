defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) do
    if number < 1 or number > 64 do
      {:error, "The requested square must be between 1 and 64 (inclusive)"}
    else
      {:ok, Integer.pow(2, number - 1)}
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok,
     1..64
     |> Stream.map(&square/1)
     |> Enum.reduce(0, fn
       {:ok, result}, acc -> acc + result
     end)}
  end
end
