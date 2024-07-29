#!/usr/bin/env bash

pkgname="$(go list $1 2>/dev/null)"
pkgnamelast=$(basename "$pkgname")

if [[ $pkgnamelast == "" ]]; then
    echo -n 'package'
else
    cat << EOF
package $pkgnamelast


EOF
fi

