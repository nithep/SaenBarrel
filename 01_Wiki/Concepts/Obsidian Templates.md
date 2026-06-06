---
title: "Obsidian Templates — เทมเพลตสำหรับ SaenBarrel"
created: 2026-06-07
updated: 2026-06-07
type: concept
status: published
tags: [obsidian, templates, templater, dataview, workflow]
source: "00_Raw/Templates.md"
related: [[Vault Manager]], [[Kipano]], [[LLM Wiki]]
---

# Obsidian Templates

> 5 เทมเพลตสำหรับ SaenBarrel vault — สร้างด้วย Templater + Dataview

## เทมเพลตทั้ง 5

| เทมเพลต | ใช้สำหรับ | ฟีเจอร์หลัก |
|---------|----------|------------|
| **daily-note.md** | โน้ตรายวัน | Dataview: Tasks เปิด/เสร็จวันนี้, โน้ตที่แก้ไขวันนี้, Ideas จาก 00_Raw |
| **project.md** | โครงการ | Frontmatter สำหรับ Dataview, ไมล์สโตน, Sub-tasks query |
| **moc.md** | Map of Content | Auto-linking: หาโน้ตใน 01_Wiki + 00_Raw ที่ลิงก์มาหน้านี้ |
| **quick-capture.md** | บันทึกเร็ว (Fleeting) | สำหรับ 00_Raw — tag #capture #raw, มี field source |
| **weekly-review.md** | สรุปสัปดาห์ | Tasks เสร็จ/ค้าง, โน้ตสัปดาห์นี้, Reflection, เป้าหมายสัปดาห์หน้า |

## การตั้งค่า (ทำครั้งเดียว)

1. **Templater:** Settings → Community Plugins → Templater → Template Folder Location → `Templates/`
2. **Hotkeys:**
   - `Ctrl+N` → Templater: Create new note from template
   - `Ctrl+T` → Templater: Insert template
3. **Dataview:** Enable "JavaScript Queries"

## การใช้งาน

| ต้องการ | กด |
|---------|-----|
| สร้าง Daily Note ใหม่ | `Ctrl+N` → เลือก daily-note |
| สร้าง Project ใหม่ | `Ctrl+N` → เลือก project |
| จดไอเดียเร็ว | `Ctrl+N` → เลือก quick-capture |
| สร้าง MOC ใหม่ | `Ctrl+N` → เลือก moc |
| ทำ Weekly Review | `Ctrl+N` → เลือก weekly-review |

## เคล็ดลับ

- Daily Note จะโชว์ Tasks ทั้งหมดที่ยังไม่เสร็จ (ยกเว้น #someday) + Tasks ที่เสร็จวันนี้อัตโนมัติ
- Project ใส่ `tags: [project]` ใน frontmatter → Dataview query ได้จาก MOC/Daily
- MOC ใช้ `file.outlinks` → ไม่ต้องเพิ่มลิงก์ด้วยมือ แค่ลิงก์ `[[MOC Name]]` ในโน้ตอื่น มันจะขึ้นมาเอง
