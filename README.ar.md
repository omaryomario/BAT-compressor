[![اللغة الإنجليزية](https://img.shields.io/badge/lang-en-blue.svg)](README.md)
[![اللغة العربية](https://img.shields.io/badge/lang-ar-green.svg)](README.ar.md)

# 🔐 ضاغط المشروع مع حماية بكلمة مرور

يوفر هذا المشروع سكربت بسيط باسم `compressor.bat` لضغط ملف محدد (PDF أو DOCX أو غيره) ضمن ملف ZIP محمي بكلمة مرور لتسليمه بأمان.

---
https://github.com/user-attachments/assets/28e04a97-25e2-4105-ac12-13b5840aa9a7


## 📦 كيفية التثبيت

1. قم بتحميل أو استنساخ هذا المستودع:
   git clone https://github.com/your-username/your-repo-name.git

2. ضع ملف التقرير الخاص بك (مثل .pdf أو .docx) داخل نفس المجلد.

3. تأكد من وجود `7za.exe` بجانب `compressor.bat`.
   - إذا لم يكن موجودًا، سيقوم السكربت بتنزيله تلقائيًا.

4. شغّل السكربت:
   - انقر مزدوجًا على `compressor.bat` أو نفّذه من الطرفية:
     compressor.bat

5. اتبع التعليمات:
   - سيتم توليد كلمة مرور.
   - اختر الملف المطلوب عند الطلب.
   - سيتم إنشاء ملف مضغوط محمي بكلمة مرور، وملف نهائي للتسليم.

6. انسخ كلمة المرور من الملف `Submission_Password_Info.txt` والصقها في وصف تسليمك.


## 🧭 خطوات العمل

1. شغل ملف `compressor.bat`.
2. اختر أي ملف عند الطلب (الافتراضي: جميع الملفات).
3. يقوم السكربت بـ:
   - إنشاء كلمة مرور عشوائية وآمنة.
   - ضغط الملف المحدد في ملف ZIP محمي بكلمة مرور باسم:  
     `Defending and Securing Systems Project.zip`
   - وضع هذا الملف داخل ملف ZIP آخر بدون كلمة مرور باسم:  
     `Final_Project_Submission.zip`

4. سيتم فتح ملف باسم `Submission_Password_Info.txt` تلقائيًا في المفكرة.  
   هذا الملف يحتوي على كلمة المرور — **قم بلصقها في وصف التسليم.**

---

## 📁 مثال على البنية الناتجة
```
📁 مجلدك/
├── compressor.bat
├── 7za.exe
├── Final_Project_Submission.zip
├── Submission_Password_Info.txt
└── Project_Folder/
└── Defending and Securing Systems Project.zip
```
---

## 📦 المتطلبات

- نظام Windows مع PowerShell مفعل
- اتصال بالإنترنت (فقط لتحميل `7za.exe` تلقائيًا إذا لم يكن موجودًا)

---

## 📃 الرخصة

رخصة MIT — مجانية للاستخدام والتعديل.

---
