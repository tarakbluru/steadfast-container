# Steadfast Monorepo - Container Setup

This setup allows you to run the entire Steadfast application stack in an isolated Podman container on Windows, keeping your desktop clean.

## Prerequisites

- **Podman Desktop** installed on Windows ([Download here](https://podman.io/downloads))
- Ensure Podman is running and accessible from command line

Verify Podman installation:
```cmd
podman --version
```

## Files Overview

- **Containerfile** - Defines the container image
- **startup.sh** - Starts all services inside the container
- **build.bat** - Builds the container image (Windows)
- **run.bat** - Runs the container (Windows)
- **stop.bat** - Stops and removes the container (Windows)

## Quick Start Guide

### Step 1: Build the Container Image (First Time Only)

Open a Windows Command Prompt or PowerShell in this directory and run:

```cmd
build.bat
```

**What happens:**
- Downloads Node.js base image (~300 MB)
- Installs Python and dependencies
- Clones all three steadfast repositories
- Installs all npm and Python dependencies
- Creates the container image

**Time:** 5-15 minutes (depending on internet speed)

**Note:** You only need to do this once, or when you want to update to the latest code.

### Step 2: Run the Container

```cmd
run.bat
```

**What happens:**
- Starts the container in detached mode
- Exposes all required ports to localhost
- Starts all three services automatically

**Wait Time:** 30-60 seconds for all services to fully start

### Step 3: Access the Application

Open your browser and navigate to:
- **Frontend Application:** http://localhost:5173
- **API Server:** http://localhost:3000

### Step 4: Stop the Container

When you're done:

```cmd
stop.bat
```

**What happens:**
- Stops the running container
- Removes the container instance
- The image remains for next time

**Note:** No data is persisted - fresh start every time you run.

## Usage Workflow

### Daily Usage

1. **Start:** Run `run.bat` in the morning
2. **Use:** Access http://localhost:5173 in your browser
3. **Stop:** Run `stop.bat` when done

### When Updates Are Available

1. **Stop:** Run `stop.bat` if container is running
2. **Rebuild:** Run `build.bat` to get latest code
3. **Start:** Run `run.bat` to use updated version

## Exposed Ports

The container exposes these ports to your localhost:

- **5173** - Frontend (React/Vite app)
- **3000** - Backend API (Express server)
- **8765** - Flattrade WebSocket server
- **8766** - Shoonya WebSocket server

## Useful Commands

### View Container Logs

To see what's happening inside the container:

```cmd
podman logs -f steadfast-container
```

Press `Ctrl+C` to stop viewing logs (container keeps running).

### Check Running Containers

```cmd
podman ps
```

### List All Container Images

```cmd
podman images
```

### Remove Container Image (Clean Up)

If you want to completely remove the image to save disk space:

```cmd
podman rmi steadfast-app:latest
```

**Note:** You'll need to rebuild with `build.bat` before using again.

## Troubleshooting

### Container won't start

**Error:** "Image not found"
- **Solution:** Run `build.bat` first

**Error:** "Port already in use"
- **Solution:** Another application is using ports 5173, 3000, 8765, or 8766
- Stop the other application or change the ports in `run.bat`

### Services not accessible

**Issue:** Can't access http://localhost:5173
- **Wait:** Services take 30-60 seconds to start after running `run.bat`
- **Check logs:** `podman logs -f steadfast-container`
- **Restart:** Run `stop.bat` then `run.bat` again

### Build fails

**Error:** During `build.bat`
- **Network:** Check your internet connection
- **Disk space:** Ensure you have at least 3-4 GB free space
- **Podman:** Make sure Podman Desktop is running

### Container already running

**Error:** When running `run.bat`
- **Solution:** Run `stop.bat` first, then `run.bat` again

## Architecture

```
┌─────────────────────────────────────────┐
│   Podman Container: steadfast-app       │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │ steadfast-app (React/Vite)       │  │
│  │ Port: 5173                       │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │ steadfast-api (Express)          │  │
│  │ Port: 3000                       │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │ steadfast-websocket (Python)     │  │
│  │ Ports: 8765, 8766                │  │
│  └──────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
              ↓ Port Mapping
     http://localhost:5173 (Frontend)
     http://localhost:3000 (API)
     ws://localhost:8765 (Flattrade WS)
     ws://localhost:8766 (Shoonya WS)
```

## Benefits of This Setup

✅ **Clean Desktop** - No Node.js, Python, or dependencies on your system
✅ **Isolated** - Application runs in complete isolation
✅ **Fresh Start** - No stale data or configuration issues
✅ **Easy Updates** - Just rebuild the image
✅ **Portable** - Same setup works on any Windows machine with Podman
✅ **Safe** - Can't mess up your system configuration

## Storage Usage

- **Container Image:** ~1-2 GB (stored in Podman storage)
- **Running Container:** Minimal additional space

## Support

For issues with the Steadfast application itself, see:
- [Steadfast Monorepo](https://github.com/narenkram/steadfast-monorepo)
- [Telegram Channel](https://t.me/steadfastapp)

For container-specific issues, check the troubleshooting section above.
