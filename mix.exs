defmodule MLLP.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_mllp,
      version: String.trim(File.read!("./VERSION")),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: dialyzer_opts(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MLLP.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:telemetry, "~> 0.4.3"},
      {:ranch, "~> 1.7.1"},
      {:elixir_hl7, "~> 0.6.0"},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:mix_test_watch, "~> 1.0.2", only: :dev, runtime: false},
      {:mox, "~> 1.0.0", only: :test},
      {:excoveralls, "~> 0.14.0", only: :test, runtime: false},
      {:private, "~> 0.1.1", runtime: false}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp dialyzer_opts do
    [
      remove_defaults: [:unknown],
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/mllp.plt"}
    ]
  end
end
