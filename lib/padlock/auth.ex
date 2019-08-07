defmodule Padlock.Auth do
  @moduledoc """
    Padlock.Auth handles the call to Auth0 with the inputted User.
  """
  import Joken

  @doc """
    Function chain the process together of signing-in, gathering and verifying the JWT.
  """
  def process_auth(email, password) do
    token = do_auth(email, password)
    |> get_id_token
    |> verify_token

    token.claims
    |> Padlock.Output.output_user_table
  end

  @doc """
    Make the initial call to Auth0 Authentication API with Credentials supplied in Args.
  """
  def do_auth(email, password) do
    body = Poison.encode!(%{"grant_type" => "password", "username" => "#{email}", "password" => "#{password}", "audience" => "[API AUDIENCE]", "scope" => "openid profile", "client_id" => "[CLIENT ID]", "client_secret" => "[CLIENT SECRET]"})

    url = "https://[YOUR_URL].auth0.com/oauth/token"
    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, body, headers, [])
  end

  @doc """
    Strip the ID Token from the JSON response.
  """
  def get_id_token(response) do
    {:ok, res} = response
    r = Poison.decode!(res.body)
    if r["id_token"] do
      r["id_token"]
    else
      raise "Incorrect Username / Password"
    end
  end

  @doc """
    Verify the JWT from Auth0.
  """
  def verify_token(tkn) do
    tkn
    |> token
    |> with_signer(hs256("[CLIENT SECRET]"))
    |> verify
  end

end
