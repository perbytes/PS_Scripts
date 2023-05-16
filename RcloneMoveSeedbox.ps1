# Check if another instance of the script is running
$scriptName = "RcloneMoveSeedbox.ps1"
$scriptProcess = Get-Process -Name "powershell" -IncludeUserName | Where-Object { $_.Path -match $scriptName -and $_.UserName -eq $env:UserName }

if ($scriptProcess.Count -gt 1) {
    Write-Host "Another instance of the script is already running. Exiting." -ForegroundColor Yellow
    exit
}

# Change the following variables
# Make sure you to have your rlcone config configured before continuting. 

$rclonePath = "C:\Users\USER\Desktop\rclone\rclone.exe"
$sourceDirectory = "Seedbox:/home/downloads/"
$destinationDirectory = "F:\Media\Series"
$logFilePath = "C:\Users\Administrator\Desktop\rclone\log.txt"

# Set the number of retries
$retries = 3

# Execute rclone command to move the directories
$rcloneCommand = "$rclonePath move --progress --verbose --log-file=$logFilePath --no-traverse --checksum --retries=$retries $sourceDirectory $destinationDirectory"

try {
    # Executing the rclone command
    Invoke-Expression $rcloneCommand
    Write-Host "Folder structure and files moved successfully!"-ForegroundColor Green
} catch {
    Write-Host "An error occurred while moving the folder structure and files: $_" -ForegroundColor Red
}