defmodule Middlewares.Fields do
  alias Helpers.GetFields

  def map(nested_key) do
    fn resolution, _ ->
      fields = GetFields.format(resolution.definition.selections, nested_key)

      %{resolution | context: %{resolution.context | fields: fields}}
    end
  end
end
