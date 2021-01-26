#include "nif_tool.h"
#include "erl_nif.h"
#include <cstdint>
#include <vector>

ERL_NIF_TERM extract_int_term(ErlNifEnv *env, ERL_NIF_TERM term) {
  int64_t n64 = 0;
  uint64_t un64 = 0;

  if (enif_get_uint64(env, term, &un64))
    return enif_make_uint64(env, un64);
  if (enif_get_int64(env, term, &n64))
    return enif_make_int64(env, n64);
  return enif_make_badarg(env);
}

// SPDX-License-Identifier: Apache-2.0
