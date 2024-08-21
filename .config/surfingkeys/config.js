// mappings
// https://github.com/brookhong/Surfingkeys/blob/master/pages/default.js
const {
    aceVimMap,
    mapkey,
    iunmap,
    imap,
    imapkey,
    getClickableElements,
    vmapkey,
    map,
    unmap,
    vunmap,
    cmap,
    addSearchAlias,
    removeSearchAlias,
    tabOpenLink,
    readText,
    Clipboard,
    Front,
    Hints,
    Visual,
    RUNTIME
} = api;




// settings.smoothScroll = true;
// settings.scrollStepSize = 140;
// settings.blacklistPattern = /localhost|127.0.0.1|.*docs.google.com.*|.*resumedraft.action.*/i;
// settings.blacklistPattern = /.*codesandbox.*|.*docs.google.com.*|.*resumedraft.action.*/i;

// unmap("'");
// unmap("w");
// unmap("b");
// unmap("r");
// unmap("x");
// unmap("X");
// // iunmap(";");
// unmap("<Alt-b>");
// unmap("<Alt-d>");
// unmap("<Alt-f>");
// unmap("<Alt-w>");
// unmap("<Ctrl-,>");
// unmap("<Ctrl-.>");
// unmap("<Ctrl-6>");
// unmap("<Ctrl-D>");
// unmap("<Ctrl-'>");
// unmap("<Ctrl-c>");
// unmap("<Ctrl-d>");
// unmap("<Ctrl-e>");
// unmap("<Ctrl-i>");
// unmap("<Ctrl-m>");
// unmap("<Ctrl-n>");
// unmap("<Ctrl-p>");
// unmap("<Ctrl-u>");
// unmap("I");
// unmap("i");
// unmap("m");
//
// map('<Meta-l>', 't'); // override address bar (win/mac)
// map('bf', 'gf');
// map('<Ctrl-[>', 'S');
// map('<Ctrl-]>', 'D');
//
// -----------------------------------
//
// ---- Hints ----
// Hints have to be defined separately
// Uncomment to enable

settings.theme = `
.sk_theme {
  font-family: SauceCodePro Nerd Font, Consolas, Menlo, monospace;
  font-size: 10pt;
  background: #f0edec;
  color: #2c363c;
}
.sk_theme tbody {
  color: #f0edec;
}
.sk_theme input {
  color: #2c363c;
}
.sk_theme .url {
  color: #1d5573;
}
.sk_theme .annotation {
  color: #2c363c;
}
.sk_theme .omnibar_highlight {
  color: #88507d;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: #f0edec;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: #cbd9e3;
}

#sk_omnibarSearchArea > span.prompt {
    margin-bottom: 2rem;
}

#sk_status,
#sk_find {
  font-size: 10pt;
}
`;

const hintsCss =
  "font-size: 10pt; font-family: SauceCodePro Nerd Font, Consolas, Menlo, monospace; border: 0px; color:#2c363c; background: initial; background-color: #f0edec;";

api.Hints.style(hintsCss);
api.Hints.style(hintsCss, "text");
