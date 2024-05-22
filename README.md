# Docker Phone Home

A socat trick to obtain a shell into a docker container where `docker exec ...` is unavailable, eg. AWS SageMaker batch transform containers.

This setup will spawn socat running as a TCP client in the docker container and execute bash such that std in/out/error are linked through the TCP socket to the server on the other end of the connection. The server in is another socat process, listening on a bastion host reachable by the container at a known location.

**On bastion, eg at ip address 1.2.3.4:**

bash -c 'stty -echo raw; socat TCP-LISTEN:8888 -'

or run `listen.sh`

The bastion is now listening for inbound connections on TCP/8888

**Entrypoint script:**

Copy the `entrypoint.sh` script structure to inject the phone home function.

When docker container starts, a shell will appear on bastion running as user who ran socat in the container. Once the main docker process as well as the remote shell (if any) exits, the container exits.

Notes:

* This setup assumes bash is available in the container and is in $PATH.
* Ensure network is secure as comms is completely unencrypted, or use socat’s ssl options to encrypt the link.
