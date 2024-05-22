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

delete_container: # delete container
	docker rm $(docker_image_name) >/dev/null 2>&1 || :

run: # run container
	make delete_container > /dev/null
	docker run -it --name $(docker_image_name) $(docker_image_name):latest

run_phone_home: # run comtainer with phone home
	make delete_container > /dev/null
	docker run -it -e PHONE_HOME=10.1.1.52:8888 --name $(docker_image_name) $(docker_image_name):latest
