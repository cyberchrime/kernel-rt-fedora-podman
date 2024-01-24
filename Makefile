.PHONY=build install clean

FEDORA_VERSION=$$(cat ./FEDORA_VERSION)
ARCH=$$(if [[ "$$(uname -m)" == "aarch64" ]]; then echo "arm64v8"; else echo "amd64"; fi)


all: build

build:
	@sudo modprobe crypto_user
	@mkdir -p output kernel
	@podman build --build-arg=ARCH=$(ARCH) --build-arg=FEDORA_VERSION=$(FEDORA_VERSION) -t kernel-rt:latest .
	@podman run -it --rm -e FEDORA_VERSION=$(FEDORA_VERSION) -v $$PWD/kernel:/kernel:Z -v $$PWD/output:/output:Z kernel-rt:latest

clean:
	@rm -rf output kernel
