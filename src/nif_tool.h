#ifndef NIF_TOOL_INCLUDED
#  define NIF_TOOL_INCLUDED
#  include "erl_nif.h"
#  include <string>

ERL_NIF_TERM extract_int_term(ErlNifEnv *env, ERL_NIF_TERM term);

ERL_NIF_TERM make_tuple_error(ErlNifEnv *env, const std::string text);

ERL_NIF_TERM make_tuple_error(ErlNifEnv *env, const std::string text, const int n);

#endif // NIF_TOOL_INCLUDED

// SPDX-License-Identifier: Apache-2.0
