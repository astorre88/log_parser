defmodule LogParser.MixProject do
  use Mix.Project

  def project do
    [
      app: :log_parser,
      version: "0.0.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      elixirc_paths: ["lib", "fixtures"],
      name: "LogParser",
      source_url: "https://github.com/astorre88/log_parser"
    ]
  end

  defp description do
    """
    The library for grep large files using CPU cores simultaneously.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Dmitry Vysotsky"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/astorre88/log_parser"}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:flow, "~> 0.14"},

      # Code style
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},

      # Docs
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},

      # Test coverage
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end
end
