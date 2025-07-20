#!/bin/bash

show_progress_bar() {
  duration=$1
  bar_length=50
  interval=1

  for ((elapsed=0; elapsed<duration; elapsed+=interval)); do
    percent=$(( 100 * elapsed / duration ))
    filled=$(( bar_length * elapsed / duration ))
    empty=$(( bar_length - filled ))
    printf "\r[%s%s] %3d%%" "$(printf '#%.0s' $(seq 1 $filled))" "$(printf ' %.0s' $(seq 1 $empty))" "$percent"
    sleep $interval
  done
  printf "\r[%s] 100%%\n" "$(printf '#%.0s' $(seq 1 $bar_length))"
}

echo "🧪 Previewing progress bar for 1 minute..."
show_progress_bar 60
echo -e "\n✅ Done."
