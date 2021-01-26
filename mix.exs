defmodule NifSampleCpp.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github_source_url "https://github.com/henrythebuilder/nif_sample_cpp"
  @homepage_url @github_source_url

  def project do
    [
      app: :nif_sample_cpp,
      version: "0.1.0",
      elixir: "~> 1.12-dev",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      source_url: @github_source_url,
      homepage_url: @homepage_url,
      deps: deps(),
      docs: docs(),
      aliases: [docs: ["docs", &copy_extra/1]],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls],
      compilers: [:elixir_make] ++ Mix.compilers(),
      make_targets: ["all"],
      make_clean: ["clean"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def description() do
    "An helper/test library to 'working' with 'nif' from Elixir"
  end

  def package() do
    %{
      licenses: ["Apache 2.0 (Check NOTICE and LICENSE project files for details)"],
      maintainers: ["Enrico Rivarola <henrythebuilder@yahoo.it>"],
      files: [
        "lib",
        "mix.exs",
        "NOTICE",
        "LICENSE",
        "CHANGELOG.md",
        "README.md",
        ".formatter.exs",
        "src/*.[ch]",
        "Makefile"
      ],
      links: %{"GitHub" => @github_source_url}
    }
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_make, "~> 0.4", runtime: false},
      {:ex_doc, "~> 0.22", only: :docs, runtime: false},
      {:excoveralls, "~> 0.12", only: [:test]}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md", "LICENSE", "NOTICE"],
      source_ref: "v#{@version}",
      source_url: @github_source_url
    ]
  end

  defp copy_extra(_) do
    File.cp("LICENSE", "doc/LICENSE")
    File.cp("NOTICE", "doc/NOTICE")
  end
end

# SPDX-License-Identifier: Apache-2.0
