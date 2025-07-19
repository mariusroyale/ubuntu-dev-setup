#!/bin/bash

set -e

# Check for root
if [[ "$EUID" -ne 0 ]]; then
  echo "⛔ This script must be run as root (use sudo)!"
  echo "💡 Try: sudo $0 $*"
  exit 1
fi

WITH_APM=0
for arg in "$@"; do
  if [[ "$arg" == "--with-apm" ]]; then
    WITH_APM=1
  fi
done

SERVICE_FILE="/etc/systemd/system/hdparm-apply.service"
SCRIPT_FILE="/usr/local/sbin/hdparm_apply.sh"
HDPARM_SERVICE=0

echo "🚀 Starting hdparm service installer..."

if [[ -f "$SERVICE_FILE" ]]; then
  HDPARM_SERVICE=1
  echo "⚠️  Detected existing systemd service at $SERVICE_FILE"
  read -p "Do you want to overwrite the existing service and script? (y/N): " answer
  case "$answer" in
    [Yy]* )
        echo "✅ Overwriting existing service and script." ;;
    * ) echo "❌ Installation cancelled by user."; exit 0 ;;
  esac
fi

echo "📝 Writing hdparm_apply.sh to $SCRIPT_FILE..."

if [[ $WITH_APM -eq 1 ]]; then
  cat << 'EOF' > "$SCRIPT_FILE"
#!/bin/bash
/usr/sbin/hdparm -B 254 /dev/sda
/usr/sbin/hdparm -S 180 /dev/sda
/usr/sbin/hdparm -M 254 /dev/sda
EOF
  echo "⚙️  Including APM and AAM settings as requested."
else
  cat << 'EOF' > "$SCRIPT_FILE"
#!/bin/bash
/usr/sbin/hdparm -S 180 /dev/sda
EOF
  echo "⚙️  Skipping APM and AAM settings."
fi

echo "🔐 Making $SCRIPT_FILE executable..."
chmod +x "$SCRIPT_FILE"

echo "⚙️  Creating systemd unit: $SERVICE_FILE..."
cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Apply hdparm settings to /dev/sda
After=local-fs.target

[Service]
Type=oneshot
ExecStart=$SCRIPT_FILE
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Reloading systemd daemon..."
systemctl daemon-reload

# If service is active, stop it first before restarting
if systemctl is-active --quiet hdparm-apply.service; then
  echo "⚠️  hdparm-apply.service is currently running. Stopping it first..."
  systemctl stop hdparm-apply.service
fi

echo "📌 Enabling hdparm-apply.service to start at boot..."
systemctl enable hdparm-apply.service

echo "▶️  Starting hdparm-apply.service..."
systemctl start hdparm-apply.service

echo "🔍 Verifying service status..."
systemctl --no-pager status hdparm-apply.service

echo "✅ Done! hdparm settings applied and service is active. 🧠💾🛠️"
