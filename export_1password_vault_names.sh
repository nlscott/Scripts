#!/bin/zsh

## requires 1password cli installed
## use --permission manage_vault to show all vaults your account has access to
## if you run this as a 1password owner, you would export a list of all shared vaults
op vault list --permission manage_vault --format=json \
    | jq -r '[["Name", "UUID"]] + map([.name, .id]) | map(@csv)[]' \
    > vaults.csv