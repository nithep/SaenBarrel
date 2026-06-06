---
date: <% tp.date.now("YYYY-MM-DD") %>
time: <% tp.date.now("HH:mm") %>
tags: [capture, raw]
source: # inbox, meeting, idea, web, conversation
---

# 📥 Capture: <% tp.date.now("HH:mm") %> — <% tp.file.cursor(1) %>

## เนื้อหา
<% tp.file.cursor(2) %}

## 🔗 ลิงก์ที่เกี่ยวข้อง (ถ้ามี)
- 

## 🏷️ แท็กเพิ่มเติม
#<% tp.file.cursor(3) %>

---
*จะย้ายไป 01_Wiki หรือทำเป็น Project/Task เมื่อมีเวลา*