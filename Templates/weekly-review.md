---
week: <% tp.date.now("YYYY-[W]WW") %>
start_date: <% tp.date.now("YYYY-MM-DD", -6) %>
end_date: <% tp.date.now("YYYY-MM-DD") %>
tags: [weekly-review]
---

# 📅 สรุปสัปดาห์: <% tp.date.now("YYYY-[W]WW") %> (<% tp.date.now("DD/MM", -6) %> - <% tp.date.now("DD/MM") %>)

## ✅ สิ่งที่สำเร็จในสัปดาห์นี้
```dataview
TASK
WHERE completed
AND completion >= date("<% tp.date.now("YYYY-MM-DD", -6) %>")
AND completion <= date("<% tp.date.now("YYYY-MM-DD") %>")
GROUP BY file.link
```

## ⏳ Tasks ที่ค้าง (ยังไม่เสร็จ)
```dataview
TASK
WHERE !completed
AND (file.folder = "Projects" OR contains(file.path, "Projects"))
GROUP BY file.link
SORT file.ctime ASC
```

## 📝 โน้ตที่สร้าง/แก้ไขสัปดาห์นี้
```dataview
LIST
WHERE file.ctime >= date("<% tp.date.now("YYYY-MM-DD", -6) %>") AND file.ctime <= date("<% tp.date.now("YYYY-MM-DD") %>")
OR file.mtime >= date("<% tp.date.now("YYYY-MM-DD", -6) %>") AND file.mtime <= date("<% tp.date.now("YYYY-MM-DD") %>")
AND file.path != this.file.path
SORT file.mtime DESC
```

---

## 🎯 การสะท้อน (Reflection)

### 👍 สิ่งที่ทำได้ดี
- 

### 👎 สิ่งที่ต้องปรับปรุง
- 

### 💡 ข้อเรียนรู้/Insights
- 

---

## 📊 เมตริกส่วนตัว (ถ้ามี)
| เมตริก | สัปดาห์นี้ | สัปดาห์ก่อน | Trend |
|--------|-----------|-------------|-------|
| Tasks เสร็จ |  |  |  |
| โน้ตใหม่ |  |  |  |
| ชั่วโมง Deep Work |  |  |  |

---

## 🎯 เป้าหมายสัปดาห์หน้า (Top 3)
1. 
2. 
3. 

---

## 📅 บล็อกเวลา/การนัดหมายสำคัญสัปดาห์หน้า
- 