# Steadfast Monorepo Containerfile
# Base image with Node.js
FROM node:20-bullseye

# Install Python and required tools
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Clone the monorepo and submodules
RUN git clone https://github.com/narenkram/steadfast-monorepo.git . && \
    git submodule update --init --recursive

# Install steadfast-app dependencies
WORKDIR /app/steadfast-app
RUN npm install

# Install steadfast-api dependencies
WORKDIR /app/steadfast-api
RUN npm install

# Fix API server to listen on all interfaces (0.0.0.0) in development mode
# This allows access from outside the container through port mapping
RUN sed -i 's/host: "localhost",/host: "0.0.0.0",/g' config.js

# Install steadfast-websocket dependencies
WORKDIR /app/steadfast-websocket
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install --no-deps NorenRestApi

# Copy startup script
WORKDIR /app
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Expose ports
# 5173 - steadfast-app (frontend)
# 3000 - steadfast-api (backend)
# 8765 - flattrade websocket
# 8766 - shoonya websocket
EXPOSE 5173 3000 8765 8766

# Start all services
CMD ["/app/startup.sh"]
