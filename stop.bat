@echo off
REM Stop script for Steadfast container (preserves container data)

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
        echo Container already stopped.
        echo.
        echo Use run.bat to start it again.
    ) else (
        echo No container found.
        echo Use run.bat to create and start it.
    )
    echo.
    pause
    exit /b 0
)

echo Stopping container...
podman stop steadfast-container

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Container stopped successfully!
    echo ========================================
    echo.
    echo Container data preserved (including broker connections).
    echo Use run.bat to start it again.
    echo.
    echo To remove container completely: podman rm steadfast-container
    echo.
) else (
    echo.
    echo ========================================
    echo Failed to stop container!
    echo ========================================
    echo.
)

pause
