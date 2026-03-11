# JetBot (Jetson Orin Nano) Assembly Guide

Prepared by: Mutaz Khairalla  
Based on the SparkFun JetBot AI Kit V2.0 assembly guide (originally for Jetson Nano), adapted for **Jetson Orin Nano Developer Kit**.

## Assembly video
Add your YouTube link here once uploaded:

- Video: https://youtube.com/watch?v=YOUR_VIDEO_ID

Tip: You can show a clickable thumbnail in GitHub like this:
```md
[![JetBot Assembly Video](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://youtube.com/watch?v=YOUR_VIDEO_ID)
```

---

## Bill of materials

| # | Item | Name |
|---:|---|---|
| 1 | Compute | NVIDIA Jetson Orin Nano Developer Kit |
| 2 | Storage | Lexar NM620 M.2 2280 PCIe Gen3x4 NVMe SSD |
| 3 | Power | Charmcast PowerBank 10400mAh (W1052) |
| 4 | Chassis | ROB-17279 JetBot Chassis Kit V2 |
| 5 | Qwiic pHAT | DEV-15945 SparkFun Qwiic pHAT V2.0 |
| 6 | Motor driver | ROB-15451 SparkFun Qwiic Motor Driver |
| 7 | OLED | LCD-22495 SparkFun Micro OLED Breakout (Qwiic) |
| 8 | Camera | IMX219-200 8MP Camera (200° FOV) |
| 9 | Power cable | Adafruit 5449 USB-C PD to 5.5mm barrel (9V 5A, 1.2m) |

**Figure 1: Jetson Orin Nano JetBot parts**  

<img src="images/figure-01.jpg" width="600"/>

<sub>Figure 1: JetBot parts</sub>

**Figure 2: JetBot chassis parts**  

<img src="images/figure-02.jpg" width="600"/>

<sub>Figure 2: JetBot cahssis parts</sub>


---

## Orientation reference

Use this orientation reference while following the steps.

**Figure 3: Orientation reference**  

<img src="images/figure-03.jpg" width="600"/>

<sub>Figure 3: Orientation reference</sub>

---

## Step-by-step assembly

### Step 1 — Attach motors and ball caster

Follow the images in order:


<img src="images/figure-04.jpg" width="600"/>

<sub>Figure 4: Step 1.1</sub>

<img src="images/figure-05.jpg" width="600"/>

<sub>Figure 5: Step 1.2</sub>

<img src="images/figure-06.jpg" width="600"/>

<sub>Figure 6: Step 1.3</sub>

<img src="images/figure-07.jpg" width="600"/>

<sub>Figure 7: Step 1.4</sub>

<img src="images/figure-08.jpg" width="600"/>

<sub>Figure 8: Step 1.5</sub>

<img src="images/figure-09.jpg" width="600"/>

<sub>Figure 9: Step 1.6</sub>

---

### Step 2 — Camera assembly and installation

<img src="images/figure-10.jpg" width="600"/>

<sub>Figure 10: Step 2.1</sub>

<img src="images/figure-11.jpg" width="600"/>

<sub>Figure 11: Step 2.2</sub>

<img src="images/figure-12.jpg" width="600"/>

<sub>Figure 12: Step 2.3</sub>

<img src="images/figure-13.jpg" width="600"/>

<sub>Figure 13: Step 2.4</sub>

---

### Step 3 — Fix the battery holder to the bottom plate

Recommendation: use **Dual Lock** tape to allow easy battery replacement.

<img src="images/figure-14.jpg" width="600"/>

<sub>Figure 14: Step 3.1</sub>

<img src="images/figure-15.jpg" width="600"/>

<sub>Figure 15: Step 3.2</sub>

---

### Step 4 — Place motor driver and wire battery + motors to driver

<img src="images/figure-16.jpg" width="600"/>

<sub>Figure 16: Step 4</sub>

---

### Step 5 — Place the PowerBank and USB‑C PD cable

Recommendation: use  double-sided tape for a secure fit.

<img src="images/figure-17.jpg" width="600"/>

<sub>Figure 17: Step 5</sub>

---

### Step 6 — Install the PCIe NVMe SSD on the Jetson Orin Nano

Remove the securing screw, insert the SSD, then re-secure it.

<img src="images/figure-18.jpg" width="600"/>

<sub>Figure 18: Step 6.1</sub>

<img src="images/figure-19.jpg" width="600"/>

<sub>Figure 19: Step 6.2</sub>

---

### Step 7 — Attach the Jetson Orin Nano to the top of the JetBot

Fix the Orin Nano to the top plate using double-sided tape.

<img src="images/figure-20.jpg" width="600"/>

<sub>Figure 20: Step 7.1</sub>

<img src="images/figure-21.jpg" width="600"/>

<sub>Figure 21: Step 7.2</sub>

Additional reference images:

<img src="images/figure-22.jpg" width="600"/>

<sub>Figure 22</sub>

<img src="images/figure-23.jpg" width="600"/>

<sub>Figure 23</sub>

---

### Step 8 — Install Qwiic pHAT and OLED

<img src="images/figure-24.jpg" width="600"/>

<sub>Figure 24: Step 8.1</sub>

<img src="images/figure-25.jpg" width="600"/>

<sub>Figure 25: Step 8.2</sub>

---

### Step 9 — Connect camera and Qwiic cables

- Camera cable: **Standard → Mini CSI** camera cable
- Qwiic chain:
  - Qwiic pHAT → OLED
  - OLED → Motor driver

<img src="images/figure-26.jpg" width="600"/>

<sub>Figure 26</sub>

<img src="images/figure-27.jpg" width="600"/>

<sub>Figure 27</sub>

<img src="images/figure-28.jpg" width="600"/>

<sub>Figure 28</sub>

---

## Troubleshooting

### Camera not detected

If the camera is not working or not visible in Jupyter/OpenCV, follow these steps:

#### 1) Check if the camera is listed

```bash
v4l2-ctl --list-devices
```

You should see a camera device listed (for example `/dev/video0`).

If no camera device appears, continue to the next step.

---

#### 2) Enable CSI camera using Jetson-IO

```bash
sudo python3 /opt/nvidia/jetson-io/jetson-io.py
```

Then:

1. Select **Configure Jetson 24pin CSI Connector**
2. Configure for compatible hardware
3. Camera IMS219 Dual
4. Save and reboot

---

After rebooting, verify again:

```bash
v4l2-ctl --list-devices
```

If the camera appears in the list, the CSI driver configuration was successful.

---

### Additional Checks

- Ensure the CSI ribbon cable is fully inserted and aligned correctly.
- Confirm the camera is connected to the correct CSI port.
- If using Docker, make sure the container includes:
  - `--device /dev/video0`
  - `--volume /tmp/argus_socket:/tmp/argus_socket`
