FROM tiangolo/nginx-rtmp

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg

COPY nginx.conf /etc/nginx/nginx.conf
COPY script.sh /usr/script.sh

RUN chmod +x /usr/script.sh
RUN ln -sf /dev/stdout /var/log/ffmpeg.log

EXPOSE 1935
CMD ["nginx", "-g", "daemon off;"]

# jrottenberg/ffmpeg AS ffmpeg

