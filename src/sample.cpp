#include "erl_nif.h"

static ERL_NIF_TERM hello(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  return enif_make_string(env, "World !!!", ERL_NIF_LATIN1);
}
static ErlNifFunc nif_funcs[] = {
    {"hello", 0, hello, 0},
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
