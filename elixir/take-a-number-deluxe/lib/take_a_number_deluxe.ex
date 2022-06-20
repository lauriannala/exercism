defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(opts) do
    min_number = Keyword.get(opts, :min_number)
    max_number = Keyword.get(opts, :max_number)
    do_start_link(min_number, max_number)
  end

  defp do_start_link(min_number, max_number)
       when is_number(min_number) and is_number(max_number) and
              min_number <= max_number do
    {:ok, state} = State.new(min_number, max_number)
    GenServer.start_link(__MODULE__, state)
  end

  defp do_start_link(_, _) do
    {:error, :invalid_configuration}
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    # Please implement the reset_state/1 function
  end

  # Server callbacks
  def init(%State{} = state) do
    {:ok, state}
  end

  def handle_call(:report_state, _, %State{} = state) do
    {:reply, state, state}
  end

  def handle_call(:queue_new_number, _, %State{} = state) do
    case State.queue_new_number(state) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state}

      {:error, error} ->
        {:reply, {:error, error}, state}
    end
  end
end
