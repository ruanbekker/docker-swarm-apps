#!/bin/sh
set -e
eval $(python /exporter.py)
python /app.py
