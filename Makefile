DOCKER_TAG=canvas-build-environment

.PHONY: build-environment
build-environment:
	cd docker && \
		docker build -t $(DOCKER_TAG) .

build-canvas:
	docker run \
		--volume ${CURDIR}:/build $(DOCKER_TAG) \
		bash -c 'cd /build; export NVM_DIR=$$HOME/.nvm; . $$HOME/.nvm/nvm.sh; . ci/install.sh linux "$(CANVAS_PREBUILT_VERSION)" "$(CANVAS_VERSION_TO_BUILD)" "$(NODEJS_VERSIONS)"'

release:
	docker run \
		--env PREBUILD_AUTH \
		--env PREBUILD_SLUG \
		--volume ${CURDIR}:/build $(DOCKER_TAG) \
		bash -c 'cd /build; export NVM_DIR=$$HOME/.nvm; . $$HOME/.nvm/nvm.sh; . ci/release.sh "$(CANVAS_PREBUILT_VERSION)"'
