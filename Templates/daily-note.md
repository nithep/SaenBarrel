---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
tags: [daily]
week: <% tp.date.now("WW") %>
month: <% tp.date.now("YYYY-MM") %>
---

# <% tp.date.now("dddd, Do MMMM YYYY") %>

## 🎯 วันนี้จะทำให้สำเร็จ (Top 3)
- [ ] 
- [ ] 
- [ ] 

## 📝 บันทึกรายวัน
<% tp.file.cursor() %>

---

## 🔗 ลิงก์ที่เกี่ยวข้อง
- [[<% tp.date.now("YYYY-MM-DD", -1) %> | ← เมื่อวาน]]
- [[<% tp.date.now("YYYY-MM-DD", 1) %> | พรุ่งนี้ →]]
- [[<% tp.date.now("YYYY-[W]WW") %> | สรุปสัปดาห์นี้]]
- [[<% tp.date.now("YYYY-MM") %> | สรุปเดือนนี้]]

---

## ✅ Tasks เปิดอยู่ (จากทุกโน้ต)
```dataview
TASK
WHERE !completed
AND !contains(text, "#someday")
AND (file.folder = this.file.folder OR contains(file.path, this.file.folder))
GROUP BY file.link
SORT file.ctime ASC
```

---

## 📋 Tasks ที่เสร็จวันนี้
```dataview
TASK
WHERE completed
AND completion = date("<% tp.date.now("YYYY-MM-DD") %>")
GROUP BY file.link
```

---

## 📚 โน้ตที่สร้าง/แก้ไขวันนี้
```dataview
LIST
WHERE file.ctime = date("<% tp.date.now("YYYY-MM-DD") %>") OR file.mtime = date("<% tp.date.now("YYYY-MM-DD") %>")
AND file.path != this.file.path
SORT file.mtime DESC
```

---

## 💡 แนวคิด/ไอเดียที่บันทึกวันนี้
```dataview
LIST
FROM "00_Raw"
WHERE file.ctime = date("<% tp.date.now("YYYY-MM-DD") %>")
SORT file.ctime DESC
```