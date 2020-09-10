defmodule Helpers.FormatResponse do
  def format(error_message, key) when is_binary(error_message) do
    {:ok, %{key => nil, error_message: error_message}}
  end

  def format(resource, key) do
    {:ok, %{key => resource, error_message: nil}}
  end
end
