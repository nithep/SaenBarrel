 Hermes  ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

     ✅ สร้าง Template 5 ไฟล์เสร็จแล้วครับ — อยู่ที่ D:/SaenBarrel/Templates/
     📋 ไฟล์ที่สร้าง

     | Template         | ใช้สำหรับ            | ฟีเจอร์หลัก                                                           |
     |------------------|--------------------|--------------------------------------------------------------------|
     | daily-note.md    | โน้ตรายวัน           | Dataview queries: Tasks เปิด/เสร็จวันนี้, โน้ตที่แก้ไขวันนี้, Ideas จาก 00_Raw |
     | project.md       | โครงการ            | Frontmatter สำหรับ Dataview, ไมล์สโตน, Sub-tasks query อัตโนมัติ        |
     | moc.md           | Map of Content     | Auto-linking: หาโน้ตใน 01_Wiki + 00_Raw ที่ลิงก์มาหน้านี้                  |
     | quick-capture.md | บันทึกเร็ว (Fleeting) | สำหรับ 00_Raw — tag capture, raw, มี field source                    |
     | weekly-review.md | สรุปสัปดาห์           | Tasks เสร็จ/ค้าง, โน้ตสัปดาห์นี้, Reflection, เป้าหมายสัปดาห์หน้า             |
     ⚙️ ตั้งค่าใน Obsidian (ทำครั้งเดียว)

     1. Settings → Community Plugins → Templater → Template Folder Location → เลือก Templates (โฟลเดอร์ที่เพิ่งสร้าง)
     2. Hotkeys (Settings → Hotkeys):
        - Templater: Create new note from template → Ctrl+N
        - Templater: Insert template → Ctrl+T
     3. Dataview → Enable "JavaScript Queries" (ถ้าจะเขียน dv.pages() เอง)
     🚀 เริ่มใช้งานเลย

     | ต้องการ              | กด                          |
     |---------------------|-----------------------------|
     | สร้าง Daily Note ใหม่ | Ctrl+N → เลือก daily-note    |
     | สร้าง Project ใหม่    | Ctrl+N → เลือก project       |
     | จดไอเดียเร็ว          | Ctrl+N → เลือก quick-capture |
     | สร้าง MOC ใหม่        | Ctrl+N → เลือก moc           |
     | ทำ Weekly Review    | Ctrl+N → เลือก weekly-review |
     💡 เคล็ดลับ

     - Daily Note จะโชว์ Tasks ทั้งหมดที่ยังไม่เสร็จ (ยกเว้น #someday) + Tasks ที่เสร็จวันนี้ อัตโนมัติ
     - Project ใส่ tags: [project] ใน frontmatter → Dataview จะ query ได้จาก MOC/Daily
     - MOC ใช้ file.outlinks → ไม่ต้องเพิ่มลิงก์ด้วยมือ แค่ลิงก์ [[MOC Name]] ในโน้ตอื่น มันจะขึ้นมาเอง

     ต้องการปรับ Template ให้ตรง Workflow ส่วนตัวมากขึ้น (เพิ่ม/ลบ section, เปลี่ยน Dataview query) บอกมาเลยครับ — ผม patch ให้ทันที

 ────────────────────────────────────────────────────────────────────