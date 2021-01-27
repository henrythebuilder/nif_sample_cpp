defmodule NifSampleCpp.Nif.SampleResource do
  require Logger

  @on_load :load_nifs

  app = Mix.Project.config()[:app]

  def load_nifs do
    nif_path = :filename.join(:code.priv_dir(unquote(app)), 'sample_resource')

    case :erlang.load_nif(nif_path, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn("Failed to load NIF: #{inspect(reason)}")
    end
  end

  @doc """
  Create a 'test' resource in 'nif' (id, text)

  iex> _nif_resource = NifSampleCpp.Nif.SampleResource.create_test_resource(1234, 'create doctest resource')
  """
  @spec create_test_resource(integer(), binary()) :: reference()
  def create_test_resource(_id, _text) do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Use the 'test' resource created in 'nif'

  iex> id = 4334
  iex> text = 'use doctest resource'
  iex> nif_resource = NifSampleCpp.Nif.SampleResource.create_test_resource(id, text)
  iex> {^id, ^text} = NifSampleCpp.Nif.SampleResource.use_test_resource(nif_resource)
  iex>
  """
  def use_test_resource(_res) do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Use the 'test' resource created in 'nif' as map

  iex> id = 4321
  iex> text = 'use doctest resource as map'
  iex> nif_resource = NifSampleCpp.Nif.SampleResource.create_test_resource(id, text)
  iex> %{^id => ^text} =  NifSampleCpp.Nif.SampleResource.use_test_resource_as_map(nif_resource)
  iex>
  """
  def use_test_resource_as_map(_res) do
    :erlang.nif_error(:nif_not_loaded)
  end

  @doc """
  Free the 'test' resource created in 'nif'

  iex> nif_resource = NifSampleCpp.Nif.SampleResource.create_test_resource(4321, 'free doctest resource')
  iex> NifSampleCpp.Nif.SampleResource.free_test_resource(nif_resource)
  """
  def free_test_resource(_res) do
    :erlang.nif_error(:nif_not_loaded)
  end
end

# SPDX-License-Identifier: Apache-2.0
