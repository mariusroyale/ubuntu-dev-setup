#!/bin/bash
#
# KDE WhiteSur Theme Fix
# ----------------------
# Fixes the issue where KDE global themes don't properly switch between light/dark
# because Kvantum (the widget style engine) overrides Plasma color schemes.
#
# Problem: When using Kvantum as widget style, it ignores Plasma's color scheme
# and uses its own theme. If Kvantum has no config or uses a dark theme,
# apps like Dolphin stay dark even when you select a light global theme.
#
# Solution: This script installs WhiteSur themes and properly configures Kvantum
# to use the matching light/dark variant.
#
# Usage:
#   ./kde-whitesur-theme.sh light   # Apply light theme
#   ./kde-whitesur-theme.sh dark    # Apply dark theme
#

set -e

VARIANT="${1:-light}"

if [[ "$VARIANT" != "light" && "$VARIANT" != "dark" ]]; then
    echo "Usage: $0 [light|dark]"
    exit 1
fi

echo "Installing WhiteSur $VARIANT theme for KDE..."

# Install WhiteSur GTK theme (for GTK apps in KDE)
if [[ ! -d ~/WhiteSur-gtk-theme ]]; then
    echo "Cloning WhiteSur GTK theme..."
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ~/WhiteSur-gtk-theme
fi

if [[ "$VARIANT" == "light" ]]; then
    ~/WhiteSur-gtk-theme/install.sh -c Light
else
    ~/WhiteSur-gtk-theme/install.sh -c Dark
fi

# Install WhiteSur KDE theme (for Qt/Plasma apps)
if [[ ! -d ~/WhiteSur-kde ]]; then
    echo "Cloning WhiteSur KDE theme..."
    git clone https://github.com/vinceliuice/WhiteSur-kde.git ~/WhiteSur-kde
fi

~/WhiteSur-kde/install.sh -c "$VARIANT"

# Apply the global theme
if [[ "$VARIANT" == "light" ]]; then
    plasma-apply-lookandfeel -a com.github.vinceliuice.WhiteSur
    plasma-apply-colorscheme WhiteSur
    KVANTUM_THEME="WhiteSur"
    GTK_THEME="WhiteSur-Light"
else
    plasma-apply-lookandfeel -a com.github.vinceliuice.WhiteSur-dark
    plasma-apply-colorscheme WhiteSurDark
    KVANTUM_THEME="WhiteSurDark"
    GTK_THEME="WhiteSur-Dark"
fi

# CRITICAL: Configure Kvantum to use the correct theme variant
# This is the key fix - without this, Kvantum ignores Plasma color schemes
mkdir -p ~/.config/Kvantum
printf "[General]\ntheme=%s\n" "$KVANTUM_THEME" > ~/.config/Kvantum/kvantum.kvconfig
echo "Configured Kvantum to use: $KVANTUM_THEME"

# Configure GTK3 and GTK4 for GTK apps
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

if [[ -f ~/.config/gtk-3.0/settings.ini ]]; then
    sed -i "s/gtk-theme-name=.*/gtk-theme-name=$GTK_THEME/" ~/.config/gtk-3.0/settings.ini
else
    printf "[Settings]\ngtk-theme-name=%s\n" "$GTK_THEME" > ~/.config/gtk-3.0/settings.ini
fi

if [[ -f ~/.config/gtk-4.0/settings.ini ]]; then
    sed -i "s/gtk-theme-name=.*/gtk-theme-name=$GTK_THEME/" ~/.config/gtk-4.0/settings.ini
else
    printf "[Settings]\ngtk-theme-name=%s\n" "$GTK_THEME" > ~/.config/gtk-4.0/settings.ini
fi

echo ""
echo "WhiteSur $VARIANT theme applied!"
echo ""
echo "If apps like Dolphin don't update, restart them or log out and back in."
