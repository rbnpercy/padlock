defmodule Padlock do
  @moduledoc """
    CLI client, takes in arguments of Username and Password, and calls Auth0.
  """
  alias Padlock.Auth

  @doc """
    Main function to run when app is called.
  """
  def main(args \\ []) do
    args |> parse_args |> process_args
  end

  @doc """
    Use Elixir's OptionParser to parse the arguments.
  """
  def parse_args(args) do
    opts = OptionParser.parse(args)

    case opts do
      {[email: email, password: password], _, _} -> [email, password]
      _ -> :no_args
    end
  end

  defp process_args([email, password]) do
    Auth.process_auth(email, password)
  end
  defp process_args(:no_args) do
    IO.puts "Insufficient arguments supplied..."
  end
end
