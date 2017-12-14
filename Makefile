ROOT_DIR = $(shell pwd)

.DEFAULT_GOAL := help

# general
help:
	@echo "Type: make [rule]. Available options are:"
	@echo ""
	@echo "- help"
	@echo "- build"
	@echo "- run cmd=\"make menuconfig\""
	@echo "- run-custom cmd=\"make raspberrypi3_defconfig; make\""
	@echo "- bash"
	@echo ""

build:
	docker build -t prsolucoes_buildroot .

run:
	mkdir -p "$(ROOT_DIR)/output"

	docker run \
	-v "$(ROOT_DIR)/output":/buildroot/output \
	-it prsolucoes_buildroot \
	/bin/bash -c "$(cmd)"

run-custom:
	mkdir -p "$(ROOT_DIR)/output"

	docker run \
	-e BR2_EXTERNAL=/custom \
	-v "$(ROOT_DIR)/custom":/custom \
	-v "$(ROOT_DIR)/output":/buildroot/output \
	-it prsolucoes_buildroot \
	/bin/bash -c "$(cmd)"

bash:
	mkdir -p "$(ROOT_DIR)/output"

	docker run \
	-v "$(ROOT_DIR)/output":/buildroot/output \
	-it prsolucoes_buildroot \
	/bin/bash
