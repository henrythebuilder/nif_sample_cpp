defmodule NifSampleCpp.Nif.SampleTest do
  use ExUnit.Case

  alias NifSampleCpp.Nif

  describe "nif sample init test:" do
    test "greets the sample" do
      assert Nif.Sample.hello() == 'World !!!'
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
