defmodule RedditWeb.Subscriptions.Topic do
  def set_topic(topic \\ "*") do
    fn _, _ ->
      {:ok, topic: topic}
    end
  end
end
