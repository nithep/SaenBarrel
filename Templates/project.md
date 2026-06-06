---
project_name: 
status: active # active, on-hold, done, dropped
priority: high # high, medium, low
start_date: <% tp.date.now("YYYY-MM-DD") %>
target_date: 
tags: [project]
area: # life-area: work, personal, health, learning, finance
related_projects: []
---

# <% tp.file.title %>

## 🎯 เป้าหมายโครงการ
> เหตุผล/Outcome ที่ต้องการให้ชัดเจน

## 📦 Scope (ใน/นอกขอบเขต)
### ✅ ในขอบเขต
- 

### ❌ นอกขอบเขต
- 

## 🗓️ ไมล์스โตน & Timeline
| ไมล์สโตน | เป้าหมายวันที่ | สถานะ |
|-----------|--------------|-------|
|  |  | ⏳ |

## ✅ Tasks ย่อย (Sub-tasks)
```dataview
TASK
WHERE contains(file.path, this.file.folder) AND !completed
GROUP BY file.link
SORT file.ctime ASC
```

## 📝 บันทึกความคืบหน้า
### <% tp.date.now("YYYY-MM-DD") %>
- 

---

## 🔗 ทรัพยากร/Reference
- [[Link ไปโน้ตเรื่อง]]

## 💭 หมายเหตุ/Blockers
- 