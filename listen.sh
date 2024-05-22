#!/bin/bash

cleanup() {
    reset
    trap - EXIT
}

trap cleanup EXIT

echo "Listening..."
#stty -echo raw
stty -echo -icanon
socat TCP-LISTEN:8888 -
