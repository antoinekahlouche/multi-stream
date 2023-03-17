## List devices

```
./ffmpeg \
    -y \
    -hide_banner \
    -f avfoundation \
    -list_devices true \
    -i ""
```

## Record Facecam

```
./ffmpeg \
    -y \
    -hide_banner \
    -probesize $((2*1920*1080*4+1)) \
    -re \
    -f avfoundation \
    -video_size 1920x1080 \
    -framerate 60 \
    -pixel_format uyvy422 \
    -i "0:" \
    -vcodec libx264 \
    -crf 0 \
    facecam.mkv
```

## Record Screen

```
./ffmpeg \
    -y \
    -hide_banner \
    -probesize $((2*1920*1080*4+1)) \
    -re \
    -f avfoundation \
    -capture_cursor 1 \
    -pixel_format uyvy422 \
    -i "6:0" \
    -vcodec libx264 \
    -crf 0 \
    screen.mkv
```

-nostats
-loglevel error






./ffmpeg \
    -y \
    -hide_banner \
    -f avfoundation \
    -i "0:0" \
    -vcodec libx264 \
    -preset ultrafast \
    -crf 0 
    screen.mp4 \
    -f avfoundation \
    -i "1:0" \
    -vcodec libx264 \
    -preset ultrafast \
    -crf 0 \
    webcam.mp4












./ffmpeg \
    -y \
    -hide_banner \
    -f avfoundation \
    -pix_fmt yuyv422 \
    -video_size 1920x1080 \
    -framerate 60.000240 \
    -i "0:0" -ac 2 \
    -vf format=yuyv422 \
    -vcodec libx264 -maxrate 2000k \
    -bufsize 2000k -acodec aac -ar 44100 -b:a 128k \
    -f rtp_mpegts udp://127.0.0.1:9988

