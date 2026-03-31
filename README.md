# JetBot on Jetson Orin Nano

Jetson Orin Nano (JetPack 6.x)  
Docker image based on L4T 36.4.0

This project provides a Docker-based environment for running JetBot notebooks on Jetson Orin Nano, including:

- ML development (JupyterLab + CUDA + PyTorch + TensorFlow)
- OLED display service (IP address & system stats on SparkFun OLED)

This project was developed as part of AI Lab activities at UAE University, supporting JetBot-based education and experimentation.

---

## Platform

- NVIDIA Jetson Orin Nano
- JetPack 6.x (tested on 6.0 / 6.1 / 6.2)
- Docker image based on L4T 36.4.0
- ARM64 architecture

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

```bash
sudo docker pull moatazsawi/jetbot-orin-ml:36.4.0
sudo docker pull moatazsawi/jetbot-orin-display:36.4.0
```

### 3) Make scripts executable

```bash
cd $HOME/jetbot-orin
chmod +x scripts/run-ml.sh scripts/run-display.sh
```

### 4) Start the display container (runs at boot)

This container runs in the background and automatically restarts after reboot.

```bash
./scripts/run-display.sh
```

Manual equivalent command:

```bash
sudo docker run -it -d \
  --restart always \
  --runtime nvidia \
  --network host \
  --privileged \
  --name jetbot_display \
  moatazsawi/jetbot-orin-display:36.4.0
```

---

## Run the ML container (every time you want to use JupyterLab)

Use this procedure whenever you want to start the ML environment.

### Option A) Recommended — use the script

```bash
cd $HOME/jetbot-orin
./scripts/run-ml.sh
```

### Option B) Manual command

```bash
cd $HOME/jetbot-orin

sudo docker run -it --rm \
  --runtime nvidia \
  --name jetbot_env \
  --network host \
  --privileged \
  --device /dev/video0 \
  --device /dev/video1 \
  --device /dev/i2c-7 \
  --volume /dev/bus/usb:/dev/bus/usb \
  --volume /tmp/argus_socket:/tmp/argus_socket \
  -v ./notebooks:/jetbot_examples/notebooks \
  --workdir /jetbot_examples \
  moatazsawi/jetbot-orin-ml:36.4.0
```

---

## Access JupyterLab

After starting the ML container, the terminal will display a message similar to:

```
JupyterLab URL: http://192.168.10.4:8888 (password "jetbot")
```

Open the displayed URL in your browser.

When prompted, use:

```
Password: jetbot
```

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
