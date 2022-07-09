defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: %__MODULE__{
          grades: map(),
          names: MapSet.t()
        }
  @enforce_keys [:grades, :names]
  defstruct @enforce_keys

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    %__MODULE__{
      grades: Map.new(),
      names: MapSet.new()
    }
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if MapSet.member?(school.names, name) do
      {:error, school}
    else
      school =
        school
        |> Map.put(:grades, Map.update(school.grades, grade, [name], &[name | &1]))
        |> Map.put(:names, MapSet.put(school.names, name))

      {:ok, school}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school.grades
    |> Map.get(grade, [])
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school.grades
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&(elem(&1, 1) |> Enum.sort()))
    |> List.flatten()
  end
end
