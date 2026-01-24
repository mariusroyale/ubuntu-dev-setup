# KDE Theme Switching Issue with Kvantum

## The Problem

When using KDE Plasma with Kvantum as the widget style, switching global themes from dark to light does not fully work. Apps like Dolphin stay dark even after selecting a light theme.

## Root Cause

KDE Plasma uses multiple layers for theming:

1. Global Theme - Sets defaults for everything
2. Plasma Style - Panels, widgets
3. Color Scheme - Colors for Qt apps
4. Widget Style - How widgets are drawn (Breeze, Kvantum, etc.)
5. GTK Theme - For GTK apps running in KDE

The issue is that Kvantum overrides the Plasma color scheme. Kvantum has its own theme system and ignores whatever color scheme Plasma has set. If Kvantum is configured to use a dark theme or has no config, Qt apps will be dark regardless of your Plasma settings.

## The Fix

When switching themes, you must also update Kvantum config at ~/.config/Kvantum/kvantum.kvconfig

For light theme, set theme=WhiteSur
For dark theme, set theme=WhiteSurDark

## Automated Solution

Use the fix script in fix-apps/kde-whitesur-theme.sh

Run with light or dark argument to apply the full theme stack.

## Manual Steps

1. Open Kvantum Manager from app launcher
2. Select Change/Delete Theme
3. Choose WhiteSur for light or WhiteSurDark for dark
4. Click Use this theme
5. Restart apps like Dolphin

## Files Involved

- ~/.config/Kvantum/kvantum.kvconfig - Kvantum theme selection
- ~/.config/kdeglobals - KDE color scheme
- ~/.config/gtk-3.0/settings.ini - GTK3 theme
- ~/.config/gtk-4.0/settings.ini - GTK4 theme
