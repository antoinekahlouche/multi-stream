# ISO recording on MacOS M1

1. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Add Homebrew to your path

```sh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/antoinekahlouche/.zprofile
```

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

3. Install Ffmpeg

```sh
brew install ffmpeg
```

4. Script to identify sources

```sh
ffmpeg -y -hide_banner -f avfoundation -list_devices true -i ""
```

4. Script to ISO record

```sh
ffmpeg -y -hide_banner \
    -f avfoundation -video_size 1920x1080 -framerate 60.000240 -pixel_format uyvy422 -probesize 12M -thread_queue_size 1024 -i "Elgato Facecam:" \
    -f avfoundation -video_size 1920x1080 -framerate 60 -pixel_format uyvy422 -probesize 12M -thread_queue_size 512 -capture_cursor 1 -i "Capture screen 1:" \
    -f avfoundation -thread_queue_size 512 -i ":M2" \
    -map "0:v" -c:v hevc_videotoolbox -q:v 100 -filter:v fps=60 Webcam.mp4 \
    -map "1:v" -c:v hevc_videotoolbox -q:v 100 Screen.mp4 \
    -map "2:a:1" -c:a aac -b:a 128k -ar 48k Audio.aac
```


https://trac.ffmpeg.org/wiki/Map

https://trac.ffmpeg.org/wiki/AudioChannelManipulation#stereomonostream



```
ffmpeg -i Webcam.mp4 -i Screen.mp4 -filter_complex vstack output.mp4
```

ffmpeg -y -hide_banner \
    -f avfoundation -video_size 1920x1080 -framerate 60.000240 -pixel_format uyvy422 -probesize 12M -thread_queue_size 1024 -i "Elgato Facecam:" \
    -f avfoundation -thread_queue_size 512 -i ":M2" \
    -f avfoundation -video_size 1920x1080 -framerate 60 -pixel_format uyvy422 -probesize 12M -thread_queue_size 512 -capture_cursor 1 -i "Capture screen 1: \
    -map "0" -c:v hevc_videotoolbox -q:v 100 -filter:v fps=60 Webcam.mp4 \
    -map "1" -c:a aac -b:a 128k -ar 48k -ac 1 Voice.aac \
    -map "2" -c:v hevc_videotoolbox -q:v 100 -c:a aac -b:a 128k -ar 48k Screen.mp4




ffmpeg -y -hide_banner \
    -f avfoundation -i ":M2" \
    -c:a aac -b:a 128k -ar 48k -ac 1 Voice.aac