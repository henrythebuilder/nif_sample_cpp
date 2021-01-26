#include "erl_nif.h"
#include <cstdint>

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

static ErlNifFunc nif_funcs[] = {
    {"hello", 0, hello, 0},
    {"hello_int", 1, hello_int, 0},
    {"hello_float", 1, hello_float, 0},
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
