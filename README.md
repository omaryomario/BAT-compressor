[![Arabic](https://img.shields.io/badge/lang-ar-green.svg)](README.ar.md)

# 🔐 Project Zipper with Password Protection

This project provides a simple `compressor.bat` script to package a selected file (PDF, DOCX, etc.) into a secure ZIP format for submissions.

---

https://github.com/user-attachments/assets/28e04a97-25e2-4105-ac12-13b5840aa9a7


## 📦 How to Install

1. Download or clone this repository:
   git clone https://github.com/your-username/your-repo-name.git

2. Place your report file (e.g., .pdf, .docx) inside the same folder.

3. Ensure `7za.exe` is present next to `compressor.bat`.
   - If it isn't, the script will automatically download it.

4. Run the script:
   - Double-click `compressor.bat` or run it from the terminal:
     compressor.bat

5. Follow the prompts:
   - A password will be generated.
   - Select your file when prompted.
   - A password-protected ZIP and a final submission ZIP will be created.

6. Copy the password from `Submission_Password_Info.txt` and paste it into your assignment's submission description.


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
```
📁 YourFolder/
├── compressor.bat
├── 7za.exe
├── Final_Project_Submission.zip
├── Submission_Password_Info.txt
└── Project_Folder/
└── Defending and Securing Systems Project.zip
```
---

## 📦 Requirements

- Windows with PowerShell enabled
- Internet access (only needed once to auto-download `7za.exe`)

---

## 📃 License

MIT License — Free to use and modify.

---
