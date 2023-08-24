defmodule TwPhoenixUi.MixProject do
  use Mix.Project

  def project do
    [
      app: :tw_phoenix_ui,
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
      mod: {TwPhoenixUi.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.19.0"},
      {:gettext, "~> 0.20"},
      {:scrivener_ecto, "~> 2.7.0"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
