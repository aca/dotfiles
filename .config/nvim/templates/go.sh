#!/usr/bin/env bash

cat << EOF | tee -a /tmp/templates.log
package "$@"

EOF

