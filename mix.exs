defmodule TwPhoenixUi.MixProject do
  use Mix.Project

  @version "0.7.0"

  def project do
    [
      app: :tw_phoenix_ui,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "An authentication system generator for Phoenix 1.5",
      docs: docs(),
      deps: deps(),
      package: package()
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
      # Docs dependencies
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp docs do
    [
      main: "overview",
      source_ref: "v#{@version}",
      source_url: "https://github.com/jamesnjovu/tw_phoenix_components",
    ]
  end

  defp package do
    [
      maintainers: ["James Njovu"],
      licenses: [],
      links: %{"GitHub" => "https://github.com/jamesnjovu/tw_phoenix_components"}
    ]
  end
end
