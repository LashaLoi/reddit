defmodule RedditWeb.UserSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: RedditWeb.Schema

  def connect(_params, socket), do: {:ok, socket}

  def id(_socket), do: nil
end
