---
title: "LLM Wiki — ระบบสังเคราะห์ความรู้อัตโนมัติ"
created: 2026-06-07
updated: 2026-06-07
type: concept
status: published
tags: [llm-wiki, karpathy, ai-native, knowledge-base, compilation, rag]
source: "00_Raw/LLM Wiki.md"
related: [[Kipano]], [[Vault Manager]], [[แนวทางปฏิบัติ LLM Wiki]]
---

# LLM Wiki — ระบบสังเคราะห์ความรู้อัตโนมัติ

> แนวคิดจาก Andrej Karpathy (เมษายน 2026) + The Bitter Lesson ของ Rich Sutton — เปลี่ยนจาก "ค้นหา" เป็น "คอมไพล์"

## แนวคิดหลัก: Stop Retrieving, Start Compiling

### The Bitter Lesson
มนุษย์ล้มเลิกการทำ Wiki เพราะการตามอัปเดตลิงก์ เชื่อมโยงเนื้อหา และทำสรุป (Bookkeeping) น่าเบื่อและสร้างภาระทางความคิดสูง แต่ **LLM ไม่เคยเบื่อและไม่เคยลืม**

### เปลี่ยนจาก RAG เป็น Compilation
- **RAG (เดิม):** AI วิ่งไปอ่านเอกสารดิบใหม่ทุกครั้งที่ถาม
- **Compilation (ใหม่):** AI ทำหน้าที่เป็น "ผู้ดูแลคลังความรู้" ประมวลผลข้อมูลดิบทั้งหมดล่วงหน้า → เรียบเรียงเป็น Markdown Wiki ที่เชื่อมโยงกัน → Obsidian เป็น Viewer เท่านั้น

## สถาปัตยกรรม 2 เลเยอร์

```
D:/SaenBarrel/
├── 00_Raw/          ← ฝั่งมนุษย์ (Kipano Style: Lazy & Chaotic)
│   ├── ไอเดียโครงการ.md
│   ├── clippings/   (บทความจากเว็บ, เอกสารดิบ)
│   └── voice_notes/ (บันทึกเสียงถอดความ)
│
├── 01_Wiki/         ← ฝั่ง AI (Karpathy Style: LLM Compiled)
│   ├── Concepts/    (บันทึกหลักที่กลั่นกรองแล้ว)
│   └── MOCs/        (แผนที่เนื้อหาอัตโนมัติ)
│
└── Utility/
    ├── Templates/
    └── Scripts/
```

### 00_Raw/ — Input Layer
พื้นที่ของมนุษย์ โยนทุกอย่างลงมาอย่างอิสระ ไม่ต้องคิดเรื่องโฟลเดอร์ย่อยหรือรูปแบบ

### 01_Wiki/ — Compiled Layer
พื้นที่ของ Vault Manager + Hermes Agent อ่านจาก 00_Raw/ → คอมไพล์ → สร้าง Concept Articles + wikilink + MOC

## วงจรการคอมไพล์ (Compilation Loop)

1. สแกน 00_Raw/ → หาไฟล์ใหม่/ที่ยังไม่คอมไพล์
2. อ่านและสกัด → สรุปประเด็นหลัก แยกแนวคิด
3. สร้าง/อัปเดต Wiki → เขียนเป็นบทความใน 01_Wiki/Concepts/
4. เชื่อมโยง → เพิ่ม wikilink `[[...]]` ในคำสำคัญครั้งแรก
5. อัปเดต MOC → เพิ่มลิงก์ใน Map of Content
6. เก็บต้นฉบับ → ไม่ลบไฟล์ใน 00_Raw/

## การเชื่อมโยงกับ Vault Manager

Vault Manager (VM 3.0) ทำหน้าที่ **"ผู้คุมระบบการคอมไพล์ความรู้ (Knowledge Compiler Agent)"**:

- **Automated Bookkeeping:** สแกน 00_Raw/ → อัปเดต 01_Wiki/ + Cross-references + Backlinks
- **Conflict Resolution:** เมื่อข้อมูลใหม่ขัดแย้งกับเก่า → แก้ไข Wiki ให้สอดคล้องทันที
- **Architecture Guard:** คุมกฎโฟลเดอร์ 2 เลเยอร์ ห้ามสร้างโฟลเดอร์ย่อยเกิน 2 ชั้น

## ข้อสรุป

> ยิ่งสะสมข้อมูลดิบ (Raw) มากเท่าไหร่ คลังวิกิ (Wiki) ก็จะยิ่งฉลาดและเชื่อมโยงกันอย่างทรงพลังมากขึ้น โดยที่มนุษย์ไม่ต้องเหนื่อยจัดระเบียบเอง
