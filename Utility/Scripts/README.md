# Vault Automation

ชุดสคริปต์นี้ช่วยให้ Vault Manager หรือ Hermes Agent คอมไพล์ข้อมูลจาก `00_Raw` ไปยัง `01_Wiki` ได้ซ้ำอย่างปลอดภัย

## คำสั่งหลัก

```powershell
powershell -ExecutionPolicy Bypass -File "D:\SaenBarrel\Utility\Scripts\compile-wiki.ps1" -VaultPath "D:\SaenBarrel"
```

## สิ่งที่สคริปต์ทำ
- สร้างโฟลเดอร์ `00_Raw`, `01_Wiki/Concepts`, `01_Wiki/MOCs` ถ้ายังไม่มี
- อ่านไฟล์ Markdown ใน `00_Raw`
- ข้ามไฟล์ Raw ที่มีบทความใน `01_Wiki/Concepts` อ้าง `source:` อยู่แล้ว
- สร้างบทความ draft เฉพาะ Raw ที่ยังไม่เคยคอมไพล์
- อัปเดต `01_Wiki/MOCs/Auto Index.md`

## ตัวอย่างตั้ง Windows Task Scheduler

ใช้คำสั่งนี้เมื่อพร้อมให้ระบบรันอัตโนมัติทุกวันเวลา 09:00:

```powershell
schtasks /Create /TN "SaenBarrel Compile Wiki" /SC DAILY /ST 09:00 /TR "powershell -ExecutionPolicy Bypass -File D:\SaenBarrel\Utility\Scripts\compile-wiki.ps1 -VaultPath D:\SaenBarrel"
```

## ข้อควรระวัง
- สคริปต์ไม่ได้ลบ Raw
- สคริปต์ไม่เขียนทับบทความ concept ที่มีอยู่
- บทความที่สร้างอัตโนมัติยังเป็น `status: draft` และควรให้คนหรือ LLM กลั่นต่อ
