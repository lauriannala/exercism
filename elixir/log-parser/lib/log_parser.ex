defmodule LogParser do
  @valid ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/
  @split_by ~r/<(~|-|\*|=)*>/

  def valid_line?(line), do: Regex.match?(@valid, line)

  def split_line(line), do: String.split(line, @split_by)

  def remove_artifacts(line), do: String.replace(line, ~r/end-of-line\d+/i, "")

  def tag_with_user_name(line) do
    case Regex.scan(~r/User\s+(\S*)/, line) do
      [[_, user]] ->
        "[USER] #{user} #{line}"

      _ ->
        line
    end
  end
end
