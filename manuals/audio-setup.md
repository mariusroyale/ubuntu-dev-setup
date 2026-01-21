# Audio Setup - Carla + TDR Nova (Wine/Yabridge)

## Problem
- Carla does not remember plugins on restart
- TDR Nova (Windows VST via yabridge) audio connections disappear
- Wine Desktop window appears alongside plugin GUI

## Solutions

### 1. Carla Auto-Load Project on Startup

Create a local desktop entry override to load your saved project:

```bash
mkdir -p ~/.local/share/applications
cp /usr/share/applications/carla.desktop ~/.local/share/applications/
```

Edit `~/.local/share/applications/carla.desktop` and change:
```
Exec=carla /home/marius/Music/default.carxp
```

Refresh desktop database:
```bash
update-desktop-database ~/.local/share/applications/
```

### 2. Yabridge Plugin Configuration

Create `~/.vst/yabridge/yabridge.toml`:
```toml
["TDR Nova.dll"]
editor_xembed = true
```

### 3. Hide Wine Desktop Window (KDE)

Wine virtual desktop is required for plugin mouse input to work, but creates an annoying blue window.

Create `~/.config/kwinrulesrc`:
```ini
[General]
count=1
rules=1

[1]
Description=Minimize Wine Desktop Window
minimize=true
minimizerule=3
title=Wine Desktop
titlematch=1
types=1
```

Reload KWin:
```bash
qdbus6 org.kde.KWin /KWin reconfigure
```

### 4. Wine Virtual Desktop Settings

The Wine virtual desktop must be enabled for yabridge plugins to receive mouse input:

```bash
wine reg add "HKEY_CURRENT_USER\Software\Wine\Explorer" /v Desktop /d "Default" /f
wine reg add "HKEY_CURRENT_USER\Software\Wine\Explorer\Desktops" /v Default /d "800x600" /f
```

### 5. Audio Connection Persistence (aj-snapshot)

For persistent JACK audio connections, use the aj-snapshot daemon.

#### Install
```bash
sudo apt install aj-snapshot
```

#### Save current connections
```bash
aj-snapshot -j ~/Music/audio-connections.xml
```

#### Systemd User Service (Auto-restore)

Copy the service file:
```bash
cp systemd-daemons/aj-snapshot.service ~/.config/systemd/user/
```

Or create `~/.config/systemd/user/aj-snapshot.service`:
```ini
[Unit]
Description=JACK Audio Connection Restore Daemon
After=pipewire-jack.service pipewire.service

[Service]
ExecStart=/usr/bin/aj-snapshot -jxd %h/Music/audio-connections.xml
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

Enable and start:
```bash
systemctl --user daemon-reload
systemctl --user enable aj-snapshot.service
systemctl --user start aj-snapshot.service
```

The daemon monitors JACK and automatically restores connections whenever a client (like TDR Nova) appears.

#### Update saved connections
```bash
aj-snapshot -j ~/Music/audio-connections.xml
```

## Troubleshooting

### Kill stuck Wine/Carla processes
```bash
wineserver -k
pkill -9 wine
pkill -9 carla
```

### Check yabridge status
```bash
yabridgectl status
```

### Resync yabridge plugins
```bash
yabridgectl sync
```

### Check aj-snapshot service status
```bash
systemctl --user status aj-snapshot.service
```

### View aj-snapshot logs
```bash
journalctl --user -u aj-snapshot.service -f
```
