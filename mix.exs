defmodule NameOfPerson.MixProject do
  use Mix.Project

  def project do
    [
      app: :name_of_person,
      description: "Helper functions for dealing with English-language names.",
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:ex_doc, "~>0.19.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Mitch Stanley"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/acoustep/name_of_person"}
    ]
  end
end
