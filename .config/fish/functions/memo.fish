function memo -d ''
    fish -c 'cd ~/src/zettels && nr 1>/dev/null 2>/dev/null  || true'
    fish -c 'cd ~/src/zettels && ffv'
end