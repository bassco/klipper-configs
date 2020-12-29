# LPC Setup

## Install python and esptool

```shell
choco install python3
choco install esptool
```

## Download firmware
There are three parts to the system:
* [SKR LPC](https://github.com/gloomyandy/RepRapFirmware/releases/) the Duet board firmware
* [DuetWebControl](https://github.com/Duet3D/DuetWebControl/releases) which is the web UI
* [DuetControlWifiServer](https://github.com/gloomyandy/RepRapFirmware/releases) that runs on the esp8266

```shell
wget https://github.com/gloomyandy/RepRapFirmware/releases/download/v3.2-beta4.1_1/firmware-lpc-esp8266wifi-3.2-beta4.1_1.bin
wget https://github.com/gloomyandy/DuetWiFiSocketServer/releases/download/V1.25B0-01/DuetWiFiServer-lpc-el.bin
wget https://github.com/Duet3D/DuetWebControl/releases/download/3.2.0-rc2/DuetWebControl-SD.zip
```

## Flash esp8266

Plug the device into the PC. Use Device Manager to determine the COM port that it has attached to. e.g. COM6

Start the esptool from an Administrator prompt and when the app is in the "Connecting" state, press the _flash_ button on the device.

```code
C:\python39\lib\site-packages\esptool.py --port COM6 write_flash 0x00000 E:\firmware-files\DuetWiFiServer-lpc-el.bin

esptool.py v3.0
Serial port COM6
Connecting........_____....._____....._____....._____.
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: ec:fa:bc:58:c4:61
Uploading stub...
Running stub...
Stub running...
Configuring flash size...
Compressed 343088 bytes to 237024...
Wrote 343088 bytes (237024 compressed) at 0x00000000 in 21.7 seconds (effective 126.4 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
```

## Update board firmware

Upload the firmware..... file without renaming to the device. It will self update

## Update DWC

Upload the downloaded zip from the github releases asset and upload the zip file. It will extract and process all the files in the zip and then update.

Setup the theme colour of dark :smile:

End.