FROM node:23-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    ffmpeg \
    gcc \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

ENV YOUTUBE_DL_SKIP_PYTHON_CHECK=1

RUN npm install

COPY . .

CMD ["node", "index.js"]
