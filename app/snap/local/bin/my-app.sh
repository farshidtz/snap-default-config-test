#!/bin/bash -e

echo "debug: $(snapctl get debug)"
echo "autostart: $(snapctl get autostart)"

for i in {1..10}
do
    echo "My app: $i"
    sleep 1
done

echo "done!"
