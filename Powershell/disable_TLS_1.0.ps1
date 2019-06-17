# Disable TLS 1.0 for client and server ------------------------------------------------------------
# To disable TLS 1.0 by default, create a DisabledByDefault entry and change the DWORD value to 1.
# If an SSPI app explicitly requests to use TLS 1.0, it may be negotiated.
#
# TLS 1.0
# https://docs.microsoft.com/en-us/windows-server/security/tls/tls-registry-settings#tls-10
#
# Protocols in TLS/SSL (Schannel SSP)
# https://docs.microsoft.com/en-us/windows/desktop/SecAuthN/protocols-in-tls-ssl--schannel-ssp-
#
# Test TLS 1.0 connection
# openssl s_client -connect axosofteaststa.axosoft.com:443 -tls1
#
# SERVER REQUIRES A RESTART FOR CHANGES TO TAKE EFFECT


New-Item `
    'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' `
    -Force

New-ItemProperty `
    -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' `
    -name Enabled `
    -value 0 `
    -PropertyType DWORD

New-ItemProperty `
    -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' `
    -name DisabledByDefault `
    -value 1 `
    -PropertyType DWORD

New-Item `
    'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' `
    -Force

New-ItemProperty `
    -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' `
    -name Enabled `
    -value 0 `
    -PropertyType DWORD

New-ItemProperty `
    -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' `
    -name DisabledByDefault `
    -value 1 `
    -PropertyType DWORD

