#!/usr/bin/env bash
# Uso: ./scripts/run-scan.sh https://mi-sitio.com
# Opcional: ZAP_PATH=/ruta/a/zap.sh
set -euo pipefail
cd "$(dirname "$0")/.."

export TARGET_URL="${1:-http://testphp.vulnweb.com}"   # sitio de prueba público de Acunetix
export REPORT_DIR="$(pwd)/reports"

# Localizar ZAP
ZAP="${ZAP_PATH:-}"
if [ -z "$ZAP" ]; then
  for c in "$(command -v zap.sh 2>/dev/null || true)" \
           /opt/zaproxy/zap.sh /usr/share/zaproxy/zap.sh \
           /Applications/ZAP.app/Contents/Java/zap.sh; do
    [ -n "$c" ] && [ -x "$c" ] && ZAP="$c" && break
  done
fi
[ -z "$ZAP" ] && { echo "No encontré zap.sh. Define ZAP_PATH=/ruta/a/zap.sh"; exit 1; }

echo "ZAP:      $ZAP"
echo "Objetivo: $TARGET_URL"
mkdir -p "$REPORT_DIR"
"$ZAP" -cmd -autorun "$(pwd)/automation/plan.yaml"
echo "Reporte: $REPORT_DIR/zap-report.html"
