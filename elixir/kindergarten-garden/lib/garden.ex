defmodule Garden do
  @plants %{
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
    "V" => :violets
  }

  @children [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @children) do
    student_names = Enum.sort(student_names)

    groups =
      info_string
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&handle_row(&1, student_names))
      |> Enum.reduce(%{}, fn
        row, acc ->
          Map.merge(acc, row, fn _, plants1, plants2 -> plants1 ++ plants2 end)
      end)
      |> Enum.map(fn {student, plants} ->
        {student, plants |> Enum.map(&@plants[&1]) |> List.to_tuple()}
      end)
      |> Map.new()

    student_names
    |> Map.new(fn student -> {student, {}} end)
    |> Map.merge(groups)
  end

  def handle_row(row, student_names) do
    row
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.map(fn {plants, index} -> {Enum.at(student_names, index), plants} end)
    |> Map.new()
  end
end
