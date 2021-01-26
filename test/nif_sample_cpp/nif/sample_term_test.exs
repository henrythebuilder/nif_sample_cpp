defmodule NifSampleCpp.Nif.SampleTermTest do
  use ExUnit.Case

  doctest NifSampleCpp.Nif.SampleTerm

  alias NifSampleCpp.Nif

  describe "nif sample init test:" do
    test "greets the sample" do
      assert Nif.SampleTerm.hello() == 'World !!!'
    end
  end

  describe "nif 'integer' test:" do
    test "positive integer" do
      assert Nif.SampleTerm.hello_int(12345) == 12345
      big_uint = 18_446_744_073_709_551_615
      big_int = 9_223_372_036_854_775_807
      assert Nif.SampleTerm.hello_int(big_uint) == big_uint
      assert Nif.SampleTerm.hello_int(big_int) == big_int
    end

    test "negative integer" do
      assert Nif.SampleTerm.hello_int(-12345) == -12345
      min_int = -9_223_372_036_854_775_806
      assert Nif.SampleTerm.hello_int(min_int) == min_int
    end

    test "bad args" do
      assert_raise ArgumentError, fn ->
        Nif.SampleTerm.hello_int("-12345")
      end
    end
  end

  describe "nif 'float' test:" do
    test "simple float" do
      f = 3.1415926535
      assert Nif.SampleTerm.hello_float(f) == f
    end
  end

end

# SPDX-License-Identifier: Apache-2.0
