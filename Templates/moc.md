---
topic: 
tags: [moc]
status: growing # growing, mature, archived
created: <% tp.date.now("YYYY-MM-DD") %>
updated: <% tp.date.now("YYYY-MM-DD") %>
---

# 🗺️ MOC: <% tp.file.title %>

> **Map of Content** — จุดศูนย์กลางเชื่อมโยงโน้ตทั้งหมดเกี่ยวกับหัวข้อนี้

## 🎯 ความหมาย/นิยาม
> สรุปหัวข้อนี้ใน 1-2 ประโยค

## 📂 โครงสร้างย่อย (Sub-topics)
```dataview
LIST
FROM "01_Wiki"
WHERE contains(file.outlinks, [[<% tp.file.title %>]]) OR contains(file.tags, "#<% tp.file.title %>")
AND file.path != this.file.path
SORT file.name ASC
```

---

## 📝 โน้ตหลัก (Core Notes)
| โน้ต | สถานะ | อัปเดตล่าสุด |
|------|--------|--------------|
|  |  |  |

---

## 🔗 โน้ตที่เกี่ยวข้อง (Related Notes)
### จาก 01_Wiki (Evergreen)
```dataview
LIST
FROM "01_Wiki"
WHERE contains(file.outlinks, [[<% tp.file.title %>]])
AND file.path != this.file.path
SORT file.mtime DESC
LIMIT 20
```

### จาก 00_Raw (Raw captures)
```dataview
LIST
FROM "00_Raw"
WHERE contains(file.outlinks, [[<% tp.file.title %>]]) OR contains(lower(file.content), "<% tp.file.title %>")
SORT file.ctime DESC
LIMIT 10
```

---

## 📚 แหล่งอ้างอิง/Resources
- 

---

## ❓ คำถามที่ยังเปิดอยู่ (Open Questions)
- 

---

## 🔄 ประวัติการอัปเดต
- `<% tp.date.now("YYYY-MM-DD") %>` — สร้าง MOC นี้