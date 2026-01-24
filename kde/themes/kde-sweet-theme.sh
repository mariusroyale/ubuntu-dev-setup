#!/bin/bash
#
# KDE Sweet Theme Installer
# -------------------------
# Installs the Sweet theme by EliverLara - a dark theme with purple neon vibes.
# Properly configures Plasma, Kvantum, and GTK for consistent theming.
#
# Usage:
#   ./kde-sweet-theme.sh
#

set -e

echo "Installing Sweet theme for KDE..."

# Install Sweet GTK theme
if [[ ! -d ~/Sweet-gtk ]]; then
    echo "Cloning Sweet GTK theme..."
    git clone https://github.com/EliverLara/Sweet.git ~/Sweet-gtk
fi
mkdir -p ~/.themes
cp -r ~/Sweet-gtk ~/.themes/Sweet
echo "GTK theme installed"

# Install Sweet KDE Plasma style
if [[ ! -d ~/Sweet-kde ]]; then
    echo "Cloning Sweet KDE theme..."
    git clone https://github.com/EliverLara/Sweet-kde.git ~/Sweet-kde
fi
mkdir -p ~/.local/share/plasma/desktoptheme
cp -r ~/Sweet-kde ~/.local/share/plasma/desktoptheme/Sweet
echo "Plasma style installed"

# Install Sweet color scheme
mkdir -p ~/.local/share/color-schemes
cp ~/Sweet-kde/colors ~/.local/share/color-schemes/Sweet.colors
echo "Color scheme installed"

# Create Sweet Kvantum theme
mkdir -p ~/.config/Kvantum/Sweet
cat > ~/.config/Kvantum/Sweet/Sweet.kvconfig << 'KVEOF'
[%General]
author=EliverLara (adapted)
comment=Sweet theme with purple neon vibes
x11drag=all
alt_mnemonic=true
left_tabs=false
attach_active_tab=false
group_toolbar_buttons=false
spread_progressbar=true
composite=true
menu_shadow_depth=7
spread_menuitems=true
tooltip_shadow_depth=6
scroll_width=12
scroll_arrows=false
slider_width=6
slider_handle_width=22
check_size=16
progressbar_thickness=6
menubar_mouse_tracking=true
translucent_windows=true
blurring=true
popup_blurring=true
combo_as_lineedit=true
combo_menu=true
inline_spin_indicators=true
layout_spacing=3
layout_margin=4
transient_scrollbar=true
tree_branch_line=true
animate_states=true
contrast=1.00
intensity=1.00
saturation=1.00

[GeneralColors]
window.color=#161925
base.color=#181b28
alt.base.color=#474747
button.color=#181b28
light.color=#5c5c5c
mid.light.color=#3f3f3f
dark.color=#111111
mid.color=#262626
highlight.color=#8500f7
inactive.highlight.color=#5c3d7a
text.color=#ffffff
window.text.color=#ffffff
button.text.color=#ffffff
disabled.text.color=#888888
tooltip.text.color=#ffffff
highlight.text.color=#ffffff
link.color=#8500f7
link.visited.color=#9b59b6
KVEOF
touch ~/.config/Kvantum/Sweet/Sweet.svg
echo "Kvantum theme created"

# Apply the theme
plasma-apply-colorscheme Sweet

# Configure Kvantum
printf "[General]\ntheme=Sweet\n" > ~/.config/Kvantum/kvantum.kvconfig
echo "Kvantum configured"

# Configure GTK
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

if [[ -f ~/.config/gtk-3.0/settings.ini ]]; then
    sed -i 's/gtk-theme-name=.*/gtk-theme-name=Sweet/' ~/.config/gtk-3.0/settings.ini
else
    printf "[Settings]\ngtk-theme-name=Sweet\ngtk-application-prefer-dark-theme=true\n" > ~/.config/gtk-3.0/settings.ini
fi

if [[ -f ~/.config/gtk-4.0/settings.ini ]]; then
    sed -i 's/gtk-theme-name=.*/gtk-theme-name=Sweet/' ~/.config/gtk-4.0/settings.ini
else
    printf "[Settings]\ngtk-theme-name=Sweet\ngtk-application-prefer-dark-theme=true\n" > ~/.config/gtk-4.0/settings.ini
fi

echo ""
echo "Sweet theme installed and applied!"
echo ""
echo "Restart apps like Dolphin to see the changes."
echo "You may also want to set the Plasma Style to Sweet in System Settings."
