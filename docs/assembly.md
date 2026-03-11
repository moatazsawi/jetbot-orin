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
![Figure 1](images/figure-01.jpg)

**Figure 2: JetBot chassis parts**  
![Figure 2](images/figure-02.jpg)

---

## Orientation reference

Use this orientation reference while following the steps.

**Figure 3: Orientation reference**  
![Figure 3](images/figure-03.jpg)

---

## Step-by-step assembly

### Step 1 — Attach motors and ball caster

Follow the images in order:

![Step 1.1](images/figure-04.jpg)
![Step 1.2](images/figure-05.jpg)
![Step 1.3](images/figure-06.jpg)
![Step 1.4](images/figure-07.jpg)
![Step 1.5](images/figure-08.jpg)
![Step 1.6](images/figure-09.jpg)

---

### Step 2 — Camera assembly and installation

![Step 2.1](images/figure-10.jpg)
![Step 2.2](images/figure-11.jpg)
![Step 2.3](images/figure-12.jpg)
![Step 2.4](images/figure-13.jpg)

---

### Step 3 — Fix the battery holder to the bottom plate

Recommendation: use **Dual Lock** tape to allow easy battery replacement.

![Step 3.1](images/figure-14.jpg)
![Step 3.2](images/figure-15.jpg)

---

### Step 4 — Place motor driver and wire battery + motors to driver

![Step 4](images/figure-16.jpg)

---

### Step 5 — Place the PowerBank and USB‑C PD cable

Recommendation: use  double-sided tape for a secure fit.

![Step 5](images/figure-17.jpg)

---

### Step 6 — Install the PCIe NVMe SSD on the Jetson Orin Nano

Remove the securing screw, insert the SSD, then re-secure it.

![Step 6.1](images/figure-18.jpg)
![Step 6.2](images/figure-19.jpg)

---

### Step 7 — Attach the Jetson Orin Nano to the top of the JetBot

Fix the Orin Nano to the top plate using double-sided tape.

![Step 7.1](images/figure-20.jpg)
![Step 7.2](images/figure-21.jpg)

Additional reference images:

![Figure 22](images/figure-22.jpg)
![Figure 23](images/figure-23.jpg)

---

### Step 8 — Install Qwiic pHAT and OLED

![Step 8.1](images/figure-24.jpg)
![Step 8.2](images/figure-25.jpg)

---

### Step 9 — Connect camera and Qwiic cables

- Camera cable: **Standard → Mini CSI** camera cable
- Qwiic chain:
  - Qwiic pHAT → OLED
  - OLED → Motor driver

![Figure 26](images/figure-26.jpg)
![Figure 27](images/figure-27.jpg)
![Figure 28](images/figure-28.jpg)

---

Add common troubleshooting notes here as you encounter them, for example:
- OLED not detected on I2C
- Camera not detected / Argus issues
- Motor driver not responding
