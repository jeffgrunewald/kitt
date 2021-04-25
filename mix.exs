defmodule Kitt.MixProject do
  use Mix.Project

  @github "https://github.com/jeffgrunewald/kitt"

  def project() do
    [
      app: :kitt,
      version: "0.4.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      description: description(),
      homepage_url: @github,
      source_url: @github,
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
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev},
      {:jason, "~> 1.2"}
    ]
  end

  defp description(), do: "Encoder and decoder for DSRC messages defined by the J2735 standard."

  defp package() do
    [
      maintainers: ["jeffgrunewald"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => @github}
    ]
  end

  defp docs() do
    [
      source_url: @github,
      extras: ["README.md"],
      source_url_pattern: "#{@github}/blob/master/%{path}#L%{line}"
    ]
  end
end
