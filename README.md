Resize

```
./ffmpeg \
    -i input.mkv \
    -c:a copy \
    -s 640x360 \
    scaled.mkv
./ffmpeg -re -i rtmp://localhost:1935/live/test -s 640x360 rtmp://localhost:1935/scaled/test
```

# Crop

```
./ffmpeg \
    -i input.mkv \
    -filter:v "crop=1000:1080:0:0" output_left.mkv \
    -filter:v "crop=920:1080:1000:0" output_right.mkv

./ffmpeg -re -i rtmp://localhost:1935/live/test -filter:v "crop=920:1080:1000:0" -vcodec hevc_videotoolbox -vprofile baseline -g 10 -acodec aac -ar 44100 -ac 1 -f flv rtmp://localhost:1935/right/test

./ffmpeg \
    -listen 1 \
    -i rtmp://localhost:1935/live/test \
    -filter:v "crop=920:1080:1000:0" \
        -codec:v libx264 \
        -profile:v baseline \
        -g 10 \
        -codec:a aac \
        -ar 44100 \
        -ac 1 \
        -f flv \
        rtmp://localhost:1935/right/test

```

RTMP output

```
./ffmpeg
    -listen 1 \
    -i rtmp://localhost:1935/live \
    -c copy \
    output.mkv
```

# Stream video infinite

```
./ffmpeg -stream_loop -1 -re -i input.mkv -f flv rtmp://localhost:1935/live/ak
```

./ffmpeg -stream_loop -1 -re -i input.mkv -c copy -f flv rtmp://localhost:1935/live/test
./ffmpeg -stream_loop -1 -i input.mkv -b:v 5000k -f flv rtmp://localhost:1935/live/test

ffmpeg -i ... -filter:v "crop=920:1080:1000:0" -c:a copy ...

# local server

```
./ffmpeg -listen 1 \
    -i rtmp://localhost:1935/live/test \
    -filter:v "crop=920:1080:1000:0" \
        -codec:v libx264 \
        -profile:v baseline \
        -g 10 \
        -codec:a aac \
        -ar 44100 \
        -ac 1 \
        -f flv \
        /dev/null

./ffmpeg \
    -listen 1 \
    -i rtmp://localhost:1935/live/test \
    -filter:v "crop=920:1080:1000:0" \
        -codec:v libx264 \
        -profile:v baseline \
        -c:a copy \
        -f tee \
        -map 0:v \
        -map 0:a \
        "[f=flv]out1.mkv|[f=flv]out2.mkv"

./ffmpeg \
    -listen 1 \
    -i rtmp://localhost:1935/local/test \
    -filter:v "crop=920:1080:1000:0" \
        -codec:v libx264 \
        -profile:v baseline \
        -c:a copy \
        -f tee \
        -map 0:v \
        -map 0:a \
        "[f=flv]rtmp://localhost:1935/right/test|[f=flv]rtmp://localhost:1935/rightbis/test"
```

