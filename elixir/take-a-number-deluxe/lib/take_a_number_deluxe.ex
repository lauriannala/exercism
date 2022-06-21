defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
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
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.call(machine, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(opts) do
    min_number = Keyword.get(opts, :min_number)
    max_number = Keyword.get(opts, :max_number)
    auto_shutdown_timeout = Keyword.get(opts, :auto_shutdown_timeout, :infinity)

    case State.new(min_number, max_number, auto_shutdown_timeout) do
      {:ok, state} -> {:ok, state, auto_shutdown_timeout}
      {:error, error} -> {:stop, error}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _, %State{auto_shutdown_timeout: auto_shutdown_timeout} = state) do
    {:reply, state, state, auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(
        :queue_new_number,
        _,
        %State{auto_shutdown_timeout: auto_shutdown_timeout} = state
      ) do
    case State.queue_new_number(state) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(
        {:serve_next_queued_number, priority_number},
        _,
        %State{auto_shutdown_timeout: auto_shutdown_timeout} = state
      ) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, auto_shutdown_timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(:reset_state, _, %State{
        min_number: min_number,
        max_number: max_number,
        auto_shutdown_timeout: auto_shutdown_timeout
      }) do
    {:ok, state} = State.new(min_number, max_number, auto_shutdown_timeout)
    {:reply, :ok, state, auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, %State{auto_shutdown_timeout: auto_shutdown_timeout} = state) do
    {:noreply, state, auto_shutdown_timeout}
  end
end
