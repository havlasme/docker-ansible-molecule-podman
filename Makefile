VERSION ?= latest
NAMESPACE ?= havlasme
IMAGENAME ?= ansible-molecule-podman

PODMAN = @podman

.PHONY: build
build:
	$(PODMAN) build -t $(NAMESPACE)/$(IMAGENAME):$(VERSION) .
