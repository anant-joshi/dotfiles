#!/bin/bash
active_output=$(swaymsg -pt get_outputs | grep focused | grep -o "'.*'" |sed "s/'//g")
echo $active_output
