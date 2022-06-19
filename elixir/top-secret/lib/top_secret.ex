defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    acc =
      case ast do
        {definition, _, [{:when, _, inner} | _]} when definition == :def or definition == :defp ->
          {_, acc} = decode_secret_message_part({definition, [], inner}, acc)
          acc

        {definition, _, [{function_name, _, params} | _]}
        when definition == :def or definition == :defp ->
          extract_function(function_name, acc, params)

        _ ->
          acc
      end

    {ast, acc}
  end

  defp extract_function(_, acc, params) when is_nil(params), do: ["" | acc]
  defp extract_function(_, acc, params) when length(params) == 0, do: ["" | acc]

  defp extract_function(function_name, acc, params) do
    function_name =
      function_name
      |> Atom.to_string()
      |> String.slice(0, length(params))

    [function_name | acc]
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> walk_ast()
  end

  defp walk_ast(ast) do
    {_, acc} =
      Macro.prewalk(ast, [], fn node, acc ->
        decode_secret_message_part(node, acc)
      end)

    acc |> Enum.reverse() |> Enum.join()
  end
end
