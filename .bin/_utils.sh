#!/usr/bin/env bash

echo 3

linux() {
    [[ "$OSTYPE" == "linux-gnu"* ]]
}

darwin() {
    [[ "$OSTYPE" == "darwin"* ]]
}
