#!/bin/sh

killall -q polybar

polybar main -c ~/.config/polybar/config &
polybar aux -c ~/.config/polybar/config &