# Proyecto OWASP ZAP (sin Docker)

Escaneo automatizado con **ZAP Automation Framework**, usando solo ZAP instalado localmente.

## Requisitos
- [ZAP](https://www.zaproxy.org/download/) instalado (incluye Java; en Linux/Mac puede requerir JDK 17+).

## Estructura
```
automation/plan.yaml     # Plan: spider → ajax spider → pasivo → activo → reportes
scripts/run-scan.sh      # Linux / macOS
scripts/run-scan.bat     # Windows
reports/                 # Salida HTML y JSON
```

## Uso
```bash
./scripts/run-scan.sh https://mi-sitio.com        # Linux/macOS
scripts\run-scan.bat https://mi-sitio.com         # Windows
```
Sin argumento escanea `http://testphp.vulnweb.com` (sitio vulnerable público creado para pruebas).
Abre `reports/zap-report.html` al terminar.

Si ZAP no está en una ruta estándar: `ZAP_PATH=/ruta/zap.sh ./scripts/run-scan.sh ...`
(en Windows: `set ZAP_PATH=...`).

## Personalizar
- Duración y profundidad: ajusta los `max...Duration` en `automation/plan.yaml`.
- Escaneo rápido/seguro: elimina el job `activeScan` y queda solo spider + pasivo.
- Apps con login: añade `authentication` y `users` al contexto
  (https://www.zaproxy.org/docs/automate/automation-framework/).

## Aviso
El escaneo activo lanza ataques reales. Úsalo solo en sistemas propios o con autorización escrita.
