param(
  [int]$Port = 8000
)

# run-local.ps1
# Tries to start a simple static server (Python or npx) and opens the default browser.
# Usage: .\run-local.ps1    or  .\run-local.ps1 -Port 8080

$cwd = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $cwd

Write-Host "Starting local server in: $cwd on port $Port" -ForegroundColor Cyan

# Prefer python (py or python)
if (Get-Command py -ErrorAction SilentlyContinue) {
  Write-Host "Using 'py -3 -m http.server $Port'" -ForegroundColor Yellow
  Start-Process -FilePath py -ArgumentList "-3", "-m", "http.server", "$Port"
} elseif (Get-Command python -ErrorAction SilentlyContinue) {
  Write-Host "Using 'python -m http.server $Port'" -ForegroundColor Yellow
  Start-Process -FilePath python -ArgumentList "-m", "http.server", "$Port"
} elseif (Get-Command npx -ErrorAction SilentlyContinue) {
  Write-Host "Using 'npx http-server -p $Port'" -ForegroundColor Yellow
  Start-Process -FilePath npx -ArgumentList "http-server", "-p", "$Port"
} else {
  Write-Host "No python or npx found. Please install Python 3 or Node.js, or use VS Code Live Server." -ForegroundColor Red
  exit 1
}

Start-Sleep -Milliseconds 800
$uri = "http://localhost:$Port/"
Write-Host "Opening $uri" -ForegroundColor Green
Start-Process $uri

Write-Host "Server started. To stop it, find the server process and terminate it (or close the terminal window)." -ForegroundColor Cyan
