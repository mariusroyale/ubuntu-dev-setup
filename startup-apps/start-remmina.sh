#!/bin/bash
remmina &
sleep 2
wmctrl -r "Remmina" -b add,hidden
