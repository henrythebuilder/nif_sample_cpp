defmodule NifSampleCpp.Nif.SampleList do
  require Logger

  @on_load :load_nifs

  app = Mix.Project.config()[:app]

  def load_nifs do
    nif_path = :filename.join(:code.priv_dir(unquote(app)), 'sample_list')

    case :erlang.load_nif(nif_path, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn("Failed to load NIF: #{inspect(reason)}")
    end
  end

  @doc """
  Pass a 'list of integer argument' to nif and return the same value

  iex> [-1,2,3,4,5,0] = NifSampleCpp.Nif.SampleList.hello_list_of_int([-1,2,3,4,5,0])
  """
  @spec hello_list_of_int(list(integer())) :: list(integer())
  def hello_list_of_int(_list) do
    :erlang.nif_error(:nif_not_loaded)
  end
end

# SPDX-License-Identifier: Apache-2.0
