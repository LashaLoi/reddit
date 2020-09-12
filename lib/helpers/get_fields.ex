defmodule Helpers.GetFields do
  @inserted_at "insertedAt"
  @updated_at "updatedAt"

  def format(selections, nested_key) do
    selected_fields(selections) |> to_ecto_params(nested_key)
  end

  defp selected_fields(fields), do: Enum.map(fields, &map_selection/1)

  defp map_selection(%{name: name, selections: selections}) do
    case selections do
      [] -> name
      _ -> selected_fields(selections)
    end
  end

  defp to_ecto_params(fields, nested_key) do
    Enum.map(fields, fn field ->
      case is_list(field) do
        true ->
          {nested_key, to_ecto_params(field, nested_key)}

        false ->
          map_key(field)
      end
    end)
  end

  defp map_key(key) when key == @inserted_at, do: :inserted_at
  defp map_key(key) when key == @updated_at, do: :updated_at
  defp map_key(key), do: String.to_atom(key)
end
