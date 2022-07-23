defmodule AllergyDefinitions do
  import Bitwise

  defmacro __using__(allergies) do
    quote bind_quoted: [allergies: allergies] do
      for {allergy, allergy_flag} <- allergies do
        def allergic_to?(flags, unquote(allergy))
            when band(flags, unquote(allergy_flag)) == unquote(allergy_flag),
            do: true
      end

      @doc """
      Returns whether the corresponding flag bit in 'flags' is set for the item.
      """
      @spec allergic_to?(non_neg_integer, String.t()) :: boolean
      def allergic_to?(_, _), do: false
    end
  end
end

defmodule Allergies do
  @allergies %{
    "eggs" => 0b01,
    "peanuts" => 0b10,
    "shellfish" => 0b01_00,
    "strawberries" => 0b10_00,
    "tomatoes" => 0b0001_0000,
    "chocolate" => 0b0010_0000,
    "pollen" => 0b0100_0000,
    "cats" => 0b1000_0000
  }

  use AllergyDefinitions, @allergies

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @allergies
    |> Map.keys()
    |> Stream.map(fn item ->
      {item, allergic_to?(flags, item)}
    end)
    |> Stream.filter(&elem(&1, 1))
    |> Enum.map(&elem(&1, 0))
  end
end
