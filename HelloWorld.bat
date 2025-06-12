@echo off
setlocal enabledelayedexpansion

echo --- Project Submission Zipper (Standalone) ---

set "PROJECT_FOLDER_NAME=Defending and Securing Systems Project"
set "ENCRYPTED_REPORT_ZIP_NAME=Defending and Securing Systems Project - Encrypted Report.zip"
set "FINAL_PROJECT_ZIP_NAME=Defending and Securing Systems Project.zip"
set "PORTABLE_7ZIP_FOLDER=_7z_portable"
set "PORTABLE_7ZIP_ARCHIVE=7z2409-extra.7z"
set "PORTABLE_7ZIP_URL=https://www.7-zip.org/a/7z2409-extra.7z"
set "SEVEN_ZIP_EXE="
set "SCRIPT_DIR=%~dp0"
set "OUTPUT_TXT_FILE=Submission_Details.txt"

set "SEVEN_ZIP_EXE=%~dp0\7za.exe"

if not exist "!SEVEN_ZIP_EXE!" (
    echo Error: 7za.exe not found in the script directory.
    pause
    goto :eof
)

echo Found local 7za.exe at: "!SEVEN_ZIP_EXE!"


echo.
echo Generating a random password...
for /f "delims=" %%a in ('powershell -command "$pass = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 16 | ForEach-Object {[char]$_}); Write-Host $pass"') do set "GENERATED_PASSWORD=%%a"
echo Your generated password: !GENERATED_PASSWORD!
echo Please copy this password and save it securely. It will also be shown at the end.

echo.
echo Opening file explorer to select your PDF or Word document report...
for /f "delims=" %%a in ('powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; $file = New-Object System.Windows.Forms.OpenFileDialog; $file.InitialDirectory = '%cd%'; $file.Filter = 'Word Documents (*.doc;*.docx)|*.doc;*.docx|PDF Documents (*.pdf)|*.pdf|All Files (*.*)|*.*'; $file.ShowDialog() | Out-Null; $file.FileName}"') do set "REPORT_FILE_FULL_PATH=%%a"

if not defined REPORT_FILE_FULL_PATH (
    echo Error: No file selected. Exiting.
    pause
    goto :eof
)

echo Selected file: "!REPORT_FILE_FULL_PATH!"

for %%i in ("!REPORT_FILE_FULL_PATH!") do set "REPORT_FILE_DIR=%%~dpi"
for %%i in ("!REPORT_FILE_FULL_PATH!") do set "REPORT_FILE_NAME=%%~nxi"

echo Target output directory: "!REPORT_FILE_DIR!"

set "FULL_PATH_ENCRYPTED_REPORT_ZIP=!REPORT_FILE_DIR!!ENCRYPTED_REPORT_ZIP_NAME!"
set "FULL_PATH_PROJECT_FOLDER=!REPORT_FILE_DIR!!PROJECT_FOLDER_NAME!"
set "FULL_PATH_FINAL_PROJECT_ZIP=!REPORT_FILE_DIR!!FINAL_PROJECT_ZIP_NAME!"
set "FULL_PATH_ENCRYPTED_ZIP_IN_PROJECT_FOLDER=!FULL_PATH_PROJECT_FOLDER!\!ENCRYPTED_REPORT_ZIP_NAME!"

echo.
echo Attempting to create password-protected zip: "!FULL_PATH_ENCRYPTED_REPORT_ZIP!"
"!SEVEN_ZIP_EXE!" a -tzip -p!GENERATED_PASSWORD! "!FULL_PATH_ENCRYPTED_REPORT_ZIP!" "!REPORT_FILE_FULL_PATH!"
if !errorlevel! neq 0 (
    echo Error: Failed to create password-protected zip for "!REPORT_FILE_FULL_PATH!".
    echo Please check the 7-Zip command output above for details.
    pause
    goto :eof
)
echo "Report" successfully compressed into "!FULL_PATH_ENCRYPTED_REPORT_ZIP!" with a password.

echo.
echo Creating folder: "!FULL_PATH_PROJECT_FOLDER!"
mkdir "!FULL_PATH_PROJECT_FOLDER!" 2>nul
if !errorlevel! neq 0 (
    echo Folder "!FULL_PATH_PROJECT_FOLDER!" already exists.
) else (
    echo Folder "!FULL_PATH_PROJECT_FOLDER!" created.
)

echo.
echo Moving "!FULL_PATH_ENCRYPTED_REPORT_ZIP!" into "!FULL_PATH_PROJECT_FOLDER!"...
move "!FULL_PATH_ENCRYPTED_REPORT_ZIP!" "!FULL_PATH_PROJECT_FOLDER!\"
if !errorlevel! neq 0 (
    echo Error: Could not move file "!FULL_PATH_ENCRYPTED_REPORT_ZIP!".
    echo It might not have been created in Step 1 or there was a permission issue.
    pause
    goto :eof
)
echo "Encrypted Report Zip" moved to "!FULL_PATH_ENCRYPTED_ZIP_IN_PROJECT_FOLDER!".

echo.
echo Compressing folder "!FULL_PATH_PROJECT_FOLDER!" into "!FULL_PATH_FINAL_PROJECT_ZIP!" (no password)...
"!SEVEN_ZIP_EXE!" a -tzip "!FULL_PATH_FINAL_PROJECT_ZIP!" "!FULL_PATH_PROJECT_FOLDER!\"
if !errorlevel! neq 0 (
    echo Error: Failed to create unprotected zip from folder "!FULL_PATH_PROJECT_FOLDER!".
    pause
    goto :eof
)
echo Folder "!FULL_PATH_PROJECT_FOLDER!" successfully compressed into "!FULL_PATH_FINAL_PROJECT_ZIP!".

echo.
echo Creating submission details file: "%OUTPUT_TXT_FILE%"
(
    echo Project Submission Details
    echo =========================
    echo.
    echo Final Project Zip File Location:
    echo !FULL_PATH_FINAL_PROJECT_ZIP!
    echo.
    echo Password for "Defending and Securing Systems Project - Encrypted Report.zip":
    echo !GENERATED_PASSWORD!
    echo.
    echo ^(Please copy the password above and paste it into the description of your submission^)
    echo.
    echo You can close this window to finish the script.
) > "%OUTPUT_TXT_FILE%"

echo Opening submission details in Notepad...
start "" notepad.exe "%OUTPUT_TXT_FILE%"

echo.
echo --- Process Completed! ---
echo The final zip file and your project folder are in the directory of your selected report.
echo The submission details are open in Notepad.

pause
endlocal
