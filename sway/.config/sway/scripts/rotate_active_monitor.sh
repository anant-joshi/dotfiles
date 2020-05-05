#!/bin/bash
active_output=$1
swaymsg output \"$active_output\" transform "90" clockwise
