BUCKET_NAME ?= hornfulton.com
AWS_IMAGE ?= amazon/aws-cli:2.0.41


### Evaluate docker commands
DOCKER      := docker run --rm -v $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))):/workspace -w /workspace 
AWS         := $(DOCKER) -v $(HOME)/.aws:/root/.aws -e AWS_PROFILE -e AWS_REGION $(AWS_IMAGE) 

deploy:
	$(AWS) s3 sync  --sse "AES256" --exclude ".git/*" --exclude ".DS_Store" --exclude ".vscode/*" --exclude "Makefile" --exclude .gitignore ./ s3://$(BUCKET_NAME)/

