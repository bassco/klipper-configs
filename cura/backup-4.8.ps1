$version = "4.8"
$cura = "$env:APPDATA\cura"
$curaPath = "$cura\$version"
$backupPath = "$PSScriptRoot\$version\"
New-Item -Path $backupPath -ItemType Directory -Force
Copy-Item -Path $curaPath\definition_changes -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\extruders -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\machine_instances -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\materials -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\quality_changes -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\user -Destination $backupPath -Recurse -Force
Copy-Item -Path $curaPath\*.cfg -Destination $backupPath -Force
Copy-Item -Path $curaPath\*.json -Destination $backupPath -Force
Write-Host "Files backed up:" (Get-ChildItem -Path $version -Recurse).Count