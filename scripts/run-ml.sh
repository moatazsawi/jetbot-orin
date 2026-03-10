#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-moatazsawi/jetbot-orin-ml:36.4.0}"
NAME="${NAME:-jetbot_env}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$(pwd)/notebooks}"

mkdir -p "${WORKSPACE_DIR}"

sudo docker run -it --rm \
  --runtime nvidia \
  --name "${NAME}" \
  --network host \
  --privileged \
  --device /dev/video0 \
  --device /dev/video1 \
  --device /dev/i2c-7 \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /tmp/argus_socket:/tmp/argus_socket \
  -v "${WORKSPACE_DIR}:/jetbot_examples/notebooks" \
  --workdir /jetbot_examples \
  "${IMAGE}"
