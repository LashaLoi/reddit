defmodule RedditWeb.Subscriptions.Utils do
  def set_topic(topic \\ "*") do
    fn _, _ ->
      {:ok, topic: topic}
    end
  end

  def publish(resource, mutation) do
    Absinthe.Subscription.publish(RedditWeb.Endpoint, resource, mutation)
  end
end
