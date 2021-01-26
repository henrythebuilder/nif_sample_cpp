defmodule NifSampleCpp.Nif.SampleListTest do
  use ExUnit.Case

  doctest NifSampleCpp.Nif.SampleList

  alias NifSampleCpp.Nif

  describe "test argument list" do
    test "as list of int" do
      list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
      assert Nif.SampleList.hello_list_of_int(list) == list
    end

    test "as list of min/max int" do
      min_int = -9_223_372_036_854_775_806
      big_uint = 18_446_744_073_709_551_615
      big_int = 9_223_372_036_854_775_807
      list = [0, min_int, big_uint, big_int, 1]
      assert Nif.SampleList.hello_list_of_int(list) == list
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
