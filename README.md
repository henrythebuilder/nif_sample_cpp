# NifSampleCpp

A sample project to evaluate the interoperability of Elixir with the native implemented functions (NIFs)

## NIF explained ...

The first attempt is understand value under 'term' through methods 'hello_...', these methods get a 'term', the 'nif' extract the 'native' value and return the value re-coded as new 'term' with the value equal to the original one.

### Play with `term`
...

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nif_sample_cpp` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nif_sample_cpp, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nif_sample_cpp](https://hexdocs.pm/nif_sample_cpp).


## Source code licensing rules

### Author

Copyright © 2020 Enrico Rivarola

### License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[https://spdx.org/licenses/Apache-2.0.html](https://spdx.org/licenses/Apache-2.0.html)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


### License identifier syntax

The license described above applies to the `NifSampleCpp` library source as a whole.

Individual files contain the following tag instead of the full license text:

`SPDX-License-Identifier: Apache-2.0`

Use *SPDX short-form identifiers* enables machine reading/processing of software information as defined in [Software Package Data Exchange® (SPDX®)](https://spdx.org)


*Check [NOTICE](NOTICE) and [LICENSE](LICENSE) project files for more detailed information.*

---


SPDX-License-Identifier: Apache-2.0
