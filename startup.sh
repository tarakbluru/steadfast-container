#!/bin/bash

# Startup script for all steadfast services

echo "Starting Steadfast services..."

# Function to handle shutdown
cleanup() {
    echo "Shutting down all services..."
    pkill -P $$
    exit 0
}

trap cleanup SIGTERM SIGINT

# Start steadfast-api
echo "Starting steadfast-api on port 3000..."
cd /app/steadfast-api
NODE_ENV=production node server.js &
API_PID=$!

# Start steadfast-websocket
echo "Starting steadfast-websocket on ports 8765 and 8766..."
cd /app/steadfast-websocket
. venv/bin/activate
python3 main.py &
WEBSOCKET_PID=$!

# Start steadfast-app
echo "Starting steadfast-app on port 5173..."
cd /app/steadfast-app
npm run dev -- --host 0.0.0.0 &
APP_PID=$!

echo ""
echo "========================================="
echo "All services started successfully!"
echo "========================================="
echo "Frontend:            http://localhost:5173"
echo "API:                 http://localhost:3000"
echo "Flattrade WebSocket: ws://localhost:8765"
echo "Shoonya WebSocket:   ws://localhost:8766"
echo "========================================="
echo ""
echo "Press Ctrl+C to stop all services"

# Wait for all background processes
wait
