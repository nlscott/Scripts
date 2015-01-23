#!/bin/bash
#Installs IP based printer. Print drivers must already be installed on the system


#Variables
#---------------------------------------------------------
printername="xxx"
printerpath="xxx"
printdriver="xxxx"
printerlocation="xxxxxx"


#Variables Example
#---------------------------------------------------------
#printername="asc3hp"
#printerpath="asc3hp.college.edu"
#printdriver="CNPZUIR3045ZU.ppd.gz"
#printerlocation="Ascension Room 113"



# create printer queue in system preferences > printers
# sets default to black & white
# sets default page to letter
# sets sharing to off
#---------------------------------------------------------
/usr/sbin/lpadmin -p "$printername" -E -v lpd://"$printerpath" -P "/Library/Printers/PPDs/Contents/Resources/$printdriver" -D "$printername" -L "$printerlocation" -o ColorModel=Gray -o PageSize=Letter -o printer-is-shared=false






