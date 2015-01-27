free_space=`diskutil info / | grep "Free Space" | awk '{print $4}'`.to_i
