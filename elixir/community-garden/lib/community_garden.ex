# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {[], 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {state, _} -> state end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {state, index} ->
      plot = %Plot{plot_id: index + 1, registered_to: register_to}

      {plot, {[plot | state], index + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {state, index} ->
      state = Enum.reject(state, &(&1.plot_id == plot_id))
      {state, index}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {state, _} ->
      Enum.find(state, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
    end)
  end
end
