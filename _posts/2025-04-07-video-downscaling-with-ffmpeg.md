---
layout: post
title: FFmpeg on windows
date: 2025-04-07 17:34 -0400
description: Downscale video size with FFmpeg
categories: [Documentation, Tool]
tags: [documentation, tool]
---

<!-- markdownlint-disable MD031 -->
FFmpeg is a CLI downscaling tool mostly used with linux. it is also compatible with Windows

## Install FFmpeg on Windows

This documentation is based on information here [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html)

1. Open PowerShell
1. Launch this commande

    ```powershell
    winget install ffmpeg
    ```
    {: .nolineno }

1. Test installation

    ```powershell
    ffmpeg -version
    ```
    {: .nolineno }

    > FFmpeg should be shown
    {: .prompt-info }

## Downscaling video files

I was using ffmpeg to reduce video file size to add video to a static website where video are saved in GitHub. the Max file size is 100MiB
Tested with `.mkv` and `.mp4` formats

Here is the command I used to downscale from 1440p to 1080p.

```powershell
ffmpeg -i input.mp4 -vf scale=1920:1080 -c:v libx264 -crf 23 -preset medium -c:a copy output_1080p.mp4
```
{: .nolineno }

- `-crf` To lower the quality (and shrink file size), Increase the -crf value.
    - `-crf 23` = default (medium quality)
    - `-crf 28` = lower quality (smaller file)
    - `-crf 30` = even lower quality (more compression)

- `-preset` controls how much time the encoder spends optimizing the video. It does not affect quality directly. It affects File size, Encoding speed and CPU usage.

    | Preset | Encoding Speed | File Size | Quality |
    |--------|----------------|-----------|---------|
    ultrafast|Fastest|Biggest|Lower compression
    superfast|||
    veryfast|||		
    faster|||	
    fast|||		
    medium (default)|Balanced|Good|Good
    slow|Slower|Smaller|Same|quality, smaller file
    slower|||
    veryslow|Very slow|Smallest|Best|compression
