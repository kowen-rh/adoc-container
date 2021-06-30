default: html
all: html pdf

container:
	podman image exists adoc || podman build -f Containerfile -t adoc

html: container
	podman run --rm -v $(CURDIR):/docs adoc html /docs/README.adoc

pdf: container
	podman run --rm -v $(CURDIR):/docs adoc pdf /docs/README.adoc

.PHONY: all container default html pdf
