#!/bin/sh

#variables
sha1_to_check="7a860d9d3f3512a9cdf770ca75c8fd2fdde4e0fc"


#Get file to check from user
echo "What file do you want to check? "
read filepath

downloaded_sha1=`/usr/bin/openssl sha1 $filepath | awk '{print $2}'`

echo  "\nOriginal check is: $downloaded_sha1"


#compare current file against static variable
if [[  $downloaded_sha1 == $sha1_to_check ]]; then
	echo "File is valid\n"
else
	echo "File failed\n"
fi