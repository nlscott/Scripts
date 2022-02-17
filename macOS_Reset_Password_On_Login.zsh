#!//bin/zsh

userAccount="user1"
localAdmin="admin1"


pwpolicy \
-a "$localAdmin" \
-u "$userAccount" \
-setpolicy "newPasswordRequired=1"
