#!/usr/bin/env bash

# 0. Parse arguments
NO_FORWARD=false
for arg in "$@"; do
    case "$arg" in
        -n|--no-forward)
            NO_FORWARD=true
            ;;
    esac
done

# 1. Start the SSH Tunnel in the background (skipped with --no-forward/-n)
if [ "$NO_FORWARD" = false ]; then
    echo "🚀 Starting SSH tunnels to quindi-solution.devpod..."
    ssh -M \
        -S /tmp/my-tunnel-socket \
        -fN \
        -L 5146:127.0.0.1:5146 \
        -L 5147:127.0.0.1:5147 \
        -L 8080:127.0.0.1:8180 \
        -L 5532:127.0.0.1:5432 \
        -R 3306:localhost:3306 \
        quindi-solution.devpod
else
    echo "⏭️  Skipping SSH tunnel forwarding (--no-forward)"
fi

# 2. Find the container name dynamically
CONTAINER_ID=$(docker ps | grep "vsc-quindisolution" | awk '{print $1}')
if [ -z "$CONTAINER_ID" ]; then
    echo "❌ Error: Could not find a running container matching 'vsc-quindisolution'"
    exit 1
fi

# 3. Enter the Docker Environment
echo "🐳 Connecting to: $CONTAINER_ID..."
docker exec -it \
    --workdir /workspaces/quindi-solution \
    --user vscode \
    $CONTAINER_ID \
    bash -c "nix develop github:lucaSartore/nixos-config?dir=shells/nvim-quindi --refresh"

# 4. Cleanup: Kill the SSH tunnel once the docker session ends (skipped with --no-forward)
if [ "$NO_FORWARD" = false ]; then
    echo "🛑 Docker session closed. Cleaning up SSH tunnels..."
    ssh -S /tmp/my-tunnel-socket -O exit quindi-solution.devpod
    echo "✅ Done."
else
    echo "✅ Done (tunnels left untouched)."
fi
