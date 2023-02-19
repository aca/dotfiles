use platform

set-env SHELL "/bin/sh"
set-env LANG en_US.UTF-8
set-env LANGUAGE en_US.UTF-8
set-env LC_ALL en_US.UTF-8

# https://nixos.wiki/wiki/Locales
set-env LOCALE_ARCHIVE /usr/lib/locale/locale-archive

# if (not (has-env HOSTNAME)) { set-env HOSTNAME (platform:hostname &strip-domain=$false) }
    
# if (eq $platform:os "linux") {
#     if (and (not (has-env WAYLAND_DISPLAY)) (not (has-env DISPLAY))) {
#         if ?(pgrep sway >/dev/null) { set-env WAYLAND_DISPLAY "wayland-1" }
#     }
# }

# this should be set by terminal emulator(e.g. alacritty) or tmux
# xterm-color is for SSH session
if (not (has-env TERM)) {
  set-env TERM xterm-color
}

set-env PYTHONSTARTUP ~/.bin/pythonstartup
set-env XDG_CONFIG_HOME ~/.config

set-env NCDU_SHELL elvish

# if (eq $E:HOSTNAME "rok-te3") {
#   set E:LIBVIRT_DEFAULT_URI = "qemu:///system"
#   set E:VIRSH_DEFAULT_CONNECT_URI = "qemu:///system"
# } else {
#   set E:LIBVIRT_DEFAULT_URI = "qemu+ssh://rok@aca/system"
#   set E:VIRSH_DEFAULT_CONNECT_URI = "qemu+ssh://rok@aca/system"
# }

# vivid generate molokai
set-env LS_COLORS 'ca=0:do=0;38;2;0;0;0;48;2;249;38;114:st=0:tw=0:mh=0:sg=0:so=0;38;2;0;0;0;48;2;249;38;114:cd=0;38;2;249;38;114;48;2;51;51;51:no=0:mi=0;38;2;0;0;0;48;2;255;74;68:fi=0:or=0;38;2;0;0;0;48;2;255;74;68:pi=0;38;2;0;0;0;48;2;102;217;239:su=0:bd=0;38;2;102;217;239;48;2;51;51;51:ln=0;38;2;249;38;114:ex=1;38;2;249;38;114:ow=0:di=0;38;2;102;217;239:*~=0;38;2;122;112;112:rs=0:*.z=4;38;2;249;38;114:*.r=0;38;2;0;255;135:*.a=1;38;2;249;38;114:*.d=0;38;2;0;255;135:*.c=0;38;2;0;255;135:*.p=0;38;2;0;255;135:*.h=0;38;2;0;255;135:*.o=0;38;2;122;112;112:*.m=0;38;2;0;255;135:*.t=0;38;2;0;255;135:*.rs=0;38;2;0;255;135:*.el=0;38;2;0;255;135:*.sh=0;38;2;0;255;135:*.jl=0;38;2;0;255;135:*css=0;38;2;0;255;135:*.ts=0;38;2;0;255;135:*.lo=0;38;2;122;112;112:*.di=0;38;2;0;255;135:*.as=0;38;2;0;255;135:*.bz=4;38;2;249;38;114:*.gz=4;38;2;249;38;114:*.wv=0;38;2;253;151;31:*.mn=0;38;2;0;255;135:*.ml=0;38;2;0;255;135:*.gv=0;38;2;0;255;135:*.cp=0;38;2;0;255;135:*.cc=0;38;2;0;255;135:*.la=0;38;2;122;112;112:*.xz=4;38;2;249;38;114:*.td=0;38;2;0;255;135:*.cr=0;38;2;0;255;135:*.hh=0;38;2;0;255;135:*.ps=0;38;2;230;219;116:*.so=1;38;2;249;38;114:*.rm=0;38;2;253;151;31:*.bc=0;38;2;122;112;112:*.ll=0;38;2;0;255;135:*.hs=0;38;2;0;255;135:*.fs=0;38;2;0;255;135:*.cs=0;38;2;0;255;135:*.ko=1;38;2;249;38;114:*.7z=4;38;2;249;38;114:*.py=0;38;2;0;255;135:*.go=0;38;2;0;255;135:*.ex=0;38;2;0;255;135:*.pl=0;38;2;0;255;135:*.kt=0;38;2;0;255;135:*.ui=0;38;2;166;226;46:*.vb=0;38;2;0;255;135:*.rb=0;38;2;0;255;135:*.nb=0;38;2;0;255;135:*.hi=0;38;2;122;112;112:*.pm=0;38;2;0;255;135:*.md=0;38;2;226;209;57:*.js=0;38;2;0;255;135:*.pp=0;38;2;0;255;135:*.cxx=0;38;2;0;255;135:*.mov=0;38;2;253;151;31:*.blg=0;38;2;122;112;112:*.sxw=0;38;2;230;219;116:*.m4a=0;38;2;253;151;31:*.tgz=4;38;2;249;38;114:*.pyc=0;38;2;122;112;112:*.sty=0;38;2;122;112;112:*.bin=4;38;2;249;38;114:*.png=0;38;2;253;151;31:*.epp=0;38;2;0;255;135:*.bbl=0;38;2;122;112;112:*.exs=0;38;2;0;255;135:*.swf=0;38;2;253;151;31:*.ps1=0;38;2;0;255;135:*.mpg=0;38;2;253;151;31:*.dmg=4;38;2;249;38;114:*.csv=0;38;2;226;209;57:*.bag=4;38;2;249;38;114:*.def=0;38;2;0;255;135:*.odt=0;38;2;230;219;116:*.pas=0;38;2;0;255;135:*.rst=0;38;2;226;209;57:*.csx=0;38;2;0;255;135:*.ics=0;38;2;230;219;116:*.out=0;38;2;122;112;112:*.vim=0;38;2;0;255;135:*.pdf=0;38;2;230;219;116:*.dpr=0;38;2;0;255;135:*.dot=0;38;2;0;255;135:*.bat=1;38;2;249;38;114:*.arj=4;38;2;249;38;114:*.rpm=4;38;2;249;38;114:*.tmp=0;38;2;122;112;112:*.otf=0;38;2;253;151;31:*.bak=0;38;2;122;112;112:*.mp3=0;38;2;253;151;31:*.deb=4;38;2;249;38;114:*.bz2=4;38;2;249;38;114:*.rar=4;38;2;249;38;114:*.zip=4;38;2;249;38;114:*.zst=4;38;2;249;38;114:*.pro=0;38;2;166;226;46:*.jar=4;38;2;249;38;114:*hgrc=0;38;2;166;226;46:*.ppt=0;38;2;230;219;116:*.mir=0;38;2;0;255;135:*.gvy=0;38;2;0;255;135:*.txt=0;38;2;226;209;57:*.clj=0;38;2;0;255;135:*.dox=0;38;2;166;226;46:*.fls=0;38;2;122;112;112:*.cfg=0;38;2;166;226;46:*TODO=1:*.wmv=0;38;2;253;151;31:*.pod=0;38;2;0;255;135:*.apk=4;38;2;249;38;114:*.ini=0;38;2;166;226;46:*.erl=0;38;2;0;255;135:*.ilg=0;38;2;122;112;112:*.lua=0;38;2;0;255;135:*.img=4;38;2;249;38;114:*.tif=0;38;2;253;151;31:*.git=0;38;2;122;112;112:*.tbz=4;38;2;249;38;114:*.pyd=0;38;2;122;112;112:*.svg=0;38;2;253;151;31:*.fon=0;38;2;253;151;31:*.aif=0;38;2;253;151;31:*.tex=0;38;2;0;255;135:*.flv=0;38;2;253;151;31:*.c++=0;38;2;0;255;135:*.pyo=0;38;2;122;112;112:*.sql=0;38;2;0;255;135:*.kts=0;38;2;0;255;135:*.cpp=0;38;2;0;255;135:*.htm=0;38;2;226;209;57:*.asa=0;38;2;0;255;135:*.h++=0;38;2;0;255;135:*.ttf=0;38;2;253;151;31:*.psd=0;38;2;253;151;31:*.php=0;38;2;0;255;135:*.avi=0;38;2;253;151;31:*.pps=0;38;2;230;219;116:*.ico=0;38;2;253;151;31:*.idx=0;38;2;122;112;112:*.odp=0;38;2;230;219;116:*.elm=0;38;2;0;255;135:*.ltx=0;38;2;0;255;135:*.vcd=4;38;2;249;38;114:*.eps=0;38;2;253;151;31:*.xmp=0;38;2;166;226;46:*.zsh=0;38;2;0;255;135:*.wma=0;38;2;253;151;31:*.kex=0;38;2;230;219;116:*.dll=1;38;2;249;38;114:*.xls=0;38;2;230;219;116:*.hxx=0;38;2;0;255;135:*.sxi=0;38;2;230;219;116:*.hpp=0;38;2;0;255;135:*.mli=0;38;2;0;255;135:*.vob=0;38;2;253;151;31:*.pkg=4;38;2;249;38;114:*.fnt=0;38;2;253;151;31:*.yml=0;38;2;166;226;46:*.rtf=0;38;2;230;219;116:*.pid=0;38;2;122;112;112:*.exe=1;38;2;249;38;114:*.iso=4;38;2;249;38;114:*.tar=4;38;2;249;38;114:*.bsh=0;38;2;0;255;135:*.bmp=0;38;2;253;151;31:*.cgi=0;38;2;0;255;135:*.bst=0;38;2;166;226;46:*.awk=0;38;2;0;255;135:*.doc=0;38;2;230;219;116:*.inc=0;38;2;0;255;135:*.ods=0;38;2;230;219;116:*.xml=0;38;2;226;209;57:*.mid=0;38;2;253;151;31:*.tml=0;38;2;166;226;46:*.aux=0;38;2;122;112;112:*.ind=0;38;2;122;112;112:*.log=0;38;2;122;112;112:*.ogg=0;38;2;253;151;31:*.toc=0;38;2;122;112;112:*.fsi=0;38;2;0;255;135:*.fsx=0;38;2;0;255;135:*.mkv=0;38;2;253;151;31:*.xcf=0;38;2;253;151;31:*.com=1;38;2;249;38;114:*.inl=0;38;2;0;255;135:*.tsx=0;38;2;0;255;135:*.swp=0;38;2;122;112;112:*.sbt=0;38;2;0;255;135:*.m4v=0;38;2;253;151;31:*.mp4=0;38;2;253;151;31:*.gif=0;38;2;253;151;31:*.pbm=0;38;2;253;151;31:*.ppm=0;38;2;253;151;31:*.ipp=0;38;2;0;255;135:*.pgm=0;38;2;253;151;31:*.htc=0;38;2;0;255;135:*.jpg=0;38;2;253;151;31:*.wav=0;38;2;253;151;31:*.bcf=0;38;2;122;112;112:*.tcl=0;38;2;0;255;135:*.xlr=0;38;2;230;219;116:*.nix=0;38;2;166;226;46:*.bib=0;38;2;166;226;46:*.purs=0;38;2;0;255;135:*.hgrc=0;38;2;166;226;46:*.webm=0;38;2;253;151;31:*.tiff=0;38;2;253;151;31:*.bash=0;38;2;0;255;135:*.make=0;38;2;166;226;46:*.dart=0;38;2;0;255;135:*.fish=0;38;2;0;255;135:*.flac=0;38;2;253;151;31:*.lisp=0;38;2;0;255;135:*.h264=0;38;2;253;151;31:*.jpeg=0;38;2;253;151;31:*.docx=0;38;2;230;219;116:*.less=0;38;2;0;255;135:*.lock=0;38;2;122;112;112:*.epub=0;38;2;230;219;116:*.toml=0;38;2;166;226;46:*.pptx=0;38;2;230;219;116:*.opus=0;38;2;253;151;31:*.html=0;38;2;226;209;57:*.rlib=0;38;2;122;112;112:*.conf=0;38;2;166;226;46:*.tbz2=4;38;2;249;38;114:*.orig=0;38;2;122;112;112:*.mpeg=0;38;2;253;151;31:*.xlsx=0;38;2;230;219;116:*.java=0;38;2;0;255;135:*.json=0;38;2;166;226;46:*.psd1=0;38;2;0;255;135:*.yaml=0;38;2;166;226;46:*.diff=0;38;2;0;255;135:*.psm1=0;38;2;0;255;135:*README=0;38;2;0;0;0;48;2;230;219;116:*shadow=0;38;2;166;226;46:*.scala=0;38;2;0;255;135:*.cmake=0;38;2;166;226;46:*.swift=0;38;2;0;255;135:*.cabal=0;38;2;0;255;135:*.patch=0;38;2;0;255;135:*.xhtml=0;38;2;226;209;57:*.mdown=0;38;2;226;209;57:*.ipynb=0;38;2;0;255;135:*.toast=4;38;2;249;38;114:*.cache=0;38;2;122;112;112:*.shtml=0;38;2;226;209;57:*.dyn_o=0;38;2;122;112;112:*.class=0;38;2;122;112;112:*passwd=0;38;2;166;226;46:*.matlab=0;38;2;0;255;135:*.groovy=0;38;2;0;255;135:*.dyn_hi=0;38;2;122;112;112:*TODO.md=1:*.ignore=0;38;2;166;226;46:*.flake8=0;38;2;166;226;46:*.gradle=0;38;2;0;255;135:*COPYING=0;38;2;182;182;182:*INSTALL=0;38;2;0;0;0;48;2;230;219;116:*LICENSE=0;38;2;182;182;182:*.config=0;38;2;166;226;46:*.desktop=0;38;2;166;226;46:*setup.py=0;38;2;166;226;46:*Doxyfile=0;38;2;166;226;46:*.gemspec=0;38;2;166;226;46:*Makefile=0;38;2;166;226;46:*TODO.txt=1:*COPYRIGHT=0;38;2;182;182;182:*.cmake.in=0;38;2;166;226;46:*.DS_Store=0;38;2;122;112;112:*.rgignore=0;38;2;166;226;46:*.markdown=0;38;2;226;209;57:*.fdignore=0;38;2;166;226;46:*configure=0;38;2;166;226;46:*README.md=0;38;2;0;0;0;48;2;230;219;116:*.kdevelop=0;38;2;166;226;46:*README.txt=0;38;2;0;0;0;48;2;230;219;116:*.scons_opt=0;38;2;122;112;112:*SConscript=0;38;2;166;226;46:*Dockerfile=0;38;2;166;226;46:*CODEOWNERS=0;38;2;166;226;46:*.localized=0;38;2;122;112;112:*SConstruct=0;38;2;166;226;46:*.gitignore=0;38;2;166;226;46:*.gitconfig=0;38;2;166;226;46:*INSTALL.md=0;38;2;0;0;0;48;2;230;219;116:*.travis.yml=0;38;2;230;219;116:*Makefile.am=0;38;2;166;226;46:*LICENSE-MIT=0;38;2;182;182;182:*.synctex.gz=0;38;2;122;112;112:*.gitmodules=0;38;2;166;226;46:*INSTALL.txt=0;38;2;0;0;0;48;2;230;219;116:*MANIFEST.in=0;38;2;166;226;46:*Makefile.in=0;38;2;122;112;112:*.fdb_latexmk=0;38;2;122;112;112:*CONTRIBUTORS=0;38;2;0;0;0;48;2;230;219;116:*configure.ac=0;38;2;166;226;46:*.applescript=0;38;2;0;255;135:*appveyor.yml=0;38;2;230;219;116:*.clang-format=0;38;2;166;226;46:*.gitattributes=0;38;2;166;226;46:*CMakeCache.txt=0;38;2;122;112;112:*CMakeLists.txt=0;38;2;166;226;46:*LICENSE-APACHE=0;38;2;182;182;182:*CONTRIBUTORS.md=0;38;2;0;0;0;48;2;230;219;116:*CONTRIBUTORS.txt=0;38;2;0;0;0;48;2;230;219;116:*.sconsign.dblite=0;38;2;122;112;112:*requirements.txt=0;38;2;166;226;46:*package-lock.json=0;38;2;122;112;112:*.CFUserTextEncoding=0;38;2;122;112;112'

# set E:EXA_COLORS = ""
# set E:EXA_ICON_SPACING = 2

set-env GKSwstype "iterm"
set-env MPLBACKEND "module://itermplot"

if (eq $platform:os "linux") {
  set-env XMODIFIERS "@im=fcitx"
  set-env GTK_IM_MODULE fcitx
  set-env QT_IM_MODULE fcitx
  set-env SDL_IM_MODULE fcitx
  set-env GLFW_IM_MODULE fcitx
  set-env BROWSER google-chrome-stable
} else {
  set-env BROWSER google-chrome
}

set-env ASDF_DIR $E:HOME/.asdf
set-env GHQ_ROOT $E:HOME/src
set-env MANPAGER 'nvim +Man!'
set-env MANWIDTH '88'

set-env RIPGREP_CONFIG_PATH $E:HOME/.ripgreprc
set-env COLORTERM truecolor
set-env EDITOR nvim
set-env VISUAL nvim
set-env GOPATH $E:HOME
# set-env GOPROXY direct

# node
# set-env NODE_OPTIONS "--experimental-fetch --experimental-top-level-await --experimental-modules --no-warnings"
set-env NPM_CONFIG_GLOBALCONFIG $E:HOME/.npmrc.global

set-env MAN_DISABLE_SECCOMP 1 # man page issues

set-env FZF_DEFAULT_COMMAND 'fd -L --hidden --type f'
set-env FZF_DEFAULT_OPTS '--min-height 15 --reverse --color "gutter:-1" --info=inline --no-scrollbar --no-separator --cycle -m --bind ctrl-a:toggle-all --bind ctrl-n:down --bind ctrl-p:up --bind ctrl-w:toggle-preview --prompt "» " --preview "bat {}" --preview-window "hidden"'
set-env FZF_CTRL_T_COMMAND 'fd -L --hidden'
set-env FZF_ALT_C_COMMAND 'fd --hidden --type d --max-depth 10 --no-ignore'



# https://github.com/zzamboni/elvish-modules/blob/master/nix.org

set paths = [
  # ~/on/rakudo-star-*[nomatch-ok]/install/{bin,share/perl6/site/bin}
  # ~/.gem/ruby/*[nomatch-ok]/bin
  # ~/.bun/bin

  ~/xxx/bin
  ~/.bin
  ~/.bin/dev
  ~/.bin/lib
  ~/.bin/v
  ~/.bin/installations
  ~/.bin/abbr
  ~/.bin/$platform:os

  ~/bin

  ~/.cargo/bin
  ~/.local/bin
  # ~/.nix-profile/bin
  ~/.krew/bin
  # ~/.raku/bin
  /usr/local/bin

  /opt/homebrew/bin
  /opt/homebrew/sbin
  ~/.local/share/JetBrains/Toolbox/scripts

  $@paths
]

