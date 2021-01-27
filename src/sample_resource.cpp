#include "erl_nif.h"
#include "nif_tool.h"
#include <array>
#include <iostream>
#include <memory>
#include <sstream>
#include <string>

using namespace std;

#define TEST_RESOURCE_TEXT_SIZE 1024
typedef struct {
  int id;
  char text[TEST_RESOURCE_TEXT_SIZE];

  size_t text_size() { return TEST_RESOURCE_TEXT_SIZE; }

  string label() {
    ostringstream buffer;
    buffer << "TestResource {" << id << ", '" << text << "'}";
    return buffer.str();
  }

  ERL_NIF_TERM get_as_erl_map(ErlNifEnv *env) {
    ERL_NIF_TERM erl_map = enif_make_new_map(env);
    if (!enif_make_map_put(env,
                           erl_map,
                           enif_make_int64(env, id),
                           enif_make_string(env, text, ERL_NIF_LATIN1),
                           &erl_map))
      return make_tuple_error(env, "unable to update map", id);
    return erl_map;
  }
} TestResource;

// Define resource type.
static ErlNifResourceType *test_resource = NULL;

void release_resource(void *obj) {
  TestResource *resource = (TestResource *)obj;
  cout << "release " << resource->label() << endl;
  enif_release_resource(obj);
}

static ERL_NIF_TERM
create_test_resource(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  // Allocate our resource.
  unique_ptr<TestResource, decltype(&release_resource)> resource(
      (TestResource *)enif_alloc_resource(test_resource, sizeof(TestResource)),
      &release_resource);

  if (!enif_get_int(env, argv[0], &resource->id))
    return make_tuple_error(env, "unable to get id (argv[0])");

  int size = enif_get_string(
      env, argv[1], resource->text, resource->text_size(), ERL_NIF_LATIN1);
  if (size <= 0)
    return make_tuple_error(env, "unable to get text (argv[1])", size);

  return enif_make_resource(env, resource.get());
}

static ERL_NIF_TERM resource_to_tuple(ErlNifEnv *env, TestResource &resource) {
  return enif_make_tuple2(env,
                          enif_make_int64(env, resource.id),
                          enif_make_string(env, resource.text, ERL_NIF_LATIN1));
}

static ERL_NIF_TERM
use_test_resource(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  TestResource *resource = nullptr;

  if (!enif_get_resource(env, argv[0], test_resource, (void **)&resource))
    return make_tuple_error(env, "unable to get resource");

  return resource_to_tuple(env, *resource);
}

static ERL_NIF_TERM
use_test_resource_as_map(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  TestResource *resource = nullptr;

  if (!enif_get_resource(env, argv[0], test_resource, (void **)&resource))
    return make_tuple_error(env, "unable to get resource");

  return resource->get_as_erl_map(env);
}

static ERL_NIF_TERM
free_test_resource(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[]) {
  TestResource *resource;
  if (!enif_get_resource(env, argv[0], test_resource, (void **)&resource)) {
    return make_tuple_error(env, "unable to get resource");
  }

  enif_release_resource(resource);

  return enif_make_atom(env, "ok");
}

// Free resource type.
void destroy_test_resource(ErlNifEnv *env, void *obj) {
  TestResource *resource = (TestResource *)obj;
  cout << "destroy " << resource->label() << endl;
  resource->id = -1;
  resource->text[0] = 0;
}

// Allocate resource type
ErlNifResourceType *open_test_resource(ErlNifEnv *env) {

  ErlNifResourceFlags flags =
      (ErlNifResourceFlags)(ERL_NIF_RT_CREATE | ERL_NIF_RT_TAKEOVER);
  return enif_open_resource_type(
      env, NULL, "TestResource", destroy_test_resource, flags, NULL);
}

static ErlNifFunc nif_funcs[] = {
    {"create_test_resource", 2, create_test_resource, 0},
    {"free_test_resource", 1, free_test_resource, 0},
    {"use_test_resource", 1, use_test_resource, 0},
    {"use_test_resource_as_map", 1, use_test_resource_as_map, 0}};

static int load(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) {
  test_resource = open_test_resource(env);
  return 0;
}

static int reload(ErlNifEnv *env, void **priv, ERL_NIF_TERM info) { return 0; }

static int
upgrade(ErlNifEnv *env, void **priv, void **old_priv, ERL_NIF_TERM info) {
  return load(env, priv, info);
}

static void unload(ErlNifEnv *env, void *priv) {}

ERL_NIF_INIT(Elixir.NifSampleCpp.Nif.SampleResource,
             nif_funcs,
             &load,
             &reload,
             &upgrade,
             &unload)

// SPDX-License-Identifier: Apache-2.0
