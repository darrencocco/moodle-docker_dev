#!/bin/bash
TARGETGID=$(getent group docker | awk -F: '{printf "%d", $3}')
echo "$USER:$TARGETGID:1"
