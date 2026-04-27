# Genesis Video Desktop — Remote Backend Launcher
# Starts the Electron UI pointing at the Genesis server backend

$env:LTX_REMOTE_BACKEND_URL = "http://100.90.93.123:8000"
$env:LTX_REMOTE_AUTH_TOKEN = ""

Write-Host "Starting Genesis Video Desktop (Remote Backend Mode)"
Write-Host "Backend: $env:LTX_REMOTE_BACKEND_URL"

Set-Location $PSScriptRoot\..
pnpm run electron:dev
