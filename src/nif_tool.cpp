#include "nif_tool.h"
#include "erl_nif.h"

ERL_NIF_TERM extract_int_term(ErlNifEnv *env, ERL_NIF_TERM term) {
  int64_t n64 = 0;
  uint64_t un64 = 0;

  if (enif_get_uint64(env, term, &un64))
    return enif_make_uint64(env, un64);
  if (enif_get_int64(env, term, &n64))
    return enif_make_int64(env, n64);
  return enif_make_badarg(env);
}

ERL_NIF_TERM make_tuple_error(ErlNifEnv *env, const std::string text) {
  return enif_make_tuple2(env,
                          enif_make_atom(env, "error"),
                          enif_make_string(env, text.c_str(), ERL_NIF_LATIN1));
}
ERL_NIF_TERM make_tuple_error(ErlNifEnv *env, const std::string text, const int n) {
  return enif_make_tuple3(env,
                          enif_make_atom(env, "error"),
                          enif_make_string(env, text.c_str(), ERL_NIF_LATIN1),
                          enif_make_int64(env, n));
}

// SPDX-License-Identifier: Apache-2.0
