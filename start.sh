#!/bin/bash
# Linux/macOS equivalent of start.bat.
set -e
cd "$(dirname "$0")"
docker compose up -d --build
echo "Waiting for the desktop..."
until curl -s -o /dev/null http://127.0.0.1:6080/; do sleep 2; done
URL="http://127.0.0.1:6080/vnc.html?autoconnect=true&resize=remote"
echo "Open $URL  (password: ubuntu)"
(xdg-open "$URL" || open "$URL") >/dev/null 2>&1 || true
