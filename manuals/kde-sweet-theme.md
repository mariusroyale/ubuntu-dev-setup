# Sweet KDE Theme Installation

## About Sweet

Sweet is a dark theme with purple neon vibes by EliverLara. It features:
- Dark background (#161925)
- Purple accent color (#8500f7)
- Modern, clean look

## Quick Install

Run the install script:

    ./fix-apps/kde-sweet-theme.sh

## What Gets Installed

1. **Sweet GTK theme** - For GTK apps (Firefox, GIMP, etc.)
   - Source: https://github.com/EliverLara/Sweet
   - Location: ~/.themes/Sweet

2. **Sweet KDE Plasma style** - For panels and widgets
   - Source: https://github.com/EliverLara/Sweet-kde
   - Location: ~/.local/share/plasma/desktoptheme/Sweet

3. **Sweet color scheme** - For Qt apps (Dolphin, Kate, etc.)
   - Location: ~/.local/share/color-schemes/Sweet.colors

4. **Sweet Kvantum theme** - For consistent widget styling
   - Location: ~/.config/Kvantum/Sweet/

## Manual Configuration

After running the script, you may want to:

1. Set Plasma Style to Sweet:
   System Settings > Appearance > Plasma Style > Sweet

2. Set Window Decorations (if available):
   System Settings > Appearance > Window Decorations

3. Set Icons to match (Candy icons work well with Sweet):
   System Settings > Appearance > Icons

## Troubleshooting

If apps like Dolphin dont match the theme:

1. Check Kvantum is set correctly:
   cat ~/.config/Kvantum/kvantum.kvconfig
   Should show: theme=Sweet

2. Restart the application or log out/in

3. Make sure widget style is set to kvantum:
   System Settings > Appearance > Application Style > kvantum

## Related Links

- Sweet GTK: https://github.com/EliverLara/Sweet
- Sweet KDE: https://github.com/EliverLara/Sweet-kde
- KDE Store: https://store.kde.org/p/1294729
