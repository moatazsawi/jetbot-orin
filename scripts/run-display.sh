#!/usr/bin/env bash
set -euo pipefail

JP6_IMAGE="moatazsawi/jetbot-orin-display:36.4.0"
JP721_IMAGE="moatazsawi/jetbot-orin-display:jp7.2.1-r39.2.1"

NAME="${NAME:-jetbot_display}"

# Allow a manual image override:
#
# IMAGE=moatazsawi/jetbot-orin-display:<tag> \
#   ./scripts/run-display.sh
#
if [[ -z "${IMAGE:-}" ]]; then
  if [[ ! -r /etc/nv_tegra_release ]]; then
    echo "Error: Unable to detect the JetPack/L4T version."
    echo
    echo "Specify the display image manually:"
    echo "IMAGE=<docker-image> ./scripts/run-display.sh"
    exit 1
  fi

  L4T_RELEASE="$(head -n 1 /etc/nv_tegra_release)"

  if [[ "${L4T_RELEASE}" == *"R36"* ]]; then
    IMAGE="${JP6_IMAGE}"

  elif [[ "${L4T_RELEASE}" == *"R39"* &&
          "${L4T_RELEASE}" == *"REVISION: 2.1"* ]]; then
    IMAGE="${JP721_IMAGE}"

  else
    echo "Error: Unsupported JetPack/L4T version:"
    echo "${L4T_RELEASE}"
    echo
    echo "Supported versions:"
    echo "  - JetPack 6.x"
    echo "  - JetPack 7.2.1 / L4T r39.2.1"
    echo
    echo "To override automatic detection, run:"
    echo "IMAGE=<docker-image> ./scripts/run-display.sh"
    exit 1
  fi
fi

echo "Using display image: ${IMAGE}"

# Check whether a container with this name already exists.
if sudo docker container inspect "${NAME}" >/dev/null 2>&1; then
  CURRENT_IMAGE="$(
    sudo docker container inspect \
      --format '{{.Config.Image}}' \
      "${NAME}"
  )"

  RUNNING="$(
    sudo docker container inspect \
      --format '{{.State.Running}}' \
      "${NAME}"
  )"

  if [[ "${CURRENT_IMAGE}" == "${IMAGE}" ]]; then
    if [[ "${RUNNING}" == "true" ]]; then
      echo "Display container '${NAME}' is already running."
    else
      echo "Starting existing display container '${NAME}'..."
      sudo docker start "${NAME}"
    fi

    exit 0
  fi

  echo "Replacing the existing display container."
  echo "Current image: ${CURRENT_IMAGE}"
  echo "New image:     ${IMAGE}"

  sudo docker rm -f "${NAME}"
fi

sudo docker run -d \
  --restart=always \
  --runtime=nvidia \
  --network=host \
  --privileged \
  --name "${NAME}" \
  "${IMAGE}"

echo
echo "Display container started successfully."
echo "Container: ${NAME}"
echo "Image:     ${IMAGE}"
echo
echo "View status:"
echo "  sudo docker ps --filter name=${NAME}"
echo
echo "View logs:"
echo "  sudo docker logs -f ${NAME}"
