SHELL = /usr/bin/env bash -xe

PWD := $(shell pwd)

build:
	@rm -rf export
	@mkdir export
	@zip -yr export/layer.zip bootstrap bin lib libexec share

packages: build
	@zip -yr export/bash-lambda-layer.zip export/layer.zip publish.sh publish-only.sh README.publish.md

publish:
	@$(PWD)/publish.sh

publish-staging:
	@$(PWD)/publish-staging.sh

publish-only:
	@$(PWD)/publish-only.sh


update-awscli:
	docker run -it -v $(PWD):/root/bash-lambda-layer \
		lambci/lambda:build-python3.6 \
		bash -c /root/bash-lambda-layer/update-awscli.sh


.PHONY: \
	build
	publish
	publish-staging
