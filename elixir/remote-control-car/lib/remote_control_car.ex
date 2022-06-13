defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new(nickname \\ "none") do
    %__MODULE__{
      battery_percentage: 100,
      distance_driven_in_meters: 0,
      nickname: nickname
    }
  end

  def display_distance(%__MODULE__{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%__MODULE__{} = remote_car) do
    "Battery at #{remote_car.battery_percentage}%"
  end

  def drive(%__MODULE__{battery_percentage: 0} = remote_car), do: remote_car

  def drive(
        %__MODULE__{battery_percentage: battery, distance_driven_in_meters: distance} = remote_car
      ) do
    %__MODULE__{
      remote_car
      | battery_percentage: battery - 1,
        distance_driven_in_meters: distance + 20
    }
  end
end
