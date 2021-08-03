$cura = "$env:APPDATA\cura\4.8"
Copy-Item -Path $cura\definition_changes -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\extruders -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\machine_instances -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\materials -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\quality_changes -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\user -Destination $PSScriptRoot -Recurse
Copy-Item -Path $cura\*.cfg -Destination $PSScriptRoot 
Copy-Item -Path $cura\*.json -Destination $PSScriptRoot 
