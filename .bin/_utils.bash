#!/usr/bin/env bash

linux() {
    [[ "$OSTYPE" == "linux-gnu"* ]]
}

darwin() {
    [[ "$OSTYPE" == "darwin"* ]]
}
