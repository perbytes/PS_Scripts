# Check if another instance of the script is running

$scriptName = "Rclone_Seedbox.ps1"
$scriptProcess = Get-Process -Name "powershell" -IncludeUserName | Where-Object { $_.Path -match $scriptName -and $_.UserName -eq $env:UserName }

if ($scriptProcess.Count -gt 1) {
    Write-Host "Another instance of the script is already running. Exiting." -ForegroundColor Yellow
    exit
}

# Change the following variables
# Make sure to have your rlcone config configured before continuting.

$rclonePath = "C:\Users\JonDoe\Desktop\rclone\rclone.exe"
$sourceDirectory = "Seedbox:/temp/example/"
$destinationDirectory = "C:\Users\JonDoe\Example"
$logFilePath = "C:\Users\JonDoe\Desktop\rclone\log.txt" 

$retries = 3

$rcloneCommand = "$rclonePath move --bwlimit 12M --progress --delete-empty-src-dirs --verbose --log-file=$logFilePath --no-traverse --checksum --transfers=4 --retries=$retries $sourceDirectory $destinationDirectory"

try {
    Invoke-Expression $rcloneCommand
    Write-Host "Folder structure and files moved successfully!"-ForegroundColor Green
} catch {
    Write-Host "An error occurred while moving the folder structure and files: $_" -ForegroundColor Red
}