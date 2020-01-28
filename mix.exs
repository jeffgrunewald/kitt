defmodule Kitt.MixProject do
  use Mix.Project

  def project() do
    [
      app: :kitt,
      version: "0.3.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      description: description(),
      source_url: "https://github.com/jeffgrunewald/kitt",
      dialyzer: [plt_file: {:no_warn, ".dialyzer/#{System.version()}.plt"}]
    ]
  end

  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps() do
    [
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.21.0", only: :dev},
      {:jason, "~> 1.1"}
    ]
  end

  defp description(), do: "Encoder and decoder for DSRC messages defined by the J2735 standard."

  defp package() do
    [
      maintainers: ["jeffgrunewald"],
      licenses: ["Apache 2.0"],
      links: %{:GitHub => "https://github.com/jeffgrunewald/kitt"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      source_url: "https://github.com/jeffgrunewald/kitt",
      extras: [
        "README.md"
      ]
    ]
  end
end
