FROM ubuntu:22.04
RUN apt update
RUN apt install -y clang-format-14
RUN mkdir -p /root/code
COPY .clang-format /root/
COPY format.sh /root/
RUN chmod +x /root/format.sh
ENTRYPOINT bash -c /root/format.sh
