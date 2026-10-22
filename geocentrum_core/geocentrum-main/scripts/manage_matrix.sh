#!/bin/bash
set +H

ACTION=${1:-status}
SERVER_DIR="matrix_server"

if [ ! -d "$SERVER_DIR" ]; then
    echo "⚠️ Matrix server map niet gevonden. Voer eerst de configuratie uit."
    exit 1
fi

cd "$SERVER_DIR" || exit

# Bepaal of we 'docker compose' of 'docker-compose' moeten gebruiken
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo "❌ Fout: Docker Compose is niet geïnstalleerd op dit systeem."
    exit 1
fi

case "$ACTION" in
    start)
        echo "🚀 Matrix/Conduit signaling server starten..."
        $DOCKER_COMPOSE up -d
        echo "✅ Server gestart op poort 6167."
        ;;
    stop)
        echo "🛑 Matrix/Conduit signaling server stoppen..."
        $DOCKER_COMPOSE down
        echo "✅ Server gestopt."
        ;;
    logs)
        echo "📜 Matrix server logs opvragen..."
        $DOCKER_COMPOSE logs -f
        ;;
    status)
        $DOCKER_COMPOSE ps
        ;;
    *)
        echo "Gebruik: ./scripts/manage_matrix.sh [start|stop|logs|status]"
        exit 1
        ;;
esac
