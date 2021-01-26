CFLAGS ?= -O2 -Wall -Wextra -Wno-unused-parameter -pedantic
LDFLAGS += -fPIC -shared

CC=g++

# Set Erlang-specific compile and linker flags
ERL_CFLAGS ?= -I$(ERL_EI_INCLUDE_DIR)
ERL_LDFLAGS ?= -L$(ERL_EI_LIBDIR) -lei

PREFIX = $(MIX_APP_PATH)/priv
BUILD = $(MIX_APP_PATH)/obj
SRCDIR = $(MIX_APP_PATH)/src

NIF = $(PREFIX)/sample.so
NIF_SRC = $(wildcard src/*.cpp)
NIF_HEADERS =$(wildcard src/*.h)

$(info "**** MIX_ENV set to [$(MIX_ENV)] ****")
$(info "**** MIX_APP_PATH set to [$(MIX_APP_PATH)] ****")

calling_from_make:
	mix compile

all: install $(NIF_HEADERS) Makefile

install: $(PREFIX) $(BUILD) $(NIF)

$(NIF): $(NIF_SRC)
	@echo Compiling NIF Library $@
	$(CC) -o $@ $(ERL_LDFLAGS) $(LDFLAGS) $(CFLAGS) $^

$(PREFIX) $(BUILD):
	mkdir -v -p $@

clean:
	$(RM) $(NIF)

.PHONY: all clean calling_from_make install


# SPDX-License-Identifier: Apache-2.0
