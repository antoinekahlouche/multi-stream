ffmpeg \
    -y \
    -hide_banner \
    -stream_loop -1 \
    -re \
    -i in.mp4 \
    -f flv \
    -vcodec libx264 \
    -crf 0 \
    rtmp://localhost:1935/live/test



ffmpeg \
    -y \
    -hide_banner \
    -listen 1 \
    -re \
    -i rtmp://localhost:1935/live/test \
    test.mp4


rtmp://127.0.0.1:9009/live/
rtmp://localhost:1935/live/test


ffmpeg \
    -y \
    -hide_banner \
    -listen 1 \
    -re \
    -i rtmp://localhost:1935/live/test \
    -vcodec libx264 -crf 0 youtube.mp4 \
	-acodec copy -vcodec copy -f flv -b:v 6K twitch.mp4












ffmpeg -y -hide_banner \
    -f avfoundation -i "OBS Virtual Camera:" \
    -map "0" -c:v hevc_videotoolbox -q:v 100 twitch.mp4 \
