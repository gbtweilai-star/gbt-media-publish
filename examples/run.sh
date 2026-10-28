#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_media_publish info
PYTHONPATH=src python -m gbt_media_publish check --payload '{}'
PYTHONPATH=src python -m gbt_media_publish run   --payload '{}'
