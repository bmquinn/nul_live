defmodule Nul.MixProject do
  use Mix.Project

  def project do
    [
      app: :nul,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nul.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4.0"},
      {:kino, "~> 0.8.0"},
      {:req, "~> 0.3.3"}
    ]
  end
end
