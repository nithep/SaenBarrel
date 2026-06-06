---
title: "การตั้งค่า Hermes Agent"
created: 2026-06-06
updated: 2026-06-06
type: concept
status: draft
tags: [hermes, agent, setup, obsidian, llm-wiki]
source: "00_Raw/บันทึกการตั้งค่า Hermes Agent.md"
related: ["[[Hermes Agent]]", "[[LLM Wiki Workflow]]", "[[Hermes Agent MOC]]"]
---

# การตั้งค่า Hermes Agent

## สรุปแก่น
การตั้งค่า Hermes Agent รอบนี้ยืนยันสถานะพื้นฐานของระบบ สร้าง Control Room และเชื่อม Hermes เข้ากับ Obsidian vault `D:/SaenBarrel` ผ่านตัวแปร `OBSIDIAN_VAULT_PATH`

## สถานะปัจจุบัน
- Hermes Agent อยู่ที่เวอร์ชัน `v0.15.1`
- โมเดลที่ใช้อยู่คือ `nvidia/nemotron-3-super-120b-a12b:free` ผ่าน OpenRouter
- ยังไม่ได้ตั้งค่า API keys เพิ่มเติม
- ยังไม่ได้ตั้งค่าแพลตฟอร์มส่งข้อความ เช่น Telegram, Discord หรือ Slack
- ตั้งค่า `OBSIDIAN_VAULT_PATH=D:/SaenBarrel/` ในไฟล์ `.env` ของ Hermes แล้ว

## Control Room
สร้างโฟลเดอร์ Control Room ที่:

```text
C:\Users\Nithep\AppData\Local\hermes\control-room
```

บทบาทของ Control Room คือเก็บเอกสารควบคุมระบบ เช่น กฎ รันบุ๊ก โครงสร้างงาน และคำอธิบายสภาพแวดล้อม โดยไม่ควรเก็บ secret ดิบไว้ในนั้น

## เหตุการณ์สำคัญ
- คำสั่ง `hermes update` ถูกบล็อก เพราะเป็นการเปลี่ยนแปลงที่ต้องได้รับการยินยอมชัดเจนก่อน
- การบล็อกนี้เป็นพฤติกรรมด้านความปลอดภัยที่ควรรักษาไว้ โดยเฉพาะคำสั่งที่อาจย้อนกลับยาก

## งานต่อไป
- เลือกว่าจะตั้งค่า Hermes ต่อในระดับใด: ตัวแทนเดียว, ตัวแทนเฉพาะทางหลายตัว, orchestrator หรือระบบอัตโนมัติเต็มรูปแบบ
- ตั้งค่าแพลตฟอร์มสื่อสารเมื่อมี use case ชัดเจน
- เติมเอกสาร Control Room ให้ครบ เช่น runbook, agent roles, environment map
- เชื่อม workflow นี้กับ `[[LLM Wiki Workflow]]` เพื่อให้บันทึกจาก Hermes ถูกคอมไพล์เข้า vault อย่างสม่ำเสมอ

## ลิงก์ที่เกี่ยวข้อง
- [[Hermes Agent]]
- [[LLM Wiki Workflow]]
- [[Hermes Agent MOC]]
