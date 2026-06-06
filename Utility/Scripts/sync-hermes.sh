#!/bin/bash
# SaenBarrel Sync Script
# Sync Hermes state between Matebook (Windows) and Pi
# Usage: ./sync.sh [push|pull|bidirectional]

set -e

PI_HOST="admin@192.168.1.109"
PI_HERMES="/home/admin/.hermes"
LOCAL_HERMES="$HOME/.hermes"

# Files to sync
SYNC_FILES=(
    "state.db"
    "state.db-shm"
    "state.db-wal"
)

pull_from_pi() {
    echo "Pulling from Pi..."
    for f in "${SYNC_FILES[@]}"; do
        if ssh "$PI_HOST" "test -f $PI_HERMES/$f" 2>/dev/null; then
            scp -q "$PI_HOST:$PI_HERMES/$f" "$LOCAL_HERMES/$f"
            echo "  Pulled: $f"
        fi
    done
    echo "Pull complete."
}

push_to_pi() {
    echo "Pushing to Pi..."
    for f in "${SYNC_FILES[@]}"; do
        if [ -f "$LOCAL_HERMES/$f" ]; then
            scp -q "$LOCAL_HERMES/$f" "$PI_HOST:$PI_HERMES/$f"
            echo "  Pushed: $f"
        fi
    done
    echo "Push complete."
}

bidirectional_sync() {
    echo "Bidirectional sync (Pi is source of truth)..."
    pull_from_pi
    echo "Done."
}

case "${1:-bidirectional}" in
    pull)   pull_from_pi ;;
    push)   push_to_pi ;;
    bidirectional) bidirectional_sync ;;
    *)      echo "Usage: $0 [push|pull|bidirectional]" ;;
esac
