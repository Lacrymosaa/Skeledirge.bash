#!/bin/bash

echo "---------------------------------------------------"
echo "🐊 Skeledirge (Linux Edition) - by Lacrymosaa"
echo "---------------------------------------------------"

SPOTIFY_PATHS=(
    "/opt/spotify/spotify"
    "$HOME/.local/share/spotify-launcher/install/usr/share/spotify/spotify"
    "/usr/share/spotify/spotify"
)

SPOTIFY_EXE=""
for path in "${SPOTIFY_PATHS[@]}"; do
    if [ -f "$path" ]; then
        SPOTIFY_EXE="$path"
        break
    fi
done

DATA_DIR="$HOME/.local/share/Skeledirge"
DB_FILE="$DATA_DIR/last_update.txt"

mkdir -p "$DATA_DIR"

apply_patch() {
    echo -e "\n[Spicetify] ⚠️ Aplicando Spicetify (Update ou Primeira Instalação)..."

    export PATH="$PATH:$HOME/.spicetify"

    echo "[Executando] Download e Instalação..."
    curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

    echo "[Executando] Aplicando Backup/Tema..."
    spicetify backup apply

    echo "[Spicetify] ✅ Processo finalizado."
}

if [ -z "$SPOTIFY_EXE" ]; then
    echo "❌ ERRO CRÍTICO: Executável do Spotify não encontrado."
    exit 1
fi

CURRENT_SIG=$(stat -c "%s_%Y" "$SPOTIFY_EXE")

if [ ! -f "$DB_FILE" ]; then
    echo "🆕 Primeira execução detectada."
    apply_patch
    echo "$CURRENT_SIG" > "$DB_FILE"
    sleep 3
    exit 0
fi

SAVED_SIG=$(cat "$DB_FILE")

if [ "$CURRENT_SIG" != "$SAVED_SIG" ]; then
    echo "🔄 ATUALIZAÇÃO DO SPOTIFY DETECTADA!"
    echo "   Antigo: $SAVED_SIG"
    echo "   Novo:   $CURRENT_SIG"
    apply_patch
    echo "$CURRENT_SIG" > "$DB_FILE"
else
    echo "✅ Spotify atualizado e seguro. Nenhuma ação necessária."
fi

sleep 3
