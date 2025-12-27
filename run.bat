@echo off
REM Run script for Steadfast container

echo ========================================
echo Starting Steadfast Container
echo ========================================
echo.

REM Check if container is already running
podman ps | findstr steadfast-container >nul
if %ERRORLEVEL% EQU 0 (
    echo Container is already running!
    echo Use stop.bat to stop it first.
    echo.
    pause
    exit /b 1
)

echo Starting container...
echo.

podman run -d ^
    --name steadfast-container ^
    -p 5173:5173 ^
    -p 3000:3000 ^
    -p 8765:8765 ^
    -p 8766:8766 ^
    steadfast-app:latest

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Container started successfully!
    echo ========================================
    echo.
    echo Services are starting up...
    echo Please wait 30-60 seconds for all services to be ready.
    echo.
    echo Access the application at:
    echo   Frontend: http://localhost:5173
    echo   API:      http://localhost:3000
    echo.
    echo To view logs:    podman logs -f steadfast-container
    echo To stop:         stop.bat
    echo.
) else (
    echo.
    echo ========================================
    echo Failed to start container!
    echo ========================================
    echo.
    echo Make sure you have built the image first using build.bat
    echo.
)

pause
