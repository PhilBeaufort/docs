---
layout: post
title: FFmpeg on windows
date: 2025-04-07 17:34 -0400
description: Downscale video size with FFmpg
categories: [Documentation, Tool]
tags: [documentation, tool]
---

<!-- markdownlint-disable MD031 -->
FFmpeg is a CLI downscaling tool mostly used with linux. it is also compatible with Windows

## Install FFmped on Windows

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

## Downscale video files

- From 1440p to 1080p

    ```powershell
    ffmpeg -i input.mkv -vf scale=1920:1080 -c:v libx264 -crf 23 -preset medium -c:a copy output_1080p.mkv
    ```
    {: .nolineno }
