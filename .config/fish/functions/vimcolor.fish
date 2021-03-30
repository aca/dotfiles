# https://raw.githubusercontent.com/ryotako/fish-vimcolor/master/functions/vimcolor.fish
function vimcolor -a scheme -d 'convert a vim-colorscheme into a fish-colorscheme'

    # --help option message
    function __vimcolor_usage
        echo "Name: vimcolor - Convert vim-colorscheme into a fish-colorscheme!"
        echo
        echo "Usage:"
        echo "    vimcolor [options] [vim-colorscheme]"
        echo
        echo "Options:"
        echo "    -h, --help                  show this help message"
        echo "    -l, --list                  list available vim colorschemes"
        echo "    -n, --no-normal-background  ignore background color for fish_color_normal"
        echo "    -U, --universal             save the colorscheme as universal variables"
    end

    # --list option
    function __vimcolor_list
        vim -es -u '~/.vimrc' \
        +'set nonumber' \
        +'redir @a' \
        +'echo globpath(&runtimepath, \'colors/*.vim\')' \
        +'redir END' \
        +'put a' \
        +'%p' \
        +'q!' | while read -l line
            set -l scheme (string match -r '([^/]+)\.vim' $line)
            and echo $scheme[2]
        end
        true
    end

    # Parse options
    set -l scope ' -g'
    set -l scheme
    set -l bkg_ignore fish_pager_color_completion

    while count $argv >/dev/null
        switch $argv[1]
            case -h --help
                __vimcolor_usage
                return
            case -l --list
                __vimcolor_list
                return
            case -n --no-normal-background
                set bkg_ignore $bkg_ignore fish_color_normal
            case -U --universal
                set scope ' -U'
            case '--'
                if set -q argv[2]
                    set scheme $scheme $argv[2]
                    set -e argv[2]
                end
            case '-*'
                echo "vimcolor: unknown option '$argv[1]'" >/dev/stderr
                return 1
            case '*'
                set scheme $scheme $argv[1]
        end
        
        set -e argv[1]
    end

    # Chack arguments
    if test (count $scheme) -gt 1
        echo "vimcolor: select only one colorscheme" >/dev/stderr
        return 1
    end

    function __vimcolor_x11
        string match -iqr '^LightPink$'           "$argv[1]"; and echo FFB6C1; and return
        string match -iqr '^Pink$'                "$argv[1]"; and echo FFC0CB; and return
        string match -iqr '^Crimson$'             "$argv[1]"; and echo DC143C; and return
        string match -iqr '^LavenderBlush$'       "$argv[1]"; and echo FFF0F5; and return
        string match -iqr '^PaleVioletRed$'       "$argv[1]"; and echo DB7093; and return
        string match -iqr '^HotPink$'             "$argv[1]"; and echo FF69B4; and return
        string match -iqr '^DeepPink$'            "$argv[1]"; and echo FF1493; and return
        string match -iqr '^MediumVioletRed$'     "$argv[1]"; and echo C71585; and return
        string match -iqr '^Orchid$'              "$argv[1]"; and echo DA70D6; and return
        string match -iqr '^Thistle$'             "$argv[1]"; and echo D8BFD8; and return
        string match -iqr '^Plum$'                "$argv[1]"; and echo DDA0DD; and return
        string match -iqr '^Violet$'              "$argv[1]"; and echo EE82EE; and return
        string match -iqr '^Magenta$'             "$argv[1]"; and echo FF00FF; and return
        string match -iqr '^Fuchsia$'             "$argv[1]"; and echo FF00FF; and return
        string match -iqr '^DarkMagenta$'         "$argv[1]"; and echo 8B008B; and return
        string match -iqr '^Purple$'              "$argv[1]"; and echo 800080; and return
        string match -iqr '^MediumOrchid$'        "$argv[1]"; and echo BA55D3; and return
        string match -iqr '^DarkViolet$'          "$argv[1]"; and echo 9400D3; and return
        string match -iqr '^DarkOrchid$'          "$argv[1]"; and echo 9932CC; and return
        string match -iqr '^Indigo$'              "$argv[1]"; and echo 4B0082; and return
        string match -iqr '^BlueViolet$'          "$argv[1]"; and echo 8A2BE2; and return
        string match -iqr '^MediumPurple$'        "$argv[1]"; and echo 9370DB; and return
        string match -iqr '^MediumSlateBlue$'     "$argv[1]"; and echo 7B68EE; and return
        string match -iqr '^SlateBlue$'           "$argv[1]"; and echo 6A5ACD; and return
        string match -iqr '^DarkSlateBlue$'       "$argv[1]"; and echo 483D8B; and return
        string match -iqr '^Lavender$'            "$argv[1]"; and echo E6E6FA; and return
        string match -iqr '^GhostWhite$'          "$argv[1]"; and echo F8F8FF; and return
        string match -iqr '^Blue$'                "$argv[1]"; and echo 0000FF; and return
        string match -iqr '^MediumBlue$'          "$argv[1]"; and echo 0000CD; and return
        string match -iqr '^MidnightBlue$'        "$argv[1]"; and echo 191970; and return
        string match -iqr '^DarkBlue$'            "$argv[1]"; and echo 00008B; and return
        string match -iqr '^Navy$'                "$argv[1]"; and echo 000080; and return
        string match -iqr '^RoyalBlue$'           "$argv[1]"; and echo 4169E1; and return
        string match -iqr '^CornflowerBlue$'      "$argv[1]"; and echo 6495ED; and return
        string match -iqr '^LightSteelBlue$'      "$argv[1]"; and echo B0C4DE; and return
        string match -iqr '^LightSlateGr[ae]y$'   "$argv[1]"; and echo 778899; and return
        string match -iqr '^SlateGr[ae]y$'        "$argv[1]"; and echo 708090; and return
        string match -iqr '^DodgerBlue$'          "$argv[1]"; and echo 1E90FF; and return
        string match -iqr '^AliceBlue$'           "$argv[1]"; and echo F0F8FF; and return
        string match -iqr '^SteelBlue$'           "$argv[1]"; and echo 4682B4; and return
        string match -iqr '^LightSkyBlue$'        "$argv[1]"; and echo 87CEFA; and return
        string match -iqr '^SkyBlue$'             "$argv[1]"; and echo 87CEEB; and return
        string match -iqr '^DeepSkyBlue$'         "$argv[1]"; and echo 00BFFF; and return
        string match -iqr '^LightBlue$'           "$argv[1]"; and echo ADD8E6; and return
        string match -iqr '^PowderBlue$'          "$argv[1]"; and echo B0E0E6; and return
        string match -iqr '^CadetBlue$'           "$argv[1]"; and echo 5F9EA0; and return
        string match -iqr '^Azure$'               "$argv[1]"; and echo F0FFFF; and return
        string match -iqr '^LightCyan$'           "$argv[1]"; and echo E0FFFF; and return
        string match -iqr '^PaleTurquoise$'       "$argv[1]"; and echo AFEEEE; and return
        string match -iqr '^Cyan$'                "$argv[1]"; and echo 00FFFF; and return
        string match -iqr '^Aqua$'                "$argv[1]"; and echo 00FFFF; and return
        string match -iqr '^DarkTurquoise$'       "$argv[1]"; and echo 00CED1; and return
        string match -iqr '^DarkSlateGr[ae]y$'    "$argv[1]"; and echo 2F4F4F; and return
        string match -iqr '^DarkCyan$'            "$argv[1]"; and echo 008B8B; and return
        string match -iqr '^Teal$'                "$argv[1]"; and echo 008080; and return
        string match -iqr '^MediumTurquoise$'     "$argv[1]"; and echo 48D1CC; and return
        string match -iqr '^LightSeaGreen$'       "$argv[1]"; and echo 20B2AA; and return
        string match -iqr '^Turquoise$'           "$argv[1]"; and echo 40E0D0; and return
        string match -iqr '^Aquamarine$'          "$argv[1]"; and echo 7FFFD4; and return
        string match -iqr '^MediumAquamarine$'    "$argv[1]"; and echo 66CDAA; and return
        string match -iqr '^MediumSpringGreen$'   "$argv[1]"; and echo 00FA9A; and return
        string match -iqr '^MintCream$'           "$argv[1]"; and echo F5FFFA; and return
        string match -iqr '^SpringGreen$'         "$argv[1]"; and echo 00FF7F; and return
        string match -iqr '^MediumSeaGreen$'      "$argv[1]"; and echo 3CB371; and return
        string match -iqr '^SeaGreen$'            "$argv[1]"; and echo 2E8B57; and return
        string match -iqr '^Honeydew$'            "$argv[1]"; and echo F0FFF0; and return
        string match -iqr '^LightGreen$'          "$argv[1]"; and echo 90EE90; and return
        string match -iqr '^PaleGreen$'           "$argv[1]"; and echo 98FB98; and return
        string match -iqr '^DarkSeaGreen$'        "$argv[1]"; and echo 8FBC8F; and return
        string match -iqr '^LimeGreen$'           "$argv[1]"; and echo 32CD32; and return
        string match -iqr '^Lime$'                "$argv[1]"; and echo 00FF00; and return
        string match -iqr '^ForestGreen$'         "$argv[1]"; and echo 228B22; and return
        string match -iqr '^Green$'               "$argv[1]"; and echo 008000; and return
        string match -iqr '^DarkGreen$'           "$argv[1]"; and echo 006400; and return
        string match -iqr '^Chartreuse$'          "$argv[1]"; and echo 7FFF00; and return
        string match -iqr '^LawnGreen$'           "$argv[1]"; and echo 7CFC00; and return
        string match -iqr '^GreenYellow$'         "$argv[1]"; and echo ADFF2F; and return
        string match -iqr '^DarkOliveGreen$'      "$argv[1]"; and echo 556B2F; and return
        string match -iqr '^YellowGreen$'         "$argv[1]"; and echo 9ACD32; and return
        string match -iqr '^OliveDrab$'           "$argv[1]"; and echo 6B8E23; and return
        string match -iqr '^Beige$'               "$argv[1]"; and echo F5F5DC; and return
        string match -iqr '^LightGoldenrodYellow' "$argv[1]"; and echo FAFAD2; and return
        string match -iqr '^Ivory$'               "$argv[1]"; and echo FFFFF0; and return
        string match -iqr '^LightYellow$'         "$argv[1]"; and echo FFFFE0; and return
        string match -iqr '^Yellow$'              "$argv[1]"; and echo FFFF00; and return
        string match -iqr '^Olive$'               "$argv[1]"; and echo 808000; and return
        string match -iqr '^DarkKhaki$'           "$argv[1]"; and echo BDB76B; and return
        string match -iqr '^LemonChiffon$'        "$argv[1]"; and echo FFFACD; and return
        string match -iqr '^PaleGoldenrod$'       "$argv[1]"; and echo EEE8AA; and return
        string match -iqr '^Khaki$'               "$argv[1]"; and echo F0E68C; and return
        string match -iqr '^Gold$'                "$argv[1]"; and echo FFD700; and return
        string match -iqr '^Cornsilk$'            "$argv[1]"; and echo FFF8DC; and return
        string match -iqr '^Goldenrod$'           "$argv[1]"; and echo DAA520; and return
        string match -iqr '^DarkGoldenrod$'       "$argv[1]"; and echo B8860B; and return
        string match -iqr '^FloralWhite$'         "$argv[1]"; and echo FFFAF0; and return
        string match -iqr '^OldLace$'             "$argv[1]"; and echo FDF5E6; and return
        string match -iqr '^Wheat$'               "$argv[1]"; and echo F5DEB3; and return
        string match -iqr '^Moccasin$'            "$argv[1]"; and echo FFE4B5; and return
        string match -iqr '^Orange$'              "$argv[1]"; and echo FFA500; and return
        string match -iqr '^PapayaWhip$'          "$argv[1]"; and echo FFEFD5; and return
        string match -iqr '^BlanchedAlmond$'      "$argv[1]"; and echo FFEBCD; and return
        string match -iqr '^NavajoWhite$'         "$argv[1]"; and echo FFDEAD; and return
        string match -iqr '^AntiqueWhite$'        "$argv[1]"; and echo FAEBD7; and return
        string match -iqr '^Tan$'                 "$argv[1]"; and echo D2B48C; and return
        string match -iqr '^BurlyWood$'           "$argv[1]"; and echo DEB887; and return
        string match -iqr '^Bisque$'              "$argv[1]"; and echo FFE4C4; and return
        string match -iqr '^DarkOrange$'          "$argv[1]"; and echo FF8C00; and return
        string match -iqr '^Linen$'               "$argv[1]"; and echo FAF0E6; and return
        string match -iqr '^Peru$'                "$argv[1]"; and echo CD853F; and return
        string match -iqr '^PeachPuff$'           "$argv[1]"; and echo FFDAB9; and return
        string match -iqr '^SandyBrown$'          "$argv[1]"; and echo F4A460; and return
        string match -iqr '^Chocolate$'           "$argv[1]"; and echo D2691E; and return
        string match -iqr '^SaddleBrown$'         "$argv[1]"; and echo 8B4513; and return
        string match -iqr '^Seashell$'            "$argv[1]"; and echo FFF5EE; and return
        string match -iqr '^Sienna$'              "$argv[1]"; and echo A0522D; and return
        string match -iqr '^LightSalmon$'         "$argv[1]"; and echo FFA07A; and return
        string match -iqr '^Coral$'               "$argv[1]"; and echo FF7F50; and return
        string match -iqr '^OrangeRed$'           "$argv[1]"; and echo FF4500; and return
        string match -iqr '^DarkSalmon$'          "$argv[1]"; and echo E9967A; and return
        string match -iqr '^Tomato$'              "$argv[1]"; and echo FF6347; and return
        string match -iqr '^MistyRose$'           "$argv[1]"; and echo FFE4E1; and return
        string match -iqr '^Salmon$'              "$argv[1]"; and echo FA8072; and return
        string match -iqr '^Snow$'                "$argv[1]"; and echo FFFAFA; and return
        string match -iqr '^LightCoral$'          "$argv[1]"; and echo F08080; and return
        string match -iqr '^RosyBrown$'           "$argv[1]"; and echo BC8F8F; and return
        string match -iqr '^IndianRed$'           "$argv[1]"; and echo CD5C5C; and return
        string match -iqr '^Red$'                 "$argv[1]"; and echo FF0000; and return
        string match -iqr '^Brown$'               "$argv[1]"; and echo A52A2A; and return
        string match -iqr '^FireBrick$'           "$argv[1]"; and echo B22222; and return
        string match -iqr '^DarkRed$'             "$argv[1]"; and echo 8B0000; and return
        string match -iqr '^Maroon$'              "$argv[1]"; and echo 800000; and return
        string match -iqr '^White$'               "$argv[1]"; and echo FFFFFF; and return
        string match -iqr '^WhiteSmoke$'          "$argv[1]"; and echo F5F5F5; and return
        string match -iqr '^Gainsboro$'           "$argv[1]"; and echo DCDCDC; and return
        string match -iqr '^LightGr[ae]y$'        "$argv[1]"; and echo D3D3D3; and return
        string match -iqr '^Silver$'              "$argv[1]"; and echo C0C0C0; and return
        string match -iqr '^DarkGr[ae]y$'         "$argv[1]"; and echo A9A9A9; and return
        string match -iqr '^Gr[ae]y$'             "$argv[1]"; and echo 808080; and return
        string match -iqr '^DimGr[ae]y$'          "$argv[1]"; and echo 696969; and return
        string match -iqr '^Black$'               "$argv[1]"; and echo 000000; and return
        echo
    end

    # Make a temporally file
    set -l tmp (mktemp)

    # get the colorscheme information from vim
    vim $tmp -e\
     +'set nonumber'\
     +"colorscheme $scheme"\
     +'redir @a'\
     +'colorscheme'\
     +'highlight'\
     +'redir END'\
     +'put a'\
     +'wq!' >/dev/null
    
     if test "$status" != 0
        echo "vimcolor: unknown colorscheme '$scheme'" >/dev/stderr
        return 1
     end

    # Function to convert vim-colorscheme info into fish's one
    function __vimcolor_convert -V scope -V bkg_ignore -V tmp -a fish_group vim_group
        set -l to_eval ''
        while read -l line
            set -l attrs (string match -r "^$vim_group .*gui=(\w+(,\w+)*)" $line)
            set -l color (string match -r "^$vim_group .*guifg=#?(\w+)"    $line)
            set -l bkg   (string match -r "^$vim_group .*guibg=#?(\w+)"    $line)

            # foreground color
            if set -q color[2]
                set -l hex

                string match -qr '^[0-9a-fA-F]{6}$' $color[2]
                and set hex $color[2] 
                or set hex (__vimcolor_x11 $color[2])

                test -n "$hex"
                and set to_eval "$to_eval $hex"
                or echo "vimcolor: unknown background color '$color[2]' ($vim_group -> $fish_group)" >/dev/stderr
            end

            # background color
            if set -q bkg[2]

                # If fish_pager_color_completion has a background color,
                # the drowing for completion becoms strange.
                if not contains "$fish_group" $bkg_ignore
                    set -l hex

                    string match -qr '^[0-9a-fA-F]{6}$' $bkg[2]
                    and set hex $bkg[2]
                    or set hex (__vimcolor_x11 $bkg[2])

                    test -n "$hex"
                    and set to_eval "$to_eval --background=$hex"
                    or echo "vimcolor: unknown background color '$bkg[2]' ($vim_group -> $fish_group)" >/dev/stderr
                end
            end

            # attributes list
            if set -q attrs[2]
                set attrs (string split , $attrs[2])

                contains underline $attrs; and set to_eval "$to_eval --underline"
                contains bold      $attrs; and set to_eval "$to_eval --bold"
                contains italic    $attrs; and set to_eval "$to_eval --italics"
                contains reverse   $attrs; and set to_eval "$to_eval --reverse"
                contains inverse   $attrs; and set to_eval "$to_eval --reverse"
            end

            # execute set_color
            if string length -q $to_eval

                break
            end

            # links to another syntax group
            set -l link (string match -r "^$vim_group .*links to (\w+).*" $line)
            if test $status = 0
                __vimcolor_convert $fish_group $link[2]
                return
            end
        end <$tmp

        if isatty stdout
            echo -n (eval set_color $to_eval)
            echo "set$scope $fish_group $to_eval"(set_color normal)
        else
            echo "set$scope $fish_group $to_eval"
        end
        if test "$scope" = " -U"
            eval "set -e $fish_group"
        end
        eval "set$scope $fish_group $to_eval"
    end

    __vimcolor_convert fish_color_normal            Normal
    __vimcolor_convert fish_color_command           Statement
    __vimcolor_convert fish_color_quote             String
    __vimcolor_convert fish_color_redirection       Directory
    __vimcolor_convert fish_color_end               Delimiter
    __vimcolor_convert fish_color_error             Error
    __vimcolor_convert fish_color_param             Identifier
    __vimcolor_convert fish_color_comment           Comment
    __vimcolor_convert fish_color_match             MatchParen
    __vimcolor_convert fish_color_search_match      PmenuSel
    __vimcolor_convert fish_color_operator          Operator
    __vimcolor_convert fish_color_escape            SpecialChar
    __vimcolor_convert fish_color_autosuggestion    Comment
    __vimcolor_convert fish_color_valid_path        Underlined
    __vimcolor_convert fish_color_history_current   Directory
    __vimcolor_convert fish_color_selection         Visual
    __vimcolor_convert fish_pager_color_completion  Pmenu
    __vimcolor_convert fish_pager_color_prefix      Title
    __vimcolor_convert fish_pager_color_description SpecialComment
    __vimcolor_convert fish_pager_color_progress    MoreMsg

    # Remove the temporally file
    rm $tmp
end

