defmodule LogParser do
  @valid ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/
  @split_by ~r/<(~|-|\*|=)*>/

  def valid_line?(line) do
    Regex.match?(@valid, line)
  end

  def split_line(line) do
    String.split(line, @split_by)
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
  end
end
