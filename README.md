# jetbot-orin
NVIDIA JetBot project for Jetson Orin Nano including Docker images (ML &amp; display), step-by-step hardware assembly guide, setup instructions, notebooks, and reference videos. All resources are aligned with the official NVIDIA JetBot platform and optimized for JetPack 36.4.0.

# JetBot Orin Containers

Documentation for JetBot containers on NVIDIA Jetson Orin Nano (JetPack 36.4.0 / L4T 36.4.0).

## Images

- ML: `moatazsawi/jetbot-orin-ml:IMAGE_TAG`
- Display: `moatazsawi/jetbot-orin-display:IMAGE_TAG` (coming soon)

## Requirements

- NVIDIA Jetson Orin
- JetPack 36.4.0 (L4T 36.4.0)
- Architecture: `linux/arm64`

⚠ These images are for Jetson (ARM64). They will not run on x86_64 PCs.

## Pull

```bash
docker pull moatazsawi/jetbot-orin-ml:36.4.0
