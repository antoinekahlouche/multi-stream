#!/bin/sh

# /usr/bin/ffmpeg \
#     -re \
#     -i rtmp://localhost:1935/live/ak \
#     -filter_complex \
#         "[0:v]split=2[s0][s1]; \
#         [s0]crop=1920:1080:0:0[v0]; \
#         [s1]crop=720:1280:1920:0[v1]" \
#     -c:v libx264 \
#     -crf 18 \
#     -c:a copy \
#     -f tee \
#     -flags +global_header \
#     -map "[v0]" \
#     -map "[v1]" \
#     -map 0:a \
#     "[select=\'v:0,a:0\':f=flv]rtmp://localhost:1935/horizontal/ak| \
#     [select=\'v:1,a:0\':f=flv]rtmp://localhost:1935/vertical/ak" \
#     2>>/var/log/ffmpeg.log

# /usr/bin/ffmpeg \
#     -re \
#     -i rtmp://localhost:1935/live/ak \
#     -filter_complex " \
#         [0:v]crop=1920:1080:0:0[horizontal]; \
#         [0:v]crop=720:1280:1920:0[vertical]" \
#     -map 0:a \
#     -acodec copy \
#     -q 0 \
#     -f flv \
#     -map "[horizontal]" \
#     rtmp://localhost:1935/horizontal/ak \
#     -map "[vertical]" \
#     rtmp://localhost:1935/vertical/ak

/usr/bin/ffmpeg \
    -re \
    -i rtmp://localhost:1935/live/ak \
    -filter_complex " \
        [0:v]crop=1920:1080:0:0[horizontal]; \
        [0:v]crop=720:1280:1920:0[vertical]" \
    -acodec copy \
    -codec:v libx264 \
    -q 0 \
    -f tee \
    -map 0:a \
    -map "[horizontal]" \
    -map "[vertical]" \
    "[select=\'v:0,a:0\':f=flv]rtmp://localhost:1935/horizontal/ak| \
    [select=\'v:1,a:0\':f=flv]rtmp://localhost:1935/vertical/ak"

# https://superuser.com/questions/1648842/ffmpeg-several-streams-with-different-video-and-audio-setting-using-filter-com