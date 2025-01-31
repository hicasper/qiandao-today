# 基础镜像
FROM python:3.11-slim

# Qiandao
WORKDIR /usr/src/app

# Environments
ENV PYCURL_SSL_LIBRARY=openssl
RUN apt update && \
  apt install -y --no-install-recommends git libssl-dev libcurl4-openssl-dev build-essential && \
  git clone --depth 1 https://github.com/qd-today/qd.git . && \
  sed -i '/==/!d' requirements.txt && \
  sed -i 's/# //g' requirements.txt && \
  sed -i 's/ddddocr==1.4.7/ddddocr==1.4.11/g' requirements.txt && \
  pip install --no-cache-dir -r requirements.txt && \
  apt autoremove -y git build-essential && apt clean && \
  rm -rf .git && \
  rm -rf /usr/share/doc/* && \
  rm -rf /usr/share/man/*

ENV PORT 80
EXPOSE $PORT/tcp

# timezone
ENV TZ=CST-8

# 添加挂载点
VOLUME ["/usr/src/app/config"]

CMD ["python","/usr/src/app/run.py"]
