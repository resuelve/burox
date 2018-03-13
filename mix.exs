defmodule Burox.Mixfile do
  use Mix.Project

  def project do
    [
      app: :burox,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo,                    "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:ex_doc,                   "~> 0.16", only: :dev, runtime: false},
      {:socket,                   "~> 0.3"},
      {:mox,                     "~> 0.3", only: :test}
    ]
  end
end
