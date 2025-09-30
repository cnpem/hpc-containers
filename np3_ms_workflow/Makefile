
# Makefile for building Singularity/Apptainer container images

# Default configuration
DEF_FILE = np3_ms_workflow.def
IMG_NAME = np3_ms_workflow.sif
SUDO = sudo
SINGULARITY = singularity
BUILD_FLAGS = --fakeroot

# Phony targets
.PHONY: all build clean test help

# Default target
all: build

# Build the container image
build:
	$(SINGULARITY) build $(BUILD_FLAGS) $(IMG_NAME) $(DEF_FILE)

# Build with sudo (for systems where fakeroot doesn't work)
build-sudo:
	$(SUDO) $(SINGULARITY) build $(IMG_NAME) $(DEF_FILE)

# Test the container
test: $(IMG_NAME)
	$(SINGULARITY) test $(IMG_NAME)

# Clean up built images
clean:
	rm -f $(IMG_NAME)

# Display help information
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build       Build container using fakeroot (default)"
	@echo "  build-sudo  Build container using sudo"
	@echo "  test        Run container tests"
	@echo "  clean       Remove built container image"
	@echo "  help        Display this help message"
	@echo ""
	@echo "Variables:"
	@echo "  DEF_FILE    Definition file (default: $(DEF_FILE))"
	@echo "  IMG_NAME    Output image name (default: $(IMG_NAME))"
	@echo "  BUILD_FLAGS Additional build flags (default: $(BUILD_FLAGS))"
	@echo ""
	@echo "Example:"
	@echo "  make DEF_FILE=custom.def IMG_NAME=custom.sif build"

