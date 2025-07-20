#!/bin/bash
#
# USAGE
# ./ryzen_ccd_stress_test.sh --mode=cpu --ccd=ccd0
# ./ryzen_ccd_stress_test.sh --mode=memory --ccd=ccd1
# ./ryzen_ccd_stress_test.sh --mode=mixed --ccd=all

LOGFILE="$HOME/ryzen_ccd_stress_log_$(date +%Y%m%d_%H%M%S).log"
TIMEOUT="1m"
TIMEOUT_SEC=$(( $(echo $TIMEOUT | grep -o '[0-9]\+') * 60 ))  # assumes minutes
MEM_LOAD="90%"
MODE="memory"  # default mode
CCD_SELECTION="ccd0"  # default CCD: all | ccd0 | ccd1

# CCD core ranges
CCD0_CORES="0-5"
CCD1_CORES="6-11"
ALL_CORES="0-11"

# Parse --mode and --ccd if provided
for arg in "$@"; do
  case $arg in
    --mode=*)
      MODE="${arg#*=}"
      shift
      ;;
    --ccd=*)
      CCD_SELECTION="${arg#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

case $CCD_SELECTION in
  ccd0)
    CORES_TOTAL=6
    TASKSET_RANGE=$CCD0_CORES
    ;;
  ccd1)
    CORES_TOTAL=6
    TASKSET_RANGE=$CCD1_CORES
    ;;
  all)
    CORES_TOTAL=12
    TASKSET_RANGE=$ALL_CORES
    ;;
  *)
    echo "❌ Unknown CCD selection: $CCD_SELECTION. Use ccd0, ccd1, or all."
    exit 1
    ;;
esac

log() {
  echo -e "[$(date '+%H:%M:%S')] $*" | tee -a "$LOGFILE"
}

show_progress_bar_for_pid() {
  pid=$1
  max_duration=$2
  bar_length=50
  interval=1
  elapsed=0

  while kill -0 $pid 2>/dev/null && [ $elapsed -lt $max_duration ]; do
    percent=$(( 100 * elapsed / max_duration ))
    percent=$(( percent > 100 ? 100 : percent ))
    filled=$(( bar_length * percent / 100 ))
    empty=$(( bar_length - filled ))
    printf "\r[%s%s] %3d%%" "$(printf '#%.0s' $(seq 1 $filled))" "$(printf ' %.0s' $(seq 1 $empty))" "$percent"
    sleep $interval
    ((elapsed+=interval))
  done

  # Force full bar if still running
  if kill -0 $pid 2>/dev/null; then
    printf "\r[%s] ...done\n" "$(printf '#%.0s' $(seq 1 $bar_length))"
  else
    printf "\r[%s] 100%%\n" "$(printf '#%.0s' $(seq 1 $bar_length))"
  fi
}

run_stress() {
  desc=$1
  cpu_count=$2
  taskset_range=$3

  log "🔧 Starting test: $desc"
  log "    → Mode: $MODE"
  log "    → Taskset: $taskset_range"
  log "    → Timeout: $TIMEOUT"
  echo ""

  cmd="stress-ng --taskset $taskset_range --timeout $TIMEOUT --metrics"
  case $MODE in
    cpu)
      cmd+=" --cpu $cpu_count"
      ;;
    memory)
      cmd+=" --vm $cpu_count --vm-bytes $MEM_LOAD"
      ;;
    mixed)
      cmd+=" --cpu $cpu_count --vm $cpu_count --vm-bytes $MEM_LOAD"
      ;;
    *)
      log "❌ Unknown mode: $MODE. Use cpu, memory, or mixed."
      exit 1
      ;;
  esac

  log "Running: $cmd"
  echo ""

  bash -c "$cmd" >> "$LOGFILE" 2>&1 &
  stress_pid=$!

  show_progress_bar_for_pid $stress_pid $TIMEOUT_SEC

  wait $stress_pid
  if [ $? -eq 0 ]; then
    log "✅ $desc passed"
  else
    log "❌ $desc failed or exited with errors"
  fi
  echo ""
}

log "==============================="
log "== Ryzen CCD Stress Test Started =="
log "Log File: $LOGFILE"
log "Timeout per test: $TIMEOUT"
log "Memory Load: $MEM_LOAD"
log "Selected Mode: $MODE"
log "Selected CCD: $CCD_SELECTION"
log "==============================="
echo ""

run_stress "CCD test: $CCD_SELECTION" "$CORES_TOTAL" "$TASKSET_RANGE"

log "==============================="
log "== Test Complete =="
log "Log saved to: $LOGFILE"
log "==============================="
