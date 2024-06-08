#!/bin/sh

cat <<EOF
name: $1
on:
  # schedule:
  #   - cron: '*/5 * * * *'
  # workflow_dispatch:
  push:
    # paths:
    #   - src/**
    branches:
      - main
jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: echo

EOF
