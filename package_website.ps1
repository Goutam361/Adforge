$desktopPath = "C:\Users\user\OneDrive\Desktop"
$websiteFolder = "$desktopPath\3D website\Website"

Write-Host "Creating directories in $websiteFolder..."
New-Item -ItemType Directory -Force -Path "$websiteFolder\brand" | Out-Null
New-Item -ItemType Directory -Force -Path "$websiteFolder\Video" | Out-Null
New-Item -ItemType Directory -Force -Path "$websiteFolder\design" | Out-Null

Write-Host "Copying brand folder..."
if (Test-Path "$desktopPath\brand") {
    Copy-Item -Path "$desktopPath\brand\*" -Destination "$websiteFolder\brand" -Recurse -Force
}

Write-Host "Copying Video folder..."
if (Test-Path "$desktopPath\Video") {
    Copy-Item -Path "$desktopPath\Video\*" -Destination "$websiteFolder\Video" -Recurse -Force
}

Write-Host "Copying design folder..."
if (Test-Path "$desktopPath\design") {
    Copy-Item -Path "$desktopPath\design\*" -Destination "$websiteFolder\design" -Recurse -Force
}

Write-Host "Copying absolute path video from Downloads..."
$absVideo = "C:\Users\user\Downloads\hf_20260509_121724_565834f8-cd68-467a-bffd-afb535612b13.mp4"
if (Test-Path $absVideo) {
    Copy-Item -Path $absVideo -Destination "$websiteFolder\Video\hf_20260509_121724_565834f8-cd68-467a-bffd-afb535612b13.mp4" -Force
}

Write-Host "Updating index.html paths and copying to Website folder..."
$indexContent = Get-Content -Path "$desktopPath\3D website\index.html" -Raw

# Replace paths to make them relative to the current folder
$indexContent = $indexContent -replace "\.\./brand/", "./brand/"
$indexContent = $indexContent -replace "\.\./Video/", "./Video/"
$indexContent = $indexContent -replace "\.\./design/", "./design/"
$indexContent = $indexContent -replace "file:///C:/Users/user/Downloads/hf_20260509_121724_565834f8-cd68-467a-bffd-afb535612b13.mp4", "./Video/hf_20260509_121724_565834f8-cd68-467a-bffd-afb535612b13.mp4"

Set-Content -Path "$websiteFolder\index.html" -Value $indexContent -Encoding UTF8

Write-Host "`n================================================="
Write-Host "Success! The website has been packaged."
Write-Host "You can now zip the 'Website' folder and send it."
Write-Host "================================================="
Write-Host "`nPress any key to exit..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
