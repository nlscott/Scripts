#!/bin/zsh

# Bluetooth Keyboard -----------------------------------------------------------
KeyboardPercent=$(ioreg -r -l -k "BatteryPercent" \
| grep -A 9 "Magic Keyboard with Touch ID" \
| grep "BatteryPercent" \
| awk '{print $3}')

typeset -i b=5
echo "Keyboard:\t\t\c"

if [ ${KeyboardPercent} = 0 ]
then
    echo "Disconnected\c"
else
    if [ $KeyboardPercent -lt 11 ]
    then
        echo "\033[1;31m\c"
    else
        echo "\033[0m\c"
    fi
    while [ $b -le $KeyboardPercent ]
    do
        echo "|\c"
        b=`expr $b + 5`
    done
    while [ $b -le 100 ]
    do
        echo "\033[1;37m|\033[0m\c"
        b=`expr $b + 5`
    done
    echo "\033[0m $KeyboardPercent%\c"
    unset KeyboardPercent
    unset b
fi

echo "\033[0m\nMouse:\t\t\t\c"

# Bluetooth Mouse --------------------------------------------------------------

MousePercent=$(ioreg -r -l -k "BatteryPercent" \
| grep -A 9 "Magic Mouse" \
| grep "BatteryPercent" \
| awk '{print $3}')

if [ ${MousePercent} = 0 ]
then
    echo "Disconnected\c"
else
    if [ $MousePercent -lt 11 ]
    then
        echo "\033[1;31m\c"
    else
        echo "\033[0m\c"
    fi
    typeset -i b=5
    while [ $b -le $MousePercent ]
    do
        echo "|\c"
        b=`expr $b + 5`
    done
    while [ $b -le 100 ]
    do
        echo "\033[1;37m|\033[0m\c"
        b=`expr $b + 5`
    done
    echo "\033[0m $MousePercent%\c"
    unset MousePercent
    unset b
fi

