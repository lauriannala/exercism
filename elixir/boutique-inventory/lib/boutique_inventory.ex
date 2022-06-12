defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      replacement = String.replace(item.name, old_word, new_word)
      %{item | name: replacement}
    end)
  end

  def increase_quantity(item, count) do
    Map.update!(
      item,
      :quantity_by_size,
      fn sizes ->
        sizes |> Map.new(fn {key, val} -> {key, val + count} end)
      end
    )
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_, val}, sum -> sum + val end)
  end
end
