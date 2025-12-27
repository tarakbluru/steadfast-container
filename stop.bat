@echo off
REM Stop script for Steadfast container

echo ========================================
echo Stopping Steadfast Container
echo ========================================
echo.

REM Check if container is running
podman ps | findstr steadfast-container >nul
if %ERRORLEVEL% NEQ 0 (
    echo Container is not running.
    echo.

    REM Check if container exists but is stopped
    podman ps -a | findstr steadfast-container >nul
    if %ERRORLEVEL% EQU 0 (
        echo Removing stopped container...
        podman rm steadfast-container
        echo Done.
    )
    echo.
    pause
    exit /b 0
)

echo Stopping container...
podman stop steadfast-container

if %ERRORLEVEL% EQU 0 (
    echo Removing container...
    podman rm steadfast-container

    echo.
    echo ========================================
    echo Container stopped and removed successfully!
    echo ========================================
    echo.
    echo The container image is still available.
    echo Use run.bat to start it again.
    echo.
) else (
    echo.
    echo ========================================
    echo Failed to stop container!
    echo ========================================
    echo.
)

pause
