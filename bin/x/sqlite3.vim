#!/usr/bin/env bash

set -euo pipefail
export DB_UI_main=sqlite:$1
# export SQLS_SQLITE_DB_FILE="file:$1"
export DBEE_CONNECTIONS='[
    {
        "name": "db",
        "url": "farchive.db",
        "type": "sqlite"
    }
]'
nvim
