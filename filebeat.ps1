# Execute in an administrative powershell: Set-ExecutionPolicy UnRestricted -Force
# Then Run: ./filebeat.ps1
# Version FileBeat 8.4.3
Write-Host "Downloading Filebeat..."
Invoke-WebRequest "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.4.3-windows-x86_64.zip" -OutFile "filebeat.zip" -UseBasicParsing
Expand-Archive "filebeat.zip" -Force
Remove-Item "filebeat.zip" -Force
Copy-Item .\filebeat\filebeat-8.4.3-windows-x86_64\ -Destination "C:\Program Files\" -Recurse -Force
Write-Host "Filebeat in path: C:\Program Files\filebeat\"
Remove-Item .\filebeat\ -Force -Recurse
Set-Location "C:\Program Files\"
Rename-Item "filebeat-8.4.3-windows-x86_64" "filebeat"
Set-Location "C:\Program Files\filebeat\"
Write-Host "Installing service Filebeat"
.\install-service-filebeat.ps1 -Force -Verbose
Write-Host "Testing Filebeat..."
.\filebeat.exe test config -c .\filebeat.yml
Write-Host "Configuration in path: C:\Program Files\filebeat\filebeat.yml"
Write-Host "For start WinlogBeat in an administrative powershell: Start-Service filebeat"
Set-ExecutionPolicy Undefined -Force