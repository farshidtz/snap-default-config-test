#!/bin/bash -e

echo "debug: $(snapctl get debug)"
echo "autostart: $(snapctl get autostart)"

echo "doing some one-time setup work..."
sleep 3
echo "done!"
