@echo off
setlocal enabledelayedexpansion

echo --- Project Zipper with Password Protection ---

:: Set paths
set "SCRIPT_DIR=%~dp0"
set "SEVEN_ZIP_EXE=%SCRIPT_DIR%7za.exe"
set "PASSWORD_ZIP_NAME=Defending and Securing Systems Project.zip"
set "FINAL_ZIP_NAME=Final_Project_Submission.zip"
set "TEMP_FOLDER=%SCRIPT_DIR%Project_Folder"
set "DOWNLOAD_URL=https://github.com/omaryomario/BAT-compressor/raw/refs/heads/main/7za.exe"
set "INFO_TXT_FILE=%SCRIPT_DIR%submission_password_info.txt"

:: Check for 7za.exe
if not exist "!SEVEN_ZIP_EXE!" (
    echo 7za.exe not found. Attempting to download from GitHub...
    powershell -Command "try { Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%SEVEN_ZIP_EXE%' -ErrorAction Stop } catch { Write-Error 'Failed to download 7za.exe'; exit 1 }"
    if not exist "!SEVEN_ZIP_EXE!" (
        echo Failed to download 7za.exe. Check your internet connection or download it manually.
        pause
        goto :eof
    )
    echo Downloaded 7za.exe successfully.
)

:: Generate random password
echo.
echo Generating a random password...
for /f "delims=" %%a in ('powershell -command "$p = -join ((48..57)+(65..90)+(97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_}); Write-Output $p"') do set "PASSWORD=%%a"
echo Your generated password: !PASSWORD!

:: Prompt user to select a file
echo.
echo Opening file explorer to select any file for submission...
for /f "delims=" %%f in ('powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.OpenFileDialog; $dlg.InitialDirectory = '%cd%'; $dlg.Filter = 'All Files (*.*)|*.*'; $null = $dlg.ShowDialog(); $dlg.FileName}"') do set "SELECTED_FILE=%%f"

if not defined SELECTED_FILE (
    echo No file selected. Exiting...
    pause
    goto :eof
)

echo Selected file: "!SELECTED_FILE!"

:: Create password-protected zip
echo.
echo Creating password-protected zip: "!PASSWORD_ZIP_NAME!"
"!SEVEN_ZIP_EXE!" a -tzip -p!PASSWORD! -mem=AES256 "%SCRIPT_DIR%!PASSWORD_ZIP_NAME!" "!SELECTED_FILE!"
if !errorlevel! neq 0 (
    echo Failed to create encrypted ZIP.
    pause
    goto :eof
)

:: Small delay and check
timeout /t 1 >nul
if not exist "%SCRIPT_DIR%!PASSWORD_ZIP_NAME!" (
    echo Encrypted ZIP not found after creation. Exiting.
    pause
    goto :eof
)

echo Encrypted ZIP created successfully.

:: Prepare final folder
echo.
echo Creating temporary folder...
mkdir "!TEMP_FOLDER!" 2>nul
timeout /t 1 >nul
if not exist "!TEMP_FOLDER!" (
    echo Failed to create temporary folder. Exiting.
    pause
    goto :eof
)

:: Move password-protected zip into it
echo Moving protected zip into temporary folder...
move /Y "%SCRIPT_DIR%!PASSWORD_ZIP_NAME!" "!TEMP_FOLDER!\" >nul
timeout /t 1 >nul
if not exist "!TEMP_FOLDER!\!PASSWORD_ZIP_NAME!" (
    echo Failed to move encrypted ZIP into temporary folder. Exiting.
    pause
    goto :eof
)

:: Create final normal zip
echo.
echo Creating final zip: "!FINAL_ZIP_NAME!"
"!SEVEN_ZIP_EXE!" a -tzip "%SCRIPT_DIR%!FINAL_ZIP_NAME!" "!TEMP_FOLDER!\*"


:: Clean up temp
del /q "%TEMP_FOLDER%\*" >nul
rd /s /q "!TEMP_FOLDER!" >nul

:: Create info txt file
(
    echo Project Submission Password Info
    echo ========================================
    echo.
    echo Your submission zip: Final_Project_Submission.zip
    echo.
    echo Password for the file inside:
    echo %PASSWORD%
    echo.
    echo Please copy and paste this password into the description when submitting.
    echo.
    echo شكراً لكم
    echo الرجاء نسخ كلمة المرور أعلاه ووضعها في وصف التسليم على المنصة.
    echo.
    echo أدعولي ❤️
) > "%SCRIPT_DIR%Submission_Password_Info.txt"
start "" notepad "%SCRIPT_DIR%Submission_Password_Info.txt"


:: Done
echo.
echo --- Done! ---
echo Final zip created at: "%SCRIPT_DIR%!FINAL_ZIP_NAME!"
echo The password is shown in Notepad.
pause
endlocal
