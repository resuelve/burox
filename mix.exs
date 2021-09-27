defmodule Burox.Mixfile do
    use Mix.Project

  def project do
    [
      app: :burox,
      version: "0.3.0",
      package: package(),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: "Burox",
      source_url: "https://github.com/Resuelve/burox",
      homepage_url: "https://github.com/Resuelve/burox",
      docs: [
        main: "Burox"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:socket, "~> 0.3.2"},
      {:mox, "~> 0.4", only: :test},
      {:vex, "~> 0.7"}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      organization: "resuelve",
      description: "Libreria para consulta de buro de credito.",
      maintainers: ["Jorge Medina", "Octavio Juarez"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/resuelve/burox"}
    ]
  end
end
