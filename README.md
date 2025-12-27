# Steadfast Container Setup

[![Podman](https://img.shields.io/badge/Podman-892CA0?style=flat&logo=podman&logoColor=white)](https://podman.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> **Run the complete Steadfast Trading App stack in an isolated container on Windows**

This repository provides a containerized setup for the [Steadfast Monorepo](https://github.com/narenkram/steadfast-monorepo) - allowing you to run the entire trading application (Frontend + API + WebSocket) in a single Podman/Docker container without installing Node.js, Python, or any dependencies on your system.

---

## 🚀 Quick Start

### Prerequisites

- **Windows 10/11**
- **Podman Desktop** ([Download here](https://podman.io/downloads)) or **Docker Desktop**
- **3-4 GB free disk space**

### Installation

1. **Clone this repository:**
   ```powershell
   git clone https://github.com/tarakbluru/steadfast-container.git
   cd steadfast-container
   ```

2. **Build the container image** (first time only, takes 5-15 minutes):
   ```powershell
   .\build.bat
   ```

3. **Run the container:**
   ```powershell
   .\run.bat
   ```

4. **Open your browser:**
   ```
   http://localhost:5173
   ```

5. **Stop when done:**
   ```powershell
   .\stop.bat
   ```

---

## 📋 What's Included

This container setup includes all three components of the Steadfast stack:

- **Frontend** (React + Vite) - Port 5173
- **Backend API** (Express.js) - Port 3000
- **WebSocket Services** (Python) - Ports 8765 (Flattrade), 8766 (Shoonya)

---

## 📂 Files Overview

| File | Purpose |
|------|---------||
| `Containerfile` | Container image build instructions |
| `startup.sh` | Service orchestration script (runs inside container) |
| `build.bat` | Build the container image (Windows) |
| `run.bat` | Run the container (Windows) |
| `stop.bat` | Stop and remove the container (Windows) |
| `README-CONTAINER.md` | Detailed documentation and troubleshooting |
| `SETUP-INSTRUCTIONS.txt` | Quick setup guide |

---

## 🎯 Usage

### Daily Workflow

```powershell
# Start the app
.\run.bat

# Use the application at http://localhost:5173

# Stop when done
.\stop.bat
```

### Updating to Latest Version

When Steadfast releases updates:

```powershell
.\stop.bat      # Stop current container
.\build.bat     # Rebuild with latest code
.\run.bat       # Run updated version
```

---

## 🔧 Troubleshooting

### Container won't start
- **Solution:** Make sure you ran `build.bat` first

### Port already in use
- **Solution:** Check if ports 3000, 5173, 8765, or 8766 are being used by another application

### Services not responding
- **Wait:** Services take 30-60 seconds to fully start
- **Check logs:** `podman logs -f steadfast-container`
- **Restart:** Run `stop.bat` then `run.bat`

### Build fails
- **Check internet connection** - downloads ~2 GB during build
- **Ensure Podman/Docker is running**
- **Check disk space** - needs 3-4 GB free

For detailed troubleshooting, see [README-CONTAINER.md](README-CONTAINER.md)

---

## 🌐 Exposed Ports

The container exposes these ports to your localhost:

| Port | Service | Description |
|------|---------|-------------|
| 5173 | Frontend | React/Vite web interface (main UI) |
| 3000 | API | Express.js backend server |
| 8765 | WebSocket | Flattrade WebSocket server |
| 8766 | WebSocket | Shoonya WebSocket server |

---

## ✨ Benefits

✅ **Zero Desktop Pollution** - No Node.js, Python, or dependencies on your system
✅ **Complete Isolation** - Everything runs in a container
✅ **Fresh Start** - Clean state every time (no credential persistence)
✅ **Easy Updates** - Just rebuild the image
✅ **Cross-Platform Ready** - Works on any Windows machine with Podman/Docker
✅ **Safe** - Can't mess up your system configuration

---

## 🏗️ Architecture

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

---

## 🛠️ Advanced Usage

### View Container Logs

```powershell
podman logs -f steadfast-container
```

### List Running Containers

```powershell
podman ps
```

### Execute Commands Inside Container

```powershell
podman exec -it steadfast-container bash
```

### Check Container Resource Usage

```powershell
podman stats steadfast-container
```

### Remove Container Image Completely

```powershell
podman rmi steadfast-app:latest
```

---

## 📚 Additional Documentation

- **[README-CONTAINER.md](README-CONTAINER.md)** - Comprehensive guide with detailed troubleshooting
- **[SETUP-INSTRUCTIONS.txt](SETUP-INSTRUCTIONS.txt)** - Quick setup reference

---

## ⚠️ Important Notes

- **Fresh Start Policy:** This container does NOT persist login credentials or session data. You'll need to login fresh each time you run it.
- **Development vs Production:** The container runs in production mode for better performance and proper network binding.
- **Original Project:** This is a containerized wrapper for [steadfast-monorepo](https://github.com/narenkram/steadfast-monorepo). All credit for the application goes to the original developers.

---

## 🔗 Related Links

- **Original Steadfast Monorepo:** https://github.com/narenkram/steadfast-monorepo
- **Steadfast Premium Version:** https://www.steadfastapp.in
- **Telegram Channel:** https://t.me/steadfastapp
- **Podman Documentation:** https://docs.podman.io/
- **Docker Documentation:** https://docs.docker.com/

---

## 📝 License

This container setup is provided as-is for personal use. The Steadfast application itself is subject to its own license terms.

---

## 🤝 Contributing

Found an issue or have an improvement? Feel free to:
- Open an issue
- Submit a pull request
- Share your feedback

---

## 💡 Support

For container-specific issues, open an issue in this repository.

For Steadfast application issues:
- Visit the [original repository](https://github.com/narenkram/steadfast-monorepo)
- Join the [Telegram channel](https://t.me/steadfastapp)

---

**Made with ❤️ for the Steadfast trading community**
