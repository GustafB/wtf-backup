$sourcePath = 'C:\Program Files (x86)\World of Warcraft\_classic_era_\WTF'
$backupRoot = 'C:\Backups\WoW_WTF'
$maxBackups = 30

if (-not (Test-Path $backupRoot)) {
    New-Item -Path $backupRoot -ItemType Directory | Out-Null
}

$timestamp  = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupFile = Join-Path $backupRoot ("WTF_{0}.zip" -f $timestamp)

Compress-Archive -Path $sourcePath -DestinationPath $backupFile -Force

Get-ChildItem -Path $backupRoot -Filter 'WTF_*.zip' |
    Sort-Object CreationTime -Descending |
    Select-Object -Skip $maxBackups |
    Remove-Item -Force

