#!/bin/bash

# Reverse tunnel to access container shell from bastion for debugging if $PHONE_HOME is set and
# is in the format: <bastion_address>:<port>
if [ -n "${PHONE_HOME}" ]; then

    if [ ! $(command -v socat) ]; then
        echo "Phone home can't find socat in \$PATH - is it installed?"
    else

        cleanup() {
            socat_pid=$(cat /tmp/socat.pid)
            echo -e "\nPhone home waiting for user to exit..."
            while true; do kill -0 $socat_pid >/dev/null 2>&1 || break; sleep 1; done
            echo "Phone home closed."
        }

        trap cleanup EXIT

        echo Phone home is calling: ${PHONE_HOME}
        (while true; do
            socat EXEC:'bash -li',pty,stderr,setsid,sigint,sane TCP:${PHONE_HOME} >/dev/null 2>&1 &
            socat_pid=$!
            echo $socat_pid > /tmp/socat.pid
            wait $socat_pid
            sleep 1
        done) &
    fi
fi


# run app
for i in {1..10}; do echo -n .; sleep 1; done
