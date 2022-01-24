#!/bin/bash

# Takes a video clip and converts it to a gif with FFMPEG
# default is 100ms. To change rate, change number in "setpts=1*PTS"
# .5 = 50ms 
# 1 = 100ms
# 2 = 200ms

#Variables----------------------------------------------------------------------
path_to_file="/clip-to-convert.mp4"
filename=$(echo $path_to_file | cut -d "." -f1)


#Command -----------------------------------------------------------------------
/usr/local/bin/ffmpeg \
    -i "$path_to_file" \
    -vf "setpts=1*PTS" \
    "$filename-100ms.gif"
