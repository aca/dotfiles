#!/usr/bin/env bash
compgen -f -X !*.@(@(torrent|meta4|metalink|text|txt|list|lst)|@(TORRENT|META4|METALINK|TEXT|TXT|LIST|LST)) -o plusdirs -- ''
