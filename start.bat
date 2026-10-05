@echo off
setlocal
cd /d "%~dp0"
title ROS 2 + Gazebo

where docker >nul 2>&1
if errorlevel 1 (
  echo Docker is not installed.
  echo Install Docker Desktop from https://www.docker.com/products/docker-desktop/ and run this again.
  pause
  exit /b 1
)

docker info >nul 2>&1
if not errorlevel 1 goto dockerready
echo Starting Docker Desktop...
start "" "%ProgramFiles%\Docker\Docker\Docker Desktop.exe"
echo Waiting for Docker to be ready (this can take a minute)...
:waitdocker
timeout /t 3 /nobreak >nul
docker info >nul 2>&1
if errorlevel 1 goto waitdocker
:dockerready

echo Building / starting the ROS 2 + Gazebo container.
echo The first run downloads about 3 GB and can take a while.
docker compose up -d --build
if errorlevel 1 (
  echo.
  echo Failed to start the container. See the messages above.
  pause
  exit /b 1
)

echo Waiting for the desktop to come up...
:waitweb
timeout /t 2 /nobreak >nul
curl -s -o nul http://127.0.0.1:6080/ || goto waitweb

start "" "http://127.0.0.1:6080/vnc.html?autoconnect=true&resize=remote"
echo.
echo Desktop is open in your browser:  http://127.0.0.1:6080
echo Password if asked: ubuntu
echo Run stop.bat when you are done.
pause
