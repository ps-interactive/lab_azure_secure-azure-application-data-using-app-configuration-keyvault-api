# creates main.zip file with requires files for PS lab
Compress-Archive -Path .\*.tf,.\*.sh -DestinationPath .\main.zip -Update