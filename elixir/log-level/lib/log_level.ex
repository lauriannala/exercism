defmodule LogLevel do
  def to_label(_level = 0, _legacy? = false), do: :trace
  def to_label(_level = 1, _legacy?), do: :debug
  def to_label(_level = 2, _legacy?), do: :info
  def to_label(_level = 3, _legacy?), do: :warning
  def to_label(_level = 4, _legacy?), do: :error
  def to_label(_level = 5, _legacy? = false), do: :fatal
  def to_label(_level, _legacy?), do: :unknown

  def alert_recipient(level, legacy?) do
    case to_label(level, legacy?) do
      :error -> :ops
      :fatal -> :ops
      :unknown when legacy? == true -> :dev1
      :unknown when legacy? == false -> :dev2
      _ -> false
    end
  end
end
