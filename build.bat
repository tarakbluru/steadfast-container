@echo off
REM Build script for Steadfast container

echo ========================================
echo Building Steadfast Container Image
echo ========================================
echo.
echo This will take several minutes...
echo.

podman build -t steadfast-app:latest -f Containerfile .

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo Build completed successfully!
    echo ========================================
    echo.
    echo Cleaning up old dangling images...
    podman image prune -f
    echo.
    echo Image created: steadfast-app:latest
    echo.
    echo Next step: Run the container using run.bat
    echo.
) else (
    echo.
    echo ========================================
    echo Build failed! Please check the error messages above.
    echo ========================================
    echo.
)

pause
