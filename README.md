[![English](https://img.shields.io/badge/lang-en-blue.svg)](README.md)
[![Arabic](https://img.shields.io/badge/lang-ar-green.svg)](README.ar.md)

# 🔐 Project Zipper with Password Protection

This project provides a simple `compressor.bat` script to package a selected file (PDF, DOCX, etc.) into a secure ZIP format for submissions.

---

## 🧭 How It Works

1. Run `compressor.bat`.
2. Select any file when prompted (default: all file types).
3. The script will:
   - Generate a secure random password.
   - Compress the selected file into a password-protected ZIP named:  
     `Defending and Securing Systems Project.zip`
   - Place that ZIP inside a non-password-protected ZIP named:  
     `Final_Project_Submission.zip`

4. A file named `Submission_Password_Info.txt` will open in Notepad.  
   This file contains the password – **paste it into the submission description.**

---

## 📁 Example Output Structure

📁 YourFolder/
├── compressor.bat
├── 7za.exe
├── Final_Project_Submission.zip
├── Submission_Password_Info.txt
└── Project_Folder/
└── Defending and Securing Systems Project.zip

---

## 📦 Requirements

- Windows with PowerShell enabled
- Internet access (only needed once to auto-download `7za.exe`)

---

## 📃 License

MIT License — Free to use and modify.

---
