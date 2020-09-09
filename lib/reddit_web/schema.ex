defmodule RedditWeb.Schema do
  use Absinthe.Schema

  query do
    field :hello, :string do
      resolve(fn _root, _args, _info -> {:ok, "world"} end)
    end
  end
end
