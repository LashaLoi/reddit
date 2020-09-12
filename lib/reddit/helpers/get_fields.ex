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
    Enum.reduce(fields, [:id], fn field, acc ->
      cond do
        field == "id" ->
          acc

        is_list(field) == true ->
          add_to_list(acc, {nested_key, to_ecto_params(field, nested_key)})

        is_list(field) == false ->
          add_to_list(acc, field |> map_key())
      end
    end)
  end

  defp map_key(key) when key == @inserted_at, do: :inserted_at
  defp map_key(key) when key == @updated_at, do: :updated_at
  defp map_key(key), do: String.to_atom(key)

  defp add_to_list(list, item), do: List.insert_at(list, -1, item)
end
