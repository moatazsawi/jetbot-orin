# JetBot on Jetson Orin Nano

JetBot environment for NVIDIA Jetson Orin Nano with Docker support for multiple JetPack versions.

## Supported Platforms

| Host JetPack | ML Docker Tag | Display Docker Tag | Status |
|---|---|---|---|
| JetPack 6.x | `36.4.0` | `36.4.0` | Tested on JetPack 6.0 / 6.1 / 6.2 |
| JetPack 7.2.1 | `jp7.2.1-r39.2.1` | `jp7.2.1-r39.2.1` | Tested on JetPack 7.2.1 |

> Docker tags identify the container version to use. The installed host L4T release may differ between JetPack 6.x versions.

This project provides Docker-based environments for running JetBot notebooks and services on Jetson Orin Nano, including:

- JupyterLab for interactive development
- CUDA-enabled PyTorch
- Computer vision and AI development
- JetBot hardware integration
- OLED display service for IP address and system information

> **Note:** TensorFlow is available in the JetPack 6.x ML image but is not included in the JetPack 7.2.1 ML image.

This project was developed as part of AI Lab activities at UAE University, supporting JetBot-based education and experimentation.

---

## Hardware Assembly

➡ Full assembly guide: [docs/](docs/)

---

## One-time setup (first time only)

Run these steps once on your Jetson Orin Nano.

### 1) Clone the repo

```bash
cd $HOME
git clone https://github.com/moatazsawi/jetbot-orin.git
```

### 2) Pull Docker images

Select the images that match the JetPack version installed on your Jetson Orin Nano.

#### JetPack 7.2.1

```bash
sudo docker pull moatazsawi/jetbot-orin-ml:jp7.2.1-r39.2.1
sudo docker pull moatazsawi/jetbot-orin-display:jp7.2.1-r39.2.1
```

#### JetPack 6.x

```bash
sudo docker pull moatazsawi/jetbot-orin-ml:36.4.0
sudo docker pull moatazsawi/jetbot-orin-display:36.4.0
```

The JetPack 6.x images have been tested on JetPack 6.0, 6.1, and 6.2.

The JetPack 7 images have been tested on JetPack 7.2.1.

### 3) Make scripts executable

```bash
cd $HOME/jetbot-orin
chmod +x scripts/run-ml.sh scripts/run-display.sh
```

### 4) Start the display container (runs at boot)

This container runs in the background and automatically restarts after reboot.

#### Recommended — use the script

```bash
cd $HOME/jetbot-orin
./scripts/run-display.sh
```

The script automatically selects the appropriate display Docker image for the installed JetPack/L4T version.

#### Manual command

First select the appropriate image.

For **JetPack 7.2.1**:

```bash
DISPLAY_IMAGE=moatazsawi/jetbot-orin-display:jp7.2.1-r39.2.1
```

For **JetPack 6.x**:

```bash
DISPLAY_IMAGE=moatazsawi/jetbot-orin-display:36.4.0
```

Then run:

```bash
sudo docker run -it -d \
  --restart always \
  --runtime=nvidia \
  --network=host \
  --privileged \
  --name jetbot_display \
  "${DISPLAY_IMAGE}"
```

---

## Run the ML container (every time you want to use JupyterLab)

Use this procedure whenever you want to start the ML environment.

### Option A) Recommended — use the script

```bash
cd $HOME/jetbot-orin
./scripts/run-ml.sh
```

The script automatically selects the appropriate ML Docker image for the installed JetPack/L4T version.

### Option B) Manual command

First select the appropriate image.

For **JetPack 7.2.1**:

```bash
ML_IMAGE=moatazsawi/jetbot-orin-ml:jp7.2.1-r39.2.1
```

For **JetPack 6.x**:

```bash
ML_IMAGE=moatazsawi/jetbot-orin-ml:36.4.0
```

Then run:

```bash
cd $HOME/jetbot-orin

sudo docker run -it --rm \
  --runtime=nvidia \
  --name jetbot_env \
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
  -v "$(pwd)/notebooks:/jetbot_examples/notebooks" \
  --workdir /jetbot_examples \
  "${ML_IMAGE}"
```

---

## Access JupyterLab

After starting the ML container:

1. Check the IP address shown on the SparkFun OLED display.
2. Open the following address in your browser:

```text
http://<JETSON_IP>:8888
```

For example:

```text
http://10.100.1.5:8888
```

3. When prompted, enter:

```text
Password: jetbot
```

> Use the IP address shown on the OLED display instead of the IP address printed in the terminal.

---

📓 Explore notebooks and follow a step-by-step guide:  
[Notebooks](notebooks/)

---

## Video Demonstrations

Each playlist provides a structured walkthrough of a JetBot task.

### JetBot Basics

▶ [JetBot Basics (Jetson Orin Nano)](https://youtube.com/playlist?list=PLzd-shz0FWwSOYQclVobdIR8I0EKIRDfq)

### Collision Avoidance

▶ [JetBot Collision Avoidance (Jetson Orin Nano)](https://youtube.com/playlist?list=PLzd-shz0FWwTXMWMYDSj5Sgr-amzIUEGh)

### Object Following (YOLO)

▶ [JetBot Object Following with YOLO (Jetson Orin Nano)](https://youtube.com/playlist?list=PLzd-shz0FWwQqYxJ2lIHmc4cbHmdZSF3q)

### Road Following

▶ [JetBot Road Following (Jetson Orin Nano)](https://youtube.com/playlist?list=PLzd-shz0FWwTqZqVYKZQwIGeXGuZjPZV7)
