sudo docker run -it -d \
  --restart always \
  --runtime nvidia \
  --network host \
  --privileged \
  --name jetbot_display \
  moatazsawi/jetbot-orin-display:36.4.0
