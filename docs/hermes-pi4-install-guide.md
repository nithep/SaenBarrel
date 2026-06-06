# คู่มือติดตั้ง Hermes Agent บน Raspberry Pi 4

> อ้างอิง: การตั้งค่าจริงเมื่อวันที่ 7 มิถุนายน 2026
> ผู้ดำเนินการ: Chief (nithep) ผ่าน Hermes Agent (nt)

---

## สารบันึก

1. [เตรียมเครื่อง Pi4](#1-เตรียมเครื่อง-pi4)
2. [ติดตั้ง Hermes Agent](#2-ติดตั้ง-hermes-agent)
3. [ตั้งค่า SSH Key สำหรับ GitHub](#3-ตั้งค่า-ssh-key-สำหรับ-github)
4. [ตั้งค่า Hermes Gateway เป็น systemd service](#4-ตั้งค่า-hermes-gateway-เป็น-systemd-service)
5. [ตั้งค่า SaenBarrel Repo](#5-ตั้งค่า-saenbarrel-repo)
6. [ตั้งค่า Hermes Config Sync](#6-ตั้งค่า-hermes-config-sync)
7. [อัปเดต Hermes](#7-อัปเดต-hermes)
8. [ตั้งค่าให้ Matebook เชื่อมต่อผ่าน Pi Gateway](#8-ตั้งค่าให้-matebook-เชื่อมต่อผ่าน-pi-gateway)
9. [โครงสร้างไฟล์สำคัญ](#9-โครงสร้างไฟล์สำคัญ)
10. [Troubleshooting](#10-troubleshooting)

---

## 1. เตรียมเครื่อง Pi4

### ข้อกำหนดเบื้องต้น

```
- Raspberry Pi 4 (4GB+ แนะนำ)
- OS: Raspberry Pi OS (Debian aarch64)
- RAM: ขั้นต่ำ 2GB
- Storage: ขั้นต่ำ 16GB
- Network: WiFi หรือ Ethernet
```

### ตั้งค่าเบื้องต้น

```bash
# อัปเดตระบบ
sudo apt update && sudo apt upgrade -y

# ติดตั้ง dependencies ที่จำเป็น
sudo apt install -y git curl build-essential python3 python3-pip python3-venv

# ตรวจสอบ Python version (ต้อง >= 3.11)
python3 --version
```

---

## 2. ติดตั้ง Hermes Agent

### วิธีที่ 1: ผ่าน uv (แนะนำ)

```bash
# ติดตั้ง uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.cargo/env

# ติดตั้ง hermes-agent
uv tool install hermes-agent
```

### วิธีที่ 2: ผ่าน git clone

```bash
# Clone repo
git clone https://github.com/NousResearch/hermes-agent.git $HOME/.hermes/hermes-agent

# สร้าง virtual environment
cd $HOME/.hermes/hermes-agent
python3 -m venv venv
source venv/bin/activate

# ติดตั้ง
pip install -e .
```

### ตรวจสอบการติดตั้ง

```bash
hermes --version
# คาดหมาย: Hermes Agent v0.16.x (2026.x.x)
```

---

## 3. ตั้งค่า SSH Key สำหรับ GitHub

### สร้าง SSH Key

```bash
# สร้าง ed25519 key
ssh-keygen -t ed25519 -C "pi@saenbarrel" -f ~/.ssh/id_ed25519 -N ""

# ดู public key
cat ~/.ssh/id_ed25519.pub
```

### เพิ่ม SSH Key ใน GitHub

1. เปิด https://github.com/settings/ssh/new
2. Title: `Raspberry Pi SaenBarrel`
3. Key type: Authentication Key
4. วาง public key → Add SSH key

### ทดสอบ

```bash
ssh -T git@github.com
# คาดหมาย: Hi username! You've successfully authenticated...
```

---

## 4. ตั้งค่า Hermes Gateway เป็น systemd service

### สร้าง service file

```bash
mkdir -p $HOME/.config/systemd/user

cat > $HOME/.config/systemd/user/hermes-gateway.service << 'EOF'
[Unit]
Description=Hermes Agent Gateway - Messaging Platform Integration
After=network.target

[Service]
Type=simple
ExecStart=/home/admin/.hermes/hermes-agent/venv/bin/python -m hermes_cli.main gateway run --replace
Restart=always
RestartSec=10
WorkingDirectory=/home/admin/.hermes

[Install]
WantedBy=default.target
EOF
```

### เปิดใช้งาน service

```bash
# Reload systemd
systemctl --user daemon-reload

# เปิดใช้งาน (start + enable on boot)
systemctl --user enable --now hermes-gateway

# ตรวจสอบสถานะ
systemctl --user status hermes-gateway
```

### คำสั่งจัดการ Gateway

```bash
# ดูสถานะ
systemctl --user status hermes-gateway

# Restart
systemctl --user restart hermes-gateway

# ดู logs
journalctl --user -u hermes-gateway -f

# Stop
systemctl --user stop hermes-gateway
```

---

## 5. ตั้งค่า SaenBarrel Repo

### Clone repo

```bash
cd $HOME
git clone git@github.com:nithep/SaenBarrel.git
```

### ตั้งค่า git identity

```bash
git config --global user.email "admin@saenbarrel"
git config --global user.name "SaenBarrel Pi"
```

### Sync จาก Matebook

เมื่อมีการเปลี่ยนแปลงจาก Matebook:

```bash
cd $HOME/SaenBarrel
git pull origin master
```

---

## 6. ตั้งค่า Hermes Config Sync

### Symlink config จาก repo

```bash
# Backup config เดิม
cp $HOME/.hermes/config.yaml $HOME/.hermes/config.yaml.bak

# Symlink ไปที่ repo
ln -sf $HOME/SaenBarrel/config/hermes-pi-config.yaml $HOME/.hermes/config.yaml

# ตรวจสอบ
ls -la $HOME/.hermes/config.yaml
# คาดหมาย: lrwxrwxrwx ... config.yaml -> /home/admin/SaenBarrel/config/hermes-pi-config.yaml
```

### สคริปต์ sync config

```bash
# รัน sync script จาก repo
bash $HOME/SaenBarrel/Utility/Scripts/sync-hermes-config.sh
```

---

## 7. อัปเดต Hermes

### ตรวจสอบ version ปัจจุบัน

```bash
hermes --version
```

### อัปเดต (วิธี git)

```bash
cd $HOME/.hermes/hermes-agent
git pull origin main

# Restart gateway หลังอัปเดต
systemctl --user restart hermes-gateway
```

### อัปเดต (วิธี uv)

```bash
uv tool upgrade hermes-agent
systemctl --user restart hermes-gateway
```

---

## 8. ตั้งค่าให้ Matebook เชื่อมต่อผ่าน Pi Gateway

### บน Matebook (Windows)

#### สร้าง hermes-pi wrapper

```bash
# สร้างไฟล์ wrapper
cat > $HOME/.local/bin/hermes-pi << 'EOF'
#!/bin/bash
PI_HOST="admin@192.168.1.109"
PI_HERMES="/home/admin/.hermes/hermes-agent/venv/bin/hermes"
ssh "$PI_HOST" "$PI_HERMES" "$@"
EOF

chmod +x $HOME/.local/bin/hermes-pi
```

#### ทดสอบ

```bash
hermes-pi --version
hermes-pi status
```

### SSH Config (Matebook)

```
# ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/saenbarrel_rsa
  IdentitiesOnly yes
```

---

## 9. โครงสร้างไฟล์สำคัญ

```
/home/admin/
├── .hermes/
│   ├── config.yaml              ← symlink → SaenBarrel/config/hermes-pi-config.yaml
│   ├── config.yaml.bak          ← backup เดิม
│   ├── .env                     ← API keys
│   ├── hermes-agent/            ← Hermes source code
│   │   ├── venv/                ← Python virtual environment
│   │   └── ...
│   ├── state.db                 ← sessions + memory (7.3MB)
│   ├── memories/                ← user memory
│   ├── sessions/                ← session snapshots
│   ├── skills/                  ← Hermes skills
│   ├── logs/                    ← gateway logs
│   └── ...
├── SaenBarrel/                  ← git repo (sync กับ Matebook)
│   ├── 00_Raw/
│   ├── 01_Wiki/
│   ├── Templates/
│   ├── Utility/Scripts/
│   │   ├── sync-hermes.sh
│   │   └── sync-hermes-config.sh
│   ├── config/
│   │   └── hermes-pi-config.yaml  ← Hermes config master
│   └── docs/
│       ├── architecture.html
│       └── blueprint.txt
└── .ssh/
    ├── id_ed25519               ← Pi SSH key
    └── id_ed25519.pub
```

---

## 10. Troubleshooting

### Gateway ไม่ start

```bash
# ดู error logs
journalctl --user -u hermes-gateway --no-pager -n 50

# ตรวจสอบว่า port ไม่ถูกใช้
ss -tlnp | grep hermes

# Restart
systemctl --user restart hermes-gateway
```

### SSH เชื่อมต่อไม่ได้

```bash
# ทดสอบ verbose
ssh -vT git@github.com

# ตรวจสอบ key
ssh-add -l

# ลบ known_hosts ถ้ามีปัญหา
ssh-keygen -R github.com
```

### Hermes ไม่อัปเดต

```bash
# ลบ cache แล้วลองใหม
cd $HOME/.hermes/hermes-agent
git fetch origin
git reset --hard origin/main
systemctl --user restart hermes-gateway
```

### Config sync ไม่ทำงาน

```bash
# ตรวจสอบ symlink
ls -la $HOME/.hermes/config.yaml

# ถ้า symlink เสีย
ln -sf $HOME/SaenBarrel/config/hermes-pi-config.yaml $HOME/.hermes/config.yaml

# Restart gateway
systemctl --user restart hermes-gateway
```

---

## สรุป Architecture

```
Matebook (Windows)          Raspberry Pi 4
┌─────────────────┐         ┌──────────────────────┐
│ hermes-pi       │──SSH──▶│ Hermes Gateway       │
│ (wrapper)       │         │ v0.16.0              │
│                 │         │ Telegram bot         │
│ Obsidian vault  │──git──▶│ SaenBarrel repo      │
│ D:/SaenBarrel/  │◀─pull──│ /home/admin/SaenBarrel│
└─────────────────┘         └──────────────────────┘
        │                            │
        └────── GitHub ──────────────┘
         git@github.com:nithep/SaenBarrel
```

---

*สร้างเมื่อ: 2026-06-07*
*โดย: Hermes Agent (nt) สำหรับ Chief (nithep)*
*อ้างอิง: บทสนทนาการตั้งค่าจริง*
