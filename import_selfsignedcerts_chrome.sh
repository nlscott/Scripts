#!/bin/bash

# import CA root certificates on Linux, so chrome trust self-signed certs
# https://thomas-leister.de/en/how-to-import-ca-root-certificate/



# variables ----------------------------------------------------------------------------------------
certfile="bitbucket.pem"
certname="Bitbucket SSL"


for certDB in $(find ~/ -name "cert8.db")
do
    certdir=$(dirname ${certDB});
    certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d dbm:${certdir}
done

for certDB in $(find ~/ -name "cert9.db")
do
    certdir=$(dirname ${certDB});
    certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i ${certfile} -d sql:${certdir}
done
