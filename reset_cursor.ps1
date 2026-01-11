# Cursor Trial Reset for Windows
Write-Host "Starting Cursor Reset..." -ForegroundColor Cyan

# Stop Cursor
Stop-Process -Name "Cursor" -ErrorAction SilentlyContinue

$path = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
$dbPath = "$env:APPDATA\Cursor\User\globalStorage\state.vscdb*"

# Remove Read-Only to update
if (Test-Path $path) {
    (Get-Item $path).Attributes = 'Normal'
}

# Remove DB
Remove-Item -Path $dbPath -Force -ErrorAction SilentlyContinue

# Generate IDs
$id1 = [guid]::NewGuid().ToString().ToLower()
$id2 = [guid]::NewGuid().ToString().ToLower()
$id3 = [guid]::NewGuid().ToString()

$json = "{`"telemetry.macMachineId`":`"$id1`",`"telemetry.machineId`":`"$id2`",`"telemetry.devDeviceId`":`"$id3`"}"

Set-Content -Path $path -Value $json
(Get-Item $path).Attributes = 'ReadOnly'

Write-Host "Done! New IDs applied. Use a new email and change your IP." -ForegroundColor Green
