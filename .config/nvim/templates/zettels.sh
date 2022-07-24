#!/bin/sh

cat <<EOF
---
title: $1
date: $(date "+%Y-%m-%dT%H:%M")
tags:
---
EOF
echo
