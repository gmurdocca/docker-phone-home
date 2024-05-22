.SILENT:

docker_image_name = "socat_remote_shell"

help: # Show this help
	@echo Make targets:
	@egrep -h ":\s+# " $(MAKEFILE_LIST) | \
	  sed -e 's/# //; s/^/    /' | \
	  column -s: -t

build: # Build docker image
	docker build -f Dockerfile . -t $(docker_image_name)

shell: # exec into container to bash shell
	docker run --entrypoint="" -it $(docker_image_name):latest bash

run: # run container
	docker run --rm -it --name $(docker_image_name) $(docker_image_name):latest

run_phone_home: # run comtainer with phone home
	docker run --rm -it -e PHONE_HOME=10.1.1.52:8888 --name $(docker_image_name) $(docker_image_name):latest
