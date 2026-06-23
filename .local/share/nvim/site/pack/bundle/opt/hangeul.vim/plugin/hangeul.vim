"" hangeul.vim -- vim implementation of Hangeul input method
"" Copyright (c) 2007, Kang Seonghoon aka lifthrasiir.
""
"" This program is free software: you can redistribute it and/or modify
"" it under the terms of the GNU General Public License as published by
"" the Free Software Foundation, either version 2 of the License, or
"" (at your option) any later version.
""
"" This program is distributed in the hope that it will be useful,
"" but WITHOUT ANY WARRANTY; without even the implied warranty of
"" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"" GNU General Public License for more details.

scripte utf-8

if exists('loaded_hangeul')
	finish
endif

if !exists('hangeul_enabled')
	finish
endif
if !has('autocmd') || !has('iconv')
	echoerr 'hangeul.vim: This plugin requires +autocmd and +iconv.'
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

if !exists('hangeul_default_mode')
	let hangeul_default_mode = '2s'
endif
if !exists('hangeul_hanja_path')
	let hangeul_hanja_path = substitute(&rtp, '\(\\,\|[^,]\)*', '&,&/plugin', '')
endif
if !exists('hangeul_hanja_desc_limit')
	let hangeul_hanja_desc_limit = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TABLE{I,M,F} -- tables for initial, medial, final jamos
"                 0     1     2     3     4     5     6     7     8     9
let s:TABLEI = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ',
              \ 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']
let s:TABLEM = ['ㅏ', 'ㅐ', 'ㅑ', 'ㅒ', 'ㅓ', 'ㅔ', 'ㅕ', 'ㅖ', 'ㅗ', 'ㅘ',
              \ 'ㅙ', 'ㅚ', 'ㅛ', 'ㅜ', 'ㅝ', 'ㅞ', 'ㅟ', 'ㅠ', 'ㅡ', 'ㅢ',
              \ 'ㅣ']
let s:TABLEF = ['ㄱ', 'ㄲ', 'ㄳ', 'ㄴ', 'ㄵ', 'ㄶ', 'ㄷ', 'ㄹ', 'ㄺ', 'ㄻ',
              \ 'ㄼ', 'ㄽ', 'ㄾ', 'ㄿ', 'ㅀ', 'ㅁ', 'ㅂ', 'ㅄ', 'ㅅ', 'ㅆ',
              \ 'ㅇ', 'ㅈ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ']

" TABLEC{M,F} -- mappings from keystrokes to medial/final compounds
"                Key consists of two elements (A * 100 + B).
let s:TABLECM = { 800:  9,  801: 10,  820: 11, 1304: 14, 1305: 15, 1320: 16,
               \ 1820: 19}
let s:TABLECF = {   0:  1,   18:  2,  321:  4,  326:  5,  700:  8,  715:  9,
               \  716: 10,  718: 11,  724: 12,  725: 13,  726: 14, 1618: 17,
               \ 1818: 19}

" TABLEFC -- reverse mapping from final jamo to compound elements & initial jamo
" Legend: (A * 100 + B) * 100 + C
"         A and B are compound elements; if not compound, A should be 99.
"         C is equivalent initial jamo # or 99 (no equivalent jamo).
let s:TABLEFC = [990000,      1,    999, 990202,  31299,  31899, 990303, 990505,
               \  70099,  70699,  70799,  70999,  71699,  71799,  71899, 990606,
               \ 990707, 160999, 990909, 180910, 991111, 991212, 991414, 991515,
               \ 991616, 991717, 991818]

" GetSyllable -- get a Hangeul syllable from serial (-1 to 11171)
if &enc ==? 'utf-8'
	function s:GetSyllable(serial)
		return nr2char(44033 + a:serial)
	endfunc
else
	function s:GetSyllable(serial)
		let code = 44033 + a:serial
		let s = nr2char(224 + code/4096) . nr2char(128 + code/64%64)
				\ . nr2char(128 + code%64)
		return iconv(s, 'utf-8', &enc)
	endfunc
endif

" Keystrokes -- get current syllable's representation
function s:Keystrokes()
	let keys = ''
	if s:init < 0
		let keys .= (s:med < 0 ? '' : s:TABLEM[s:med])
		let keys .= (s:fin < 0 ? '' : s:TABLEF[s:fin])
	elseif s:med < 0
		let keys .= s:TABLEI[s:init]
		let keys .= (s:fin < 0 ? '' : s:TABLEF[s:fin])
	else
		let keys .= s:GetSyllable(s:init * 588 + s:med * 28 + s:fin)
	endif
	return keys
endfunc

" Update -- update current syllable and returns appropriate key sequences
function s:Update(init, med, fin)
	let keys = ''
	if !(s:init < 0 && s:med < 0 && s:fin < 0)
		let keys .= "\<C-H>"
		if ((s:init < 0) + (s:med < 0) == 1) && s:fin >= 0
			let keys .= "\<C-H>"
		endif
	endif
	let s:init = a:init | let s:med = a:med | let s:fin = a:fin
	return keys . s:Keystrokes()
endfunc

"-------------------------------------------------------------------------------
" 1991 final three-layered keyboard scheme (Sebeolsik final)
" 1990 three-layered keyboard scheme (Sebeolsik 390)
"   - This implementation supports order-independent input of syllable.

" Legend: 0xx for final, 1xx for medial, 2xx for initial, string for raw
"         negative number denotes conjoinable element
let s:MAP3f = [  1, '·',  21,  13,  12, '“', 216, "'", '~', '”', '+', ',',
             \ ')', '.',-108, 215,  26,  19,  16, 112, 117, 102, 107, 119,
             \-113, '4',-207, ',', '>', '.', '!',   8,   6, '?',  23,  10,
             \   4,   9, 103, '0', '7', '1', '2', '3', '"', '-', '8', '9',
             \  25,  14,   5,  11, '6',   2,  24,  17, '5',  22, '(', ':',
             \ '<', '=', ';', '*',  20, 113, 105, 120, 106, 100, 118, 202,
             \ 206, 211,-200,-212, 218,-209, 214, 217,  18, 101,   3, 104,
             \-203, 108,   7,   0, 205,  15, '%', '\', '/', '※']
let s:MAP39 = [ 21, '"', '#', '$', '%', '&', 216, '(', ')', '*', '+', ',',
             \ '-', '.',-108, 215,  26,  19,  16, 112, 117, 102, 107, 119,
             \-113, ':',-207, '<', '=', '>', '?', '@',   6, '!',   9,   8,
             \  23,   1, '/', "'", '8', '4', '5', '6', '1', '0', '9', '>',
             \  25, 103,   5, ';', '7',  14,  24,  17, '<',  22, '[', '\',
             \ ']', '^', '_', '`',  20, 113, 105, 120, 106, 100, 118, 202,
             \ 206, 211,-200,-212, 218,-209, 214, 217,  18, 101,   3, 104,
             \-203, 108,   7,   0, 205,  15, '{', '|', '}', '~']

function s:Begin3f()
	let s:init = -1 | let s:med = -1 | let s:fin = -1
	let s:state = 0
endfunc
function s:Begin39()
	call s:Begin3f()
endfunc

function s:Compose3f(key)
	let value = s:MAP{s:mode}[a:key - 33]
	if type(value) == type('')
		call s:Finish3f()
		return value
	endif
	let conjoining = 0
	if value < 0
		let value = -value
		let conjoining = 1
	endif

	if s:state == 1 && value == s:init + 200
		" for initial jamo can be doubled
		let s:state = 0
		return s:Update(s:init + 1, s:med, s:fin)
	elseif s:state == 2 && value >= 100 && value < 200
		" for conjoining medial jamo
		if has_key(s:TABLECM, s:med * 100 + value - 100)
			let s:state = 0
			let newmedial = s:TABLECM[s:med * 100 + value - 100]
			return s:Update(s:init, newmedial, s:fin)
		endif
	elseif s:state == 3 && value < 100
		" for final jamo compound
		if has_key(s:TABLECF, s:fin * 100 + value)
			let s:state = 0
			let newfinal = s:TABLECF[s:fin * 100 + value]
			return s:Update(s:init, s:med, newfinal)
		endif
	endif

	if value < 100  " -- final jamo
		if s:fin >= 0 | call s:Finish3f() | endif
		let s:state = 3
		return s:Update(s:init, s:med, value)
	elseif value < 200  " -- medial jamo
		if s:med >= 0 | call s:Finish3f() | endif
		let s:state = (conjoining ? 2 : 0)
		return s:Update(s:init, value - 100, s:fin)
	else  " -- initial jamo
		if s:init >= 0 | call s:Finish3f() | endif
		let s:state = (conjoining ? 1 : 0)
		return s:Update(value - 200, s:med, s:fin)
	endif
endfunc
function s:Compose39(key)
	if a:key == 47 && ((s:init < 0 && s:med < 0 && s:fin < 0) || s:med >= 0)
		" slash is medial jamo only when it combines into current syllable
		call s:Finish39()
		let s:state = 0
		return '/'
	endif
	return s:Compose3f(a:key)
endfunc

function s:Revert3f()
	let s:state = 0
	if s:fin >= 0
		return s:Update(s:init, s:med, -1)
	endif
	if s:med >= 0
		return s:Update(s:init, -1, -1)
	endif
	if s:init >= 0
		return s:Update(-1, -1, -1)
	endif
	return "\<C-H>"
endfunc
function s:Revert39()
	return s:Revert3f()
endfunc

function s:Finish3f()
	let s:init = -1 | let s:med = -1 | let s:fin = -1
	let s:state = 0
endfunc
function s:Finish39()
	call s:Finish3f()
endfunc

"-------------------------------------------------------------------------------
" KS X 5002 two-layered scheme (Dubeolsik standard)

" Legend: A * 100 + B or -1 (not applicable)
"         Vowel if A is 99, where B is medial jamo #
"         Consonant otherwise, where A is initial # and B is final # (or 99)
let s:MAP2s = [ 615, 9917, 1422, 1120,  499,  507, 1826, 9908, 9902, 9904,
             \ 9900, 9920, 9918, 9913, 9903, 9907,  899,  101,  203, 1019,
             \ 9906, 1725, 1399, 1624, 9912, 1523,   -1,   -1,   -1,   -1,
             \   -1,   -1,  615, 9917, 1422, 1120,  306,  507, 1826, 9908,
             \ 9902, 9904, 9900, 9920, 9918, 9913, 9901, 9905,  716,    0,
             \  203,  918, 9906, 1725, 1221, 1624, 9912, 1523,   -1,   -1,
             \   -1,   -1]

function s:Begin2s()
	let s:init = -1 | let s:med = -1 | let s:fin = -1
	let s:state = 0
endfunc

function s:Compose2s(key)
	if a:key < 65 || s:MAP2s[a:key - 65] < 0
		call s:Finish2s()
		return nr2char(a:key)
	endif
	let value1 = s:MAP2s[a:key - 65] / 100
	let value2 = s:MAP2s[a:key - 65] % 100
	let isvowel = (value1 == 99)

	if s:state == 1  " -- initial jamo is present
		if isvowel
			let s:state = 2
			return s:Update(s:init, value2, -1)
		elseif 697015 % (value1 * 2 + 5) == 0 && value1 == s:init
			return s:Update(s:init + 1, -1, -1)
		endif
	elseif s:state == 2 || s:state == 5  " -- medial jamo is present
		if isvowel
			if has_key(s:TABLECM, s:med * 100 + value2)
				let newmedial = s:TABLECM[s:med * 100 + value2]
				return s:Update(s:init, newmedial, -1)
			endif
		elseif s:state == 2 && value2 != 99
			let s:state = 3
			return s:Update(s:init, s:med, value2)
		endif
	elseif s:state == 3 || s:state == 4  " -- all jamo are present
		if isvowel
			if s:state == 3
				let prevfinal = -1
				let nextinitial = s:TABLEFC[s:fin] % 100
			else
				let prevfinal = s:TABLEFC[s:fin] / 10000
				let nextinitial = s:TABLEFC[s:fin] / 100 % 100
			endif
			let iresult = s:Update(s:init, s:med, prevfinal)
			call s:Finish2s()
			let s:state = 2
			return iresult . s:Update(nextinitial, value2, -1)
		else
			if has_key(s:TABLECF, s:fin * 100 + value2)
				let s:state = 4
				let newfinal = s:TABLECF[s:fin * 100 + value2]
				return s:Update(s:init, s:med, newfinal)
			endif
		endif
	endif

	call s:Finish2s()
	if value1 == 99
		let s:state = 5
		return s:Update(-1, value2, -1)
	else
		let s:state = 1
		return s:Update(value1, -1, -1)
	endif
endfunc

function s:Revert2s()
	if s:fin >= 0
		let s:state = 2
		return s:Update(s:init, s:med, -1)
	endif
	if s:med >= 0
		let s:state = (s:init < 0 ? 0 : 1)
		return s:Update(s:init, -1, -1)
	endif
	let s:state = 0
	if s:init >= 0
		return s:Update(-1, -1, -1)
	else
		return "\<C-H>"
	endif
endfunc

function s:Finish2s()
	let s:init = -1 | let s:med = -1 | let s:fin = -1
	let s:state = 0
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:internal = 0

" Begin -- initialize automaton state and set internal flag (if needed)
function s:Begin(reset)
	if a:reset
		let s:internal = 0
		let s:mode = s:prevmode
	endif
	if s:mode != 'en'
		call s:Begin{s:mode}()
	endif
endfunc

" Compose -- update current syllable from key input
function s:Compose(key)
	let s:internal = s:internal + 1
	if s:mode == 'en'
		return nr2char(a:key)
	else
		return s:Compose{s:mode}(a:key)
	endif
endfunc

" Revert -- undo one key input
function s:Revert()
	let s:internal = s:internal + 1
	if s:mode == 'en'
		return "\<C-H>"
	else
		return s:Revert{s:mode}()
	endif
endfunc

" Finish -- finish, adjust automaton state and reset internal flag (if needed)
function s:Finish(reset)
	if s:mode != 'en'
		call s:Finish{s:mode}()
	endif
	if a:reset
		let s:internal = 0
		let s:prevmode = s:mode
		let s:mode = 'en'
	endif
endfunc

" ChangeMode -- alternate current input mode
function s:ChangeMode()
	call s:Finish(0)
	let s:mode = (s:mode == 'en' ? g:hangeul_default_mode : 'en')
	call s:Begin(0)
	let &ro = &ro   " -- force updating of status line
	return ''
endfunc

" ConvertHanja -- convert current syllable to equivalent hanja
function s:ConvertHanja()
	if mode() != 'i' || s:mode == 'en'
		return ''
	endif
	let key = s:Keystrokes()
	if !has_key(s:HANJADB, key)
		if &verbose
			echomsg 'hangeul.vim: No match found.'
		endif
		return ''
	endif
	let db = s:HANJADB[key]

	let desclimit = g:hangeul_hanja_desc_limit
	if desclimit > 0
		let descpat = '^\([^,]*\(,[^,]*\)\{' . (desclimit - 1) . '}\),.*$'
	endif

	let cands = [key]
	let i = 0
	while i < len(db)
		if desclimit == 0
			let desc = ''
		elseif desclimit > 0
			let desc = substitute(db[i+1], descpat, '\1, ...', '')
		else
			let desc = db[i+1]
		endif
		call add(cands, {'word': db[i], 'menu': desc})
		let i += 2
	endwhile
	call complete(col('.') - strlen(key), cands)
	return ''
endfunction

" Refresh -- clean up composition of current syllable
function s:Refresh()
	if s:internal
		let s:internal = s:internal - 1
		return
	endif
	call s:Finish(0)
	call s:Begin(0)
endfunc

" ModeString -- return current mode for use of status line
function s:ModeString()
	if s:mode == 'en' | return 'Eng'
	elseif s:mode == '3f' | return 'H3f'
	elseif s:mode == '39' | return 'H39'
	elseif s:mode == '2s' | return 'H2s'
	else | return '???'
	endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GetHanjaDB -- initialize hanja candidate list from external file
" This routine requires libhangul's hanja.txt, which can be obtained from:
"   svn://kldp.net/svnroot/hangul/libhangul/trunk/data/hanja/hanja.txt
" You may also want to clean up entries for two-or-more-syllable words.
function s:GetHanjaDB(path)
	let db = {}
	for line in readfile(a:path, '')
		if line[0] == '#' || stridx(line, ':') != 3
			continue
		endif
		let line = iconv(line, 'utf-8', &enc)
		let [hangeul, hanja, desc] = split(line, ':', 1)
		if has_key(db, hangeul)
			call extend(db[hangeul], [hanja, desc])
		else
			let db[hangeul] = [hanja, desc]
		endif
	endfor
	return db
endfunc

" InitMapping -- initialze key mappings and autocmds.
function s:InitMapping(cmdline)
	if a:cmdline
		let map = 'map!' | let noremap = 'noremap!'
	else
		let map = 'imap' | let noremap = 'inoremap'
	endif

	let key = 33
	while key < 127
		exe noremap '<silent> <expr><Char-'.key.'> <SID>Compose('.key.')'
		let key += 1
	endwhile

	exe noremap '<silent> <expr> <Plug>HanRevert <SID>Revert()'
	exe noremap '<silent> <expr> <Plug>HanMode <SID>ChangeMode()'
	exe noremap '<silent> <Plug>HanConvert <C-R>=<SID>ConvertHanja()<CR>'

	exe map '<silent> <BS> <Plug>HanRevert'
	exe map '<silent> <C-H> <Plug>HanRevert'
	if !hasmapto('<Plug>HanConvert', 'i')
		exe map '<silent> <C-\><CR> <Plug>HanConvert'
	endif
	if !hasmapto('<Plug>HanMode', 'i')
		exe map '<silent> <C-\><Space> <Plug>HanMode'
	endif

	aug Hangeul
		au!
		au CursorMovedI * call <SID>Refresh()
		au InsertEnter * call <SID>Begin(1)
		au InsertLeave * call <SID>Finish(1)
	aug END
endfunc

" Init -- initialize all things
function s:Init()
	let s:mode = 'en'
	let s:prevmode = s:mode
	let s:prefix = substitute(expand('<sfile>'), '^.*\(<SNR>\d\+_\).*$', '\1', '')

	" initialize hanja database
	let hanjapath = split(globpath(g:hangeul_hanja_path, 'hanja.txt'), '\n')
	if len(hanjapath) == 0
		let s:HANJADB = {}
	else
		let s:HANJADB = s:GetHanjaDB(hanjapath[0])
	endif

	" initialize mappings and autocmds
	call s:InitMapping(exists('g:hangeul_cmdline'))

	" initialize status line
	if !strlen(&stl)
		set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
	endif
	let &stl = &stl . '  {%{' . s:prefix . 'ModeString()}} '

	if &verbose
		echomsg "hangeul.vim is initialized."
	endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call s:Init()

let &cpo = s:cpo_save
finish

" vim: ts=4 sw=4 noet list

