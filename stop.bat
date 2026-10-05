@echo off
cd /d "%~dp0"
docker compose stop
echo Stopped. Your files in ~/ros2_ws are kept.
pause
