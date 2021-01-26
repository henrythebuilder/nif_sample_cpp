defmodule NifSampleCppTest do
  use ExUnit.Case
  doctest NifSampleCpp

  test "greets the world" do
    assert NifSampleCpp.hello() == :world
  end
end

# SPDX-License-Identifier: Apache-2.0
