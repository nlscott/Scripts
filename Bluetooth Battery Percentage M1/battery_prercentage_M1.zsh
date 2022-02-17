#!/bin/zsh


KeyboardPercent=$(ioreg -r -l -k "BatteryPercent" \
| grep -A 9 "Magic Keyboard with Touch ID" \
| grep "BatteryPercent" \
| awk '{print $3}')

MousePercent=$(ioreg -r -l -k "BatteryPercent" \
| grep -A 9 "Magic Mouse" \
| grep "BatteryPercent" \
| awk '{print $3}')


echo "Keyboard Battery Level: $KeyboardPercent"
echo "Mouse Battery Level: $MousePercent"
