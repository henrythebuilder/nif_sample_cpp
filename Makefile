CPPFLAGS ?= -O2 -Wall -Wextra -Werror -Wno-unused-parameter -std=c++2a -pedantic
LDFLAGS += -fPIC -shared

CC=g++

# Set Erlang-specific compile and linker flags
ERL_CFLAGS ?= -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS ?= -L$(ERL_EI_LIBDIR) -lei

PREFIX = $(MIX_APP_PATH)/priv
BUILD = $(MIX_APP_PATH)/obj

NIF_TERM = $(PREFIX)/sample_term.so
NIF_TERM_SRC = src/sample_term.cpp src/nif_tool.cpp

NIF_LIST = $(PREFIX)/sample_list.so
NIF_LIST_SRC = src/sample_list.cpp src/nif_tool.cpp

NIF_HEADERS =$(wildcard src/*.h)

$(info "**** MIX_ENV set to [$(MIX_ENV)] ****")
$(info "**** MIX_APP_PATH set to [$(MIX_APP_PATH)] ****")

calling_from_make:
	mix compile

all: install $(NIF_HEADERS) Makefile

install: $(PREFIX) $(BUILD) $(NIF_TERM) $(NIF_LIST)

define COMPILE_NIF
@echo Compiling NIF Library [$@]
$(CC) -o $@ $(ERL_LDFLAGS) $(LDFLAGS) $(CPPFLAGS) $^
endef

$(NIF_TERM): $(NIF_TERM_SRC)
	$(COMPILE_NIF)

$(NIF_LIST): $(NIF_LIST_SRC)
	$(COMPILE_NIF)

$(PREFIX) $(BUILD):
	mkdir -v -p $@

clean:
	$(RM) $(NIF_TERM)

.PHONY: all clean calling_from_make install


# SPDX-License-Identifier: Apache-2.0
