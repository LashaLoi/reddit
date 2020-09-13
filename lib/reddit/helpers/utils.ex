defmodule Reddit.Helpers.Utils do
  import Ecto.Query, warn: false

  def add_resource_if_exists(query, params, key) do
    case Keyword.has_key?(params, key) do
      true ->
        from(u in query,
          join: p in assoc(u, ^key),
          preload: [{^key, p}]
        )

      false ->
        query
    end
  end
end
