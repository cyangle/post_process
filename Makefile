CRYSTAL_BIN ?= crystal
SHARDS_BIN ?= shards
PREFIX ?= /usr/local
SHARD_BIN ?= ../../bin

build: bin/post_process
bin/post_process:
	$(SHARDS_BIN) build $(CRFLAGS)
clean:
	rm -f ./bin/post_process ./bin/post_process.dwarf
install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/post_process $(PREFIX)/bin
bin: build
	mkdir -p $(SHARD_BIN)
	cp ./bin/post_process $(SHARD_BIN)
run_file:
	cp -n ./bin/post_process.cr $(SHARD_BIN) || true
test: build
	$(CRYSTAL_BIN) spec
	./bin/post_process --all
