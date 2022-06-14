defmodule RPNCalculator.Exception do
  def divide(stack) when length(stack) < 2,
    do: raise(__MODULE__.StackUnderflowError, "when dividing")

  def divide([0 | _]), do: raise(__MODULE__.DivisionByZeroError)
  def divide([x, y | _]), do: y / x

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] ->
          %__MODULE__{}

        _ ->
          %__MODULE__{message: "stack underflow occurred, context: " <> value}
      end
    end
  end
end
