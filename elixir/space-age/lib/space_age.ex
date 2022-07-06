defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    age =
      case planet do
        :earth -> age_on_earth(seconds)
        :mercury -> age_on_earth(seconds) / 0.2408467
        :venus -> age_on_earth(seconds) / 0.61519726
        :mars -> age_on_earth(seconds) / 1.8808158
        :jupiter -> age_on_earth(seconds) / 11.862615
        :saturn -> age_on_earth(seconds) / 29.447498
        :uranus -> age_on_earth(seconds) / 84.016846
        :neptune -> age_on_earth(seconds) / 164.79132
        _ -> {:error, "not a planet"}
      end

    case age do
      {:error, _} = error -> error
      _ -> {:ok, age}
    end
  end

  defp age_on_earth(seconds) do
    seconds / 31_557_600
  end
end
