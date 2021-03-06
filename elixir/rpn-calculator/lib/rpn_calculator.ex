defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      operation.(stack)
      {:ok, "operation completed"}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      operation.(stack)
      {:ok, "operation completed"}
    rescue
      e ->
        case e do
          %{message: message} ->
            {:error, message}

          _ ->
            :error
        end
    end
  end
end
