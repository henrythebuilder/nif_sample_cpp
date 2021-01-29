cmake_minimum_required(VERSION 3.10)

project(nif_sample_cpp)

set(NIF_SRC "src")

message( "NIF_SRC set to ${NIF_SRC}")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "-O2 -Wall -Wextra -Werror -Wno-unused-parameter -std=c++2a -pedantic")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "-fPIC -shared")

set(OUTPUT_PRIV "$ENV{MIX_APP_PATH}/priv")
file(MAKE_DIRECTORY ${OUTPUT_PRIV})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${OUTPUT_PRIV})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${OUTPUT_PRIV})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${OUTPUT_PRIV})
message( "Output 'priv' set to ${OUTPUT_PRIV}")

include_directories(${NIF_SRC} $ENV{ERL_EI_INCLUDE_DIR})
link_directories($ENV{ERL_EI_LIBDIR})

set(VERBOSE TRUE)
set(CMAKE_VERBOSE_MAKEFILE TRUE)

# Disable CMake auto add `lib` prefix when using `add_library`
# SET_TARGET_PROPERTIES(name PROPERTIES PREFIX "")

add_library(sample_term SHARED ${NIF_SRC}/sample_term.cpp ${NIF_SRC}/nif_tool.cpp)
add_library(sample_list SHARED ${NIF_SRC}/sample_list.cpp ${NIF_SRC}/nif_tool.cpp)
add_library(sample_resource SHARED ${NIF_SRC}/sample_resource.cpp ${NIF_SRC}/nif_tool.cpp)
