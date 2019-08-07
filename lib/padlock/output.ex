defmodule Padlock.Output do

  @doc """
    Generate a table to output and display the user's details in the CLI.
  """
  def output_user_table(usr) do
    user = usr["name"]
    header = ["Email Address", "Nickname", "ID"]
    rows = [
      [usr["name"], usr["nickname"], usr["sub"]]
    ]

    TableRex.quick_render!(rows, header, user)
    |> IO.puts
  end
end
