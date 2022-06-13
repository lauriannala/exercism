defmodule BoutiqueSuggestions do
  @default_opts [maximum_price: 100.00]

  def get_combinations(tops, bottoms, options \\ []) do
    options = Keyword.merge(@default_opts, options)

    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= Keyword.get(options, :maximum_price) do
      {top, bottom}
    end
  end
end
