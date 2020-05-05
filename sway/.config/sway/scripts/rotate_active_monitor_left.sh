#!/bin/bash
read active_output
swaymsg output \"$active_output\" transform "90" anticlockwise
