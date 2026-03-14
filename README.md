# JetBot on Jetson Orin Nano (JetPack 36.4.0)

This project provides Docker-based environments for:

-   ML development (JupyterLab + CUDA + PyTorch + TensorFlow)
-   OLED display service (IP address & system stats on SparkFun OLED)

Compatible with:

-   NVIDIA Jetson Orin Nano
-   JetPack 36.4.0 (L4T 36.4.0)
-   ARM64 architecture

------------------------------------------------------------------------
## Hardware Assembly

➡ Full assembly guide: [docs/](docs/)

## One-time setup (first time only)

Run these steps once on your Jetson Orin Nano.

### 1) Clone the repo

``` bash
cd
git clone https://github.com/moatazsawi/jetbot-orin.git
```

### 2) Pull Docker images

``` bash
sudo docker pull moatazsawi/jetbot-orin-ml:36.4.0
sudo docker pull moatazsawi/jetbot-orin-display:36.4.0
```

### 3) Make scripts executable

``` bash
cd jetbot-orin
sudo chmod +x scripts/run-ml.sh scripts/run-display.sh
```

### 4) Start the display container (runs at boot)

This container runs in the background and automatically restarts after
reboot.

``` bash
./scripts/run-display.sh
```

Manual equivalent command:

``` bash
sudo docker run -it -d \
  --restart always \
  --runtime nvidia \
  --network host \
  --privileged \
  --name jetbot_display \
  moatazsawi/jetbot-orin-display:36.4.0
```


------------------------------------------------------------------------

## Run the ML container (every time you want to use JupyterLab)

Use this procedure whenever you want to start the ML environment.

### Option A) Recommended --- use the script

``` bash
cd jetbot-orin
sudo ./scripts/run-ml.sh
```

### Option B) Manual command

``` bash
cd jetbot-orin

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

------------------------------------------------------------------------

## Access JupyterLab

After starting the ML container, the terminal will display a message similar to:

    JupyterLab URL: http://192.168.10.4:8888 (password "jetbot")

Open the displayed URL in your browser.

When prompted, use:

    Password: jetbot
------------------------------------------------------------------------
