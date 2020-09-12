defmodule Helpers.FormatData do
  def format_error(changeset) do
    {_, {message, _}} = hd(changeset.errors)

    {:error, message}
  end

  def format_response(error_message, key) when is_binary(error_message) do
    {:ok, %{key => nil, error_message: error_message}}
  end

  def format_response(resource, key) do
    {:ok, %{key => resource, error_message: nil}}
  end

  def format_graphql_fields([{_, fields}, _]), do: fields
end
