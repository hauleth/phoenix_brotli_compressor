defmodule PhoenixBrotliCompressor.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_brotli_compressor,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.6.0-rc.0 or ~> 1.6"},
      {:brotli, github: "hauleth/erl-brotli", optional: true},
      {:jason, "~> 1.0", only: [:dev, :test]}
    ]
  end
end
