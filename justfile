clean:
    sudo systemctl stop nvim-rebuild-lazy.service
    sudo systemctl stop nvim-rebuild.service
    rm .config/nvim/init.lua || true
    rm .config/nvim/init-lazy.lua || true
    sudo systemctl restart nvim-rebuild-lazy.service
    sudo systemctl restart nvim-rebuild.service
