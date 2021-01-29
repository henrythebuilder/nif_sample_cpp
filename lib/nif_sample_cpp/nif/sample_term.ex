defmodule NifSampleCpp.Nif.SampleTerm do
  require Logger

  @on_load :load_nifs

  app = Mix.Project.config()[:app]

  def load_nifs do
    nif_path = :filename.join(:code.priv_dir(unquote(app)), 'libsample_term')

    case :erlang.load_nif(nif_path, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn("Failed to load NIF: #{inspect(reason)}")
    end
  end

  def hello() do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Pass an integer argument to nif and return the same value

  iex> 1024 = NifSampleCpp.Nif.SampleTerm.hello_int(1024)
  iex> -1024 = NifSampleCpp.Nif.SampleTerm.hello_int(-1024)
  iex> 0 = NifSampleCpp.Nif.SampleTerm.hello_int(0)
  """
  @spec hello_int(integer()) :: integer()
  def hello_int(_n) do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Pass a float argument to nif and return the same value

  iex> 3.14 = NifSampleCpp.Nif.SampleTerm.hello_float(3.14)
  iex> -1.001 = NifSampleCpp.Nif.SampleTerm.hello_float(-1.001)
  iex> 0.0 = NifSampleCpp.Nif.SampleTerm.hello_float(0.0)
  """
  @spec hello_float(float()) :: float()
  def hello_float(_f) do
    :erlang.nif_error(:nif_not_loaded)
  end
end

# SPDX-License-Identifier: Apache-2.0
