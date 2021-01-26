#include "erl_nif.h"
#include "nif_tool.h"

#include <cstdint>
#include <vector>

static ERL_NIF_TERM hello_list_of_int(ErlNifEnv *env, int argc,
                                      const ERL_NIF_TERM argv[]) {
  unsigned int length = 0;
  ERL_NIF_TERM list_term = argv[0];
  if (!enif_get_list_length(env, list_term, &length)) {
    enif_make_badarg(env);
  }

  ERL_NIF_TERM head;
  ERL_NIF_TERM tail;
  ERL_NIF_TERM current_list = list_term;
  std::vector<ERL_NIF_TERM> terms;

  while (length--) {
    if (!enif_get_list_cell(env, current_list, &head, &tail)) {
      return enif_make_badarg(env);
    }
    current_list = tail;
    terms.push_back(extract_int_term(env, head));
  }

  return enif_make_list_from_array(env, terms.data(), terms.size());
}

static ErlNifFunc nif_funcs[] = {
    {"hello_list_of_int", 1, hello_list_of_int, 0},
};

static int load(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) { return 0; }

static int reload(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) { return 0; }

static int upgrade(ErlNifEnv *env, void **priv, void **old_priv,
                   ERL_NIF_TERM info) {
  return load(env, priv, info);
}

static void unload(ErlNifEnv *env, void *priv) {}

ERL_NIF_INIT(Elixir.NifSampleCpp.Nif.SampleList, nif_funcs, &load, &reload,
             &upgrade, &unload)

// SPDX-License-Identifier: Apache-2.0
