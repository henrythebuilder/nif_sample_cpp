defmodule NifSampleCpp.Nif.SampleResourceTest do
  use ExUnit.Case

  doctest NifSampleCpp.Nif.SampleResource

  alias NifSampleCpp.Nif

  describe "Using resource" do
    test "create resource" do
      _res = Nif.SampleResource.create_test_resource(0, 'create resource')
    end

    test "managing resource" do
      res1 = Nif.SampleResource.create_test_resource(1, 'managing resource - one time')
      res2 = Nif.SampleResource.create_test_resource(2, 'managing resource - two times')
      assert Nif.SampleResource.use_test_resource(res1) == {1, 'managing resource - one time'}
      assert Nif.SampleResource.use_test_resource(res2) == {2, 'managing resource - two times'}

      Nif.SampleResource.free_test_resource(res1)
      Nif.SampleResource.free_test_resource(res2)
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
