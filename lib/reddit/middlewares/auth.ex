defmodule Reddit.Middlewares.Auth do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    case resolution.context do
      %{id: _} ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end
end
