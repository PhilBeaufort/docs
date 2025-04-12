---
layout: post
title: Install Windows with Local account
date: 2025-04-10 01:16 -0400
description: Ways to enable local account creation on Windows 11
categories: [Documentation, Windows]
tags: [documentation, windows, local]
---

One issue with the Windows 11 installer is that it requires you to create an account using a Microsoft account. Here are four ways to bypass this requirement.

## oobe\bypassnro _(disabled in the latest insider preview)_


1. Once in the windows installer, press Shift + F10 to open the Command Prompt.
1. Type the command `oobe\bypassnro` and press Enter. The system will reboot automatically.

After the reboot, you should be able to create a local account instead of signing in with a Microsoft account.

## Terminating **Network Connection Flow** task

1. Once in the windows installer, press Shift + F10 to open the Command Prompt.
1. Type `taskmgr` and press Enter to open the Task Manager.
1. Find and Terminate the task `Network Connection Flow`

After closing both the Task Manager and the Command Prompt, you should be able to create a local account.

## Using **Rufus** to Create a Bootable Media

1. Download the latest version of [Rufus](https://rufus.ie/en/){: target="_blank" }.
1. Insert a USB drive (at least 8GB recommended).
1. Open Rufus and select your USB drive under Device.
1. Under Boot selection, click SELECT and choose the Windows 11 ISO file.
1. Select the `GPT` partition scheme (UEFI Only)
1. Click START and a popup will appear.
1. Select the option to **remove requirement for an online Microsoft account** and others if need.
![rufus options](/assets/img/rufus.png){: w="400" style="border-radius: 10px;" .shadow .normal}
1. Press `OK` and wait for the process to complete

When installing Windows with this boot media, local account creation will be possible.

## Edit Windows 11 ISO with NTLite

With NTLite it is possible to enable/disable setting, features and create a custom ISO.

- Download & Install [NTLite](https://www.ntlite.com/download/).
- We can use the **Free (limited, non-commercial)** license option for personnal use.

> Click on images to zoom in
{: .prompt-tip}

Step|Image|Description
-|-|-
1|![NTLITE add](/assets/img/windows/ntlite-add.png){: w="250" style="border-radius: 10px;" .shadow}|After launching NTLite, **Add** the ISO to edit.
2|![NTLITE new edit](/assets/img/windows/ntlite-new-edit.png){: w="250" style="border-radius: 10px;" .shadow}|Right Click on the read-only ISO that was imported and select **New edit**.
3|![NTLITE load](/assets/img/windows/ntlite-load.png){: w="250" style="border-radius: 10px;" .shadow}| Right Click on the Windows Version you want to edit and select **Load**
4|![NTLITE settings system](/assets/img/windows/ntlite-system.png){: w="250" style="border-radius: 10px;" .shadow}| Once the loading is complete, new menus will appear on the left.<br>To edit installation requirements, go to Settings > System.
5|![NTLITE settings privacy](/assets/img/windows/ntlite-privacy.png){: w="250" style="border-radius: 10px;" .shadow}| You can also edit privacy settings in this section.
6|![NTLITE features](/assets/img/windows/ntlite-features.png){: w="250" style="border-radius: 10px;" .shadow}| The Features menu allows you to enable or disable specific Windows features before installation.
-|-|Feel free to explore the other settings and options available.<br>Once you're ready, proceed to the 'Apply' section.
7|![NTLITE apply delete](/assets/img/windows/apply-delete.png){: w="250" style="border-radius: 10px;" .shadow}| One feature of the 'Apply' option is the ability to remove selected Windows versions from the ISO.
8|![boot partitions](/assets/img/windows/boot.png){: w="250" style="border-radius: 10px;" .shadow}|My suggestion is to delete most. However do not remove **boot.win** partitions.<br>It is possible to apply the selected changes to other Windows versions that are not deleted.<br>However, be cautious (see the warning at the end of this table).
9|![NTLITE apply delete](/assets/img/windows/apply-reapply.png){: w="250" style="border-radius: 10px;" .shadow}| In the section after image format,<br>you can reapply the changes made earlier to the partitions that were not deleted.
10|![NTLITE create iso](/assets/img/windows/apply-create-iso.png){: w="250" style="border-radius: 10px;" .shadow}| Select 'Create ISO' in the options to generate a new ISO file after applying the changes.
11|![NTLITE apply process](/assets/img/windows/apply-process.png){: w="250" style="border-radius: 10px;" .shadow}| Double-check the overview, then press the 'Process' button to begin modifying the ISO.
12|![NTLITE license](/assets/img/windows/premium-feature.png)|Each step will need a user interaction to continue because we are using the Free license.

> All selected Windows versions will be mounted and modified individually. Selecting multiple versions will significantly increase the processing time.
{: .prompt-warning}

At the end of the process, you will have a custom ISO file that can be used for virtual machines or boot media with [Ventoy](https://www.ventoy.net/). This is great because it allows for easy deployment across different environments.