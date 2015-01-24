#!/bin/sh
#version 1.1

#Variables
domain_name="xxx"

#User input
echo "Enter A User Name: "
read text

#command - filters OU's out
dscl "/Active Directory/$domain_name/All Domains" -read /Users/$text dsAttrTypeNative:memberOf | awk '/dsAttr/{y=1;next}y' | cut -d "," -f 1 | cut -c 5-50

