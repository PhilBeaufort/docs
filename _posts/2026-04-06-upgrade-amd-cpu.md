---
layout: post
title: 🛠️ AMD CPU Upgrade Guide
date: 2026-04-06 13:07 -0400
description: Steps before upgrading an AM4 / AM5 CPU
categories: [PC, Windows]
tags: [pc, windows]
---

## 1. Handle BitLocker (IMPORTANT)

Changing CPU or firmware can trigger BitLocker recovery.

You have **2 options**:

---

### 🔑 Option A — Back up BitLocker recovery key (faster)

- Go to: https://account.microsoft.com/devices/recoverykey  
- Or in Windows:
  - Search **"Manage BitLocker"**
  - Click **Back up your recovery key**

> ✅ Recommended if you want a quick upgrade without waiting

---

### 🔓 Option B — Disable BitLocker (full decryption, safest)

Run in **Administrator Command Prompt / PowerShell**:

```bash
manage-bde -off C:
```
{: .nolineno }

- Starts full decryption
- Check progress:

```bash
manage-bde -status C:
```
{: .nolineno }

> Wait until: 
> `Conversion Status: Fully Decrypted`  
{: .prompt-info}

🔒 Re-enable BitLocker after upgrade (if disabled)


```bash
manage-bde -on C:
```
{: .nolineno }

> Recommended: Back up your recovery key again after re-enabling


## 2. Check BIOS Compatibility

AM5 motherboards (B650, X670, etc.) may require BIOS updates for newer CPUs.

> Check BIOS version directly in bios or with software like :
> - [HWINFO](https://www.hwinfo.com/)
> - [CPU-Z](https://www.cpuid.com/softwares/cpu-z.html)
{: .prompt-tip}

**Steps:**
1. Identify your motherboard model
2. Visit manufacturer website (ASUS, MSI, Gigabyte, ASRock)
3. Check:
   - CPU support list
   - Required BIOS version

**⚠️ Important**
- If CPU is not supported, update BIOS before installing new CPU

**BIOS Update Tips**
- Use built-in tools (EZ Flash, M-Flash, Q-Flash, etc.)
- Use a FAT32 USB drive
- Do NOT power off during update
- Use BIOS Flashback if available (no CPU required)

## 3. Upgrade CPU

**Required Tools**
- Thermal paste
- Isopropyl alcohol (90%+)
- Cloth or paper towel
- Screwdriver

**Steps**
1. Power off and unplug PSU
1. Hold power button (~10 sec) to discharge
1. Remove cooler (unscrew evenly, twist gently)
1. Clean old thermal paste (CPU + cooler)
1. Lift socket arm and remove old CPU
1. Align triangle and install new CPU (no force)
1. Apply thermal paste (pea-sized)
1. Reinstall cooler (tighten evenly)

## 4. First Boot
- Boot may take longer (memory training)
- System may restart multiple times

## 5. Post-Upgrade Checks
**In BIOS**
- Verify CPU is detected
- Check idle temps (~30–50°C typical)
**In OS**
- Confirm CPU (Task Manager / lscpu)
- Install/update AMD chipset drivers
- Re-enable EXPO/XMP if needed

## ⚠️ Common Pitfalls
- BIOS not updated → system won’t POST
- Bent motherboard socket pins (AM5 = pins on motherboard)
- Uneven cooler mounting → high temps
- Forgot BitLocker → recovery lockout