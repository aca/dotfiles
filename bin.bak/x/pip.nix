#!/usr/bin/env nix-shell
#! nix-shell -i bash -p python311
# set this to wherever you want your virtualenv
venv="$HOME/.nix-pip"
# set up the venv
# python -m venv "$venv"
# activate the venv
source "$venv/bin/activate"
# upgrade pip if necessary
python -m pip install --upgrade pip
# now install whatever you need
pip install -U $1
# optionally, run it
"$@"
