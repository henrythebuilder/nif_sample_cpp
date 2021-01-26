#include "erl_nif.h"
#include <cstdint>
#include <vector>

static ERL_NIF_TERM hello(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_string(env, "World !!!", ERL_NIF_LATIN1);
}

static ERL_NIF_TERM hello_int(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  ERL_NIF_TERM term = argv[0];

  int64_t n64 = 0;
  uint64_t un64 = 0;

  if (enif_get_uint64(env, term, &un64))
    return enif_make_uint64(env, un64);
  if (enif_get_int64(env, term, &n64))
    return enif_make_int64(env, n64);
  return enif_make_badarg(env);
}

static ERL_NIF_TERM hello_float(ErlNifEnv *env, int argc,
                                const ERL_NIF_TERM argv[]) {
  ERL_NIF_TERM term = argv[0];
  double dd;
  if (enif_get_double(env, term, &dd))
    return enif_make_double(env, dd);
  return enif_make_badarg(env);
}

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
    int actual_value = 0;
    if (!enif_get_int(env, head, &actual_value)) {
      return enif_make_badarg(env);
    }
    terms.push_back(enif_make_int(env, actual_value));
  }

  return enif_make_list_from_array(env, terms.data(), terms.size());
}

static ErlNifFunc nif_funcs[] = {
    {"hello", 0, hello, 0},
    {"hello_int", 1, hello_int, 0},
    {"hello_float", 1, hello_float, 0},
    {"hello_list_of_int", 1, hello_list_of_int, 0},
};

static int load(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) { return 0; }

static int reload(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) { return 0; }

static int upgrade(ErlNifEnv *env, void **priv, void **old_priv,
                   ERL_NIF_TERM info) {
  return load(env, priv, info);
}

static void unload(ErlNifEnv *env, void *priv) {}

ERL_NIF_INIT(Elixir.NifSampleCpp.Nif.Sample, nif_funcs, &load, &reload, &upgrade,
             &unload)

// SPDX-License-Identifier: Apache-2.0
