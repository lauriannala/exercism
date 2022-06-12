defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path = String.split(path, ".")
    Enum.reduce(path, data, & &2[&1])
  end

  def get_in_path(data, path) do
    path = String.split(path, ".")
    Kernel.get_in(data, path)
  end
end
