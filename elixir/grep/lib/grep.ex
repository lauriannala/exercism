defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    get_lines(files)
    |> Enum.map(fn {file, lines} ->
      matches =
        lines
        |> Enum.with_index()
        |> filter(pattern, flags)
        |> Enum.map(&maybe_with_ln(&1, flags))
        |> Enum.map(&maybe_with_filename(&1, file, files))
        |> Enum.map(&(&1 <> "\n"))

      result =
        cond do
          "-l" in flags and matches != [] -> [file <> "\n"]
          "-l" in flags -> []
          true -> matches
        end

      result
    end)
    |> Enum.join()
  end

  defp get_lines(files) when is_list(files) do
    for file <- files do
      lines =
        file
        |> File.read!()
        |> String.split("\n")
        |> Enum.filter(&(&1 != ""))

      {file, lines}
    end
  end

  defp filter(lines, pattern, flags) do
    regex =
      if "-i" in flags do
        Regex.compile!(pattern, "i")
      else
        Regex.compile!(pattern)
      end

    Enum.filter(lines, fn {line, _ln} ->
      cond do
        "-v" in flags ->
          not Regex.match?(regex, line)

        "-x" in flags and "-i" in flags ->
          String.upcase(line) == String.upcase(pattern)

        "-x" in flags ->
          line == pattern

        true ->
          Regex.match?(regex, line)
      end
    end)
  end

  defp maybe_with_ln({val, ln} = _line, flags) do
    if "-n" in flags do
      "#{ln + 1}:#{val}"
    else
      val
    end
  end

  defp maybe_with_filename(line, file, files) when is_list(files) and length(files) > 1 do
    "#{file}:#{line}"
  end

  defp maybe_with_filename(line, _, files) when is_list(files) do
    line
  end
end
