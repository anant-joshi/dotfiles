#!/bin/bash
IMAGE=/home/anant/Pictures/arch_wallpaper/wallpaper.png
CONVERTED=/tmp/wallpaper.png
OPTION=b
COMPOSE=/home/anant/.config/i3/padlock.png
LOCK="/tmp/lock.png"
while getopts ":i" opt; do
  case $opt in
    i)
      OPTION=i
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $(($OPTIND - 1))
IMAGE=$1
case $OPTION in
  i)
  convert $IMAGE -blur "0x3" $CONVERTED
  i3lock -i $CONVERTED
  rm $CONVERTED
  exit 0
  ;;
esac
# scrot $LOCK
# convert $LOCK -resize 20% $CONVERTED
# convert $CONVERTED -blur "0x4" $CONVERTED
# convert $CONVERTED -resize 1000% %CONVERTED
# i3lock -i $CONVERTED

scrot $LOCK
convert $LOCK -resize 10% $CONVERTED
convert $CONVERTED -blur "0x3" $CONVERTED
convert $CONVERTED -resize 1000% $CONVERTED
composite -gravity center $COMPOSE $CONVERTED $CONVERTED
i3lock -i $CONVERTED
