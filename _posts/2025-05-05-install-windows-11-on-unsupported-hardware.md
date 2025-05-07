---
layout: post
title: Install Windows 11 on unsupported hardware
date: 2025-05-05 22:12 -0400
description: Windows 11 installation on unsupported hardware
categories: [Documentation, Windows]
tags: [documentation, windows, local]
---

This is a small guide to install Windows 11 on unsupported hardware. Windows 11 Enterprise IoT is the only non-LTSC version compatible with old hardware. You have all of the windows 11 functionalities and feature update like all other versions of Windows 11.

This documentation is based on the information here : [Gravesoft - Windows 11 on Unsupported Hardware](https://gravesoft.dev/clean_install_windows#windows-11-on-unsupported-hardware)


| **Feature**                                | **Windows 11 Home / Pro**                                       | **Windows 11 IoT Enterprise (GAC)**                         |
| ------------------------------------------ | --------------------------------------------------------------- | ----------------------------------------------------------- |
| **Processor**                              | 1 GHz, 2 cores, 64 bits,<br>compatible with TPM 2.0 and <br>Secure Boot | 1 GHz, 2 cores, 64 bit <br>more flexible depending on the OEM |
| **RAM**                                    | Minimum 4 GB                                                    | Minimum 2 GB<br>(depending on IoT edition)                     |
| **Storage**                                | Minimum 64 GB                                                   | Minimum 16 to 32 GB<br>(depending on OEM configuration)        |
| **UEFI + Secure Boot required**            | ✅ Yes                                                           | ❌ Not mandatory (optional)                                  |
| **TPM 2.0 required**                       | ✅ Yes                                                           | ❌ Often not required                                        |
| **Internet connection <br>required for setup** | ✅ Yes (mandatory for Home Edition)                              | ❌ Not required                                              |
| **Microsoft account required**             | ✅ Yes (Home only)                                               | ❌ Not required                                              |
| **Long-term support (LTSC)**               | ❌ No                                                            | ✅ Yes (up to 10 years)                                      |
| **Intended use**                           | Home / office / enterprise use                                  | Embedded devices,<br>industrial systems, kiosks, POS, etc.     |

1. Download the Windows 11 ISO in the language of your choice. [Windows 11 download](https://www.microsoft.com/en-ca/software-download/windows11)
1. Download and launch Rufus to create a bootable USB (8 Gb minimum). [Rufus download](https://rufus.ie/en/#download)
1. Once in Rufus, select your USB key, and the Windows 11 ISO file downloaded.
1. Select GPT if your computer uses UEFI and Secure Boot, MBR if that is not the case and it uses legacy BIOS (check with your motherboard)

    | **Generation**                         | **UEFI Support**                | **Secure Boot Support**               | **TPM Support**                     | **Windows 11 Support**                                                  |
    |----------------------------------------|----------------------------------|----------------------------------------|-------------------------------------|------------------------------------------------------------------------|
    | **Intel 1st Gen (Nehalem, Westmere)**  | ❌ Rare (legacy BIOS)            | ❌                                      | ❌ (usually none)                   | ❌ Not supported                                                       |
    | **Intel 2nd Gen (Sandy Bridge)**       | ✅ (UEFI common)                 | ❌ / ⚠️ (varies by motherboard)         | ⚠️ (optional or add-on TPM)         | ❌ Not officially supported                                            |
    | **Intel 3rd Gen (Ivy Bridge)**         | ✅                               | ⚠️ (via BIOS/UEFI update)              | ⚠️ (optional or add-on TPM)         | ❌ Not officially supported                                            |
    | **Intel 4th Gen (Haswell)**            | ✅                               | ✅                                      | ⚠️ (some with firmware TPM)         | ❌ Not officially supported                                            |
    | **Intel 8th Gen (Coffee Lake) and later**| ✅                               | ✅                                      | ✅ (firmware TPM 2.0 or discrete)   | ✅ Fully supported (oldest supported Intel: **Core i7-8700**)          |
    |__-__|__-__|__-__|__-__|__-__|
    | **AMD before 2011 (AM2/AM3)**          | ❌                               | ❌                                      | ❌                                  | ❌ Not supported                                                       |
    | **AMD AM3+ / FM2 (2011+)**             | ✅ (some UEFI motherboards)      | ⚠️                                      | ⚠️ (varies, often no TPM)           | ❌ Not officially supported                                            |
    | **AMD Ryzen 1st Gen (2017)**           | ✅                               | ✅                                      | ⚠️ (fTPM 2.0 usually present,<br>but not always supported) | ⚠️ Some models unofficially<br> supported (e.g., 1600 AF)              |
    | **AMD Ryzen 2nd Gen and later (2018+)**| ✅                               | ✅                                      | ✅ (fTPM 2.0 included)              | ✅ Fully supported (oldest supported: **Ryzen 2500U / 2600**)         |

1. Config the USB key name (optional)
1. Select **Start**
1. Select the options below from the displayed menu and press **OK**.

    - ✅ Remove requirement for 4GB+ RAM, Secure Boot and TPM 2.0
    - ✅ Remove requirement for an online Microsoft account
    - ⬜ Create a local account with username: `<your_user>`
    - ⬜ Set regional options to the same values as this user's
    - ✅ Disable data collection (Skip privacy questions)
    - ✅ Disable BitLocker automatic device encryption

1. Once the creation is complete, create a file named `PID.txt` in the `/sources/` folder of the install USB and add the following content:

    ```text
    [PID]
    Value=XQQYW-NFFMW-XJPBH-K8732-CKFFD
    ```
    {: .nolineno}

1. Plug in the installation USB drive, turn on the computer, and press the `F12` key repeatedly to open the boot menu (the key may vary depending on your PC model, e.g., `Esc`, `F2` , `F10`, or `Del`).
1. Select your USB drives and install Windows 11 as usual without entering a product key.
1. Stay offline to create a local account (without connecting to a Microsoft account).
1. You can follow the instructions here:  [Massgrave - Activate Windows](https://massgrave.dev/#how-to-activate-windows--office) to activate your Windows 11 IoT Enterprise installation.