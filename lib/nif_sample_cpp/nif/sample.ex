defmodule NifSampleCpp.Nif.Sample do
  require Logger

  @on_load :load_nifs

  app = Mix.Project.config()[:app]

  def load_nifs do
    nif_path = :filename.join(:code.priv_dir(unquote(app)), 'sample')

    case :erlang.load_nif(nif_path, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn("Failed to load NIF: #{inspect(reason)}")
    end
  end

  def hello() do
    :erlang.nif_error(:nif_not_loaded)
  end

  def hello_int(_n) do
    :erlang.nif_error(:nif_not_loaded)
  end

  def hello_float(_f) do
    :erlang.nif_error(:nif_not_loaded)
  end

  def hello_list_of_int(_list) do
    :erlang.nif_error(:nif_not_loaded)
  end
end

# SPDX-License-Identifier: Apache-2.0
