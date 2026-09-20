FROM python:3.13-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 TZ=Asia/Seoul
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends unzip tzdata ca-certificates && rm -rf /var/lib/apt/lists/*
COPY Jason_Leader_Hunter_Cloud_v1.0.0.zip /tmp/app.zip
RUN unzip -q /tmp/app.zip -d /tmp/src \
    && cp -R /tmp/src/Jason_Leader_Hunter_Cloud_v1.0.0/. /app/ \
    && pip install --no-cache-dir -r requirements.txt \
    && mkdir -p /app/data \
    && rm -rf /tmp/app.zip /tmp/src
EXPOSE 8000
CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8000","--proxy-headers"]
