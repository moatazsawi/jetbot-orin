#!/usr/bin/env bash
set -euo pipefail

JP6_IMAGE="moatazsawi/jetbot-orin-ml:36.4.0"
JP721_IMAGE="moatazsawi/jetbot-orin-ml:jp7.2.1-r39.2.1"

# Allow manual image override:
# IMAGE=moatazsawi/jetbot-orin-ml:<tag> ./scripts/run-ml.sh
if [[ -z "${IMAGE:-}" ]]; then

  if [[ ! -r /etc/nv_tegra_release ]]; then
    echo "Error: Unable to detect the JetPack/L4T version."
    echo "Specify the Docker image manually using IMAGE=<image>."
    exit 1
  fi

  L4T_RELEASE="$(head -n 1 /etc/nv_tegra_release)"

  if [[ "${L4T_RELEASE}" == *"R36"* ]]; then
    IMAGE="${JP6_IMAGE}"

  elif [[ "${L4T_RELEASE}" == *"R39"* && "${L4T_RELEASE}" == *"REVISION: 2.1"* ]]; then
    IMAGE="${JP721_IMAGE}"

  else
    echo "Error: Unsupported JetPack/L4T version:"
    echo "${L4T_RELEASE}"
    echo
    echo "You can specify an image manually using:"
    echo "IMAGE=<docker-image> ./scripts/run-ml.sh"
    exit 1
  fi
fi

NAME="${NAME:-jetbot_env}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$(pwd)/notebooks}"

mkdir -p "${WORKSPACE_DIR}"

echo "Using Docker image: ${IMAGE}"

sudo docker run -it --rm \
  --runtime=nvidia \
  --name "${NAME}" \
  --network=host \
  --ipc=host \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  --privileged \
  --device /dev/video0 \
  --device /dev/video1 \
  --device /dev/i2c-7 \
  --volume /dev/bus/usb:/dev/bus/usb \
  --volume /tmp/argus_socket:/tmp/argus_socket \
  -v "${WORKSPACE_DIR}:/jetbot_examples/notebooks" \
  --workdir /jetbot_examples \
  "${IMAGE}"
