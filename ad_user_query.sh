#!/bin/sh
#version 1.1

<<<<<<< HEAD
#variable
domain_name="xxxx"

echo "Enter A User Name: "
read text

#new command - filters OU's out
dscl "/Active Directory/$domain_name/All Domains" -read /Users/$text dsAttrTypeNative:memberOf | awk '/dsAttr/{y=1;next}y' | cut -d "," -f 1 | cut -c 5-50


=======
#Variables
domain_name="xxx"

#User input
echo "Enter A User Name: "
read text

#command - filters OU's out
dscl "/Active Directory/$domain_name/All Domains" -read /Users/$text dsAttrTypeNative:memberOf | awk '/dsAttr/{y=1;next}y' | cut -d "," -f 1 | cut -c 5-50

>>>>>>> FETCH_HEAD
