defmodule Padlock.Mixfile do
  use Mix.Project

  def project do
    [
      app: :padlock,
      version: "0.1.1",
      elixir: "~> 1.5",
      escript: [main_module: Padlock],
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :table_rex]
    ]
  end

  defp deps do
    [
      {:table_rex, "~> 0.10"},
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:joken, "~> 1.5"}
    ]
  end
end
