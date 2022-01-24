#!//bin/zsh


#returns a list of users on the local machine that are "Volume Owners"
diskutil apfs listUsers / \
| awk '{ print $0; if ($1 == "+--") \
{ while ("dscl . -search /Users GeneratedUID " $2 | getline) \
{ while ("dsmemberutil checkmembership -U " $1 " -G admin" | getline admin_output) \
{ if (admin_output == "user is a member of the group") \
{ print "|   User: " $1 " (Administrator)" } else \
{ print "|   User: " $1 " (Standard)" } break } break } } }'