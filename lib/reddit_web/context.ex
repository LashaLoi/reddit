defmodule RedditWeb.Context do
  @behaviour Plug

  alias Reddit.Guardian

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _), do: Absinthe.Plug.put_options(conn, context: build_context(conn))

  defp build_context(conn) do
    token = get_req_header(conn, "x-token")

    case token do
      [] ->
        %{fields: nil}

      _ ->
        {:ok, id, _claims} = Guardian.resource_from_token(hd(token))

        %{id: id, fields: nil}
    end
  end
end
