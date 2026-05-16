# Use a Python 3.12.3 Alpine base image
FROM python:3.12-alpine3.20

# Set the working directory
WORKDIR /app

# Copy all files from the current directory to the container's /app directory
COPY . .

# Install necessary system dependencies + Bento4 + Deno
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    musl-dev \
    ffmpeg \
    aria2 \
    make \
    g++ \
    cmake \
    curl \
    unzip && \
    # Build and install mp4decrypt from Bento4
    wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip && \
    unzip v1.6.0-639.zip && \
    cd Bento4-1.6.0-639 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cp mp4decrypt /usr/local/bin/ && \
    cd ../.. && \
    rm -rf Bento4-1.6.0-639 v1.6.0-639.zip && \
    # Install Deno (single binary for Alpine/musl)
    DENO_VERSION=1.46.3 && \
    curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-x86_64-unknown-linux-musl.zip -o deno.zip && \
    unzip deno.zip && \
    mv deno /usr/local/bin/deno && \
    chmod +x /usr/local/bin/deno && \
    rm deno.zip

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r sainibots.txt \
    && python3 -m pip install -U yt-dlp

# Set the command to run the application
CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]
