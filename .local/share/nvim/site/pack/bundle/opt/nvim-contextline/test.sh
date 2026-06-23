#!/usr/bin/env bash
# Test the contextline plugin on various files

test_context() {
    local file="$1"
    local line="$2"
    local col="$3"
    local expected="$4"
    local result=$(nvim --headless -c "set rtp+=." -c "e $file" -c "normal ${line}gg${col}l" \
        -c 'lua local M = dofile("lua/nvim-contextline.lua"); print(M.get_contextline())' -c 'q' 2>&1 | tr -d '\n\r')
    if [ "$result" = "$expected" ]; then
        printf "✓ %-25s L%-3s C%-3s → %s\n" "$file" "$line" "$col" "$result"
    else
        printf "✗ %-25s L%-3s C%-3s\n  got:      %s\n  expected: %s\n" "$file" "$line" "$col" "$result" "$expected"
    fi
}

echo "Testing contextline plugin..."
echo

# Nix tests
test_context "test/services.nix" 7 5 "󰙅 systemd.services.disk-monitor > description"
test_context "test/services.nix" 10 8 "󰙅 systemd.services.disk-monitor > serviceConfig"

# Python tests
test_context "test/sample.py" 3 8 "󰙅 MyClass > method"                                    # method
test_context "test/sample.py" 8 8 "󰙅 MyClass > static_method"                             # @staticmethod
test_context "test/sample.py" 12 8 "󰙅 MyClass > class_method"                             # @classmethod
test_context "test/sample.py" 16 8 "󰙅 MyClass > my_property"                              # @property
test_context "test/sample.py" 20 12 "󰙅 MyClass > NestedClass > nested_method"             # nested class
test_context "test/sample.py" 24 4 "󰙅 standalone"                                         # function
test_context "test/sample.py" 29 4 "󰙅 decorated"                                          # @decorator
test_context "test/sample.py" 33 4 "󰙅 async_func"                                         # async def
test_context "test/sample.py" 38 8 "󰙅 outer > inner"                                      # nested function
test_context "test/sample.py" 47 16 "󰙅 OuterClass > InnerClass > DeepClass > deep_method" # deep nesting
test_context "test/sample.py" 52 8 "󰙅 \"database\" > \"host\""                            # nested dict
test_context "test/sample.py" 56 8 "󰙅 \"settings\" > \"debug\""                           # nested dict
