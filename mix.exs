defmodule Cluster.Mixfile do
  use Mix.Project

  @version "3.1.1"
  @source_url "https://github.com/bitwalker/libcluster"

  def project do
    [app: :libcluster,
     version: @version,
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Automatic Erlang cluster formation and management for Elixir/Erlang applications",
     package: package(),
     docs: docs(),
     deps: deps(),
     elixirc_paths: elixirc_paths(Mix.env),
     dialyzer: [
        flags: ~w(-Wunmatched_returns -Werror_handling -Wrace_conditions -Wno_opaque -Wunderspecs)
     ],
     preferred_cli_env: [
       vcr: :test,
       "vcr.delete": :test,
       "vcr.check": :test,
       "vcr.show": :test,
     ]
    ]
  end

  def application do
    [applications: [:logger, :inets, :jason, :crypto, :ssl]]
  end

  defp deps do
    [{:ex_doc, "~> 0.20.0", only: :dev},
     {:dialyxir, "~> 0.5.1", only: :dev},
     {:exvcr, "~> 0.10.3", only: :test},
     {:jason, "~> 1.1.2"}]
  end

  defp package do
    [files: ["lib", "mix.exs", "README.md", "LICENSE.md"],
     maintainers: ["Paul Schoenfelder"],
     licenses: ["MIT"],
     links: %{"GitHub": @source_url}]
  end

  defp docs do
    [main: "readme",
     source_url: @source_url,
     source_ref: "v#{@version}",
     formatter_opts: [gfm: true],
     extras: [
       "README.md"
     ]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
