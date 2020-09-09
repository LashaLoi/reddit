defmodule Reddit.Guardian do
  use Guardian, otp_app: :reddit

  def subject_for_token(nil, _), do: {:error, :reason_for_error}
  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  def resource_from_claims(nil), do: {:error, :reason_for_error}
  def resource_from_claims(claims), do: {:ok, claims["sub"]}
end
