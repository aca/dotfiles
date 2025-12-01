glide.styles.add(css`

/*
* this theme is a modified version of Jarnot Maciej's essence theme:
* https://github.com/JarnotMaciej/Essence
*
* modified by yari :3
* woof woof woof arf awwwruffff etc etc etc.
*
*/

/* Just comment the lines or block for the elements you WANT to see */

/* Menu button */
#PanelUI-button {
  -moz-box-ordinal-group: 0 !important;
  order: -2 !important;
  margin: 2px !important;
  display: none !important;
}

/* Window control buttons (min, resize and close) */
.titlebar-buttonbox-container {
  display: none !important;
  margin-right: 12px !important;
}

/* Page back and foward buttons */
#back-button,
#forward-button
{
  display: none !important
}

/* Extensions button */
#unified-extensions-button {
    position: absolute !important;
    opacity: 0 !important;
  size: 1px !important;
}

/* Extension name inside URL bar */
#identity-box.extensionPage #identity-icon-label {
  visibility: collapse !important
}

/* All tabs (v-like) button */
#alltabs-button {
  display: none !important
}

/* URL bar icons */
#identity-permission-box,
#star-button-box,
#identity-icon-box,
#picture-in-picture-button,
#tracking-protection-icon-container,
#reader-mode-button,
#translations-button
{
  display: none !important
}

/* "This time search with:..." */
#urlbar .search-one-offs {
  display: none !important
}

/* --- ~END~ element visibility section --- */

/* Navbar size calc */
:root{
--3tab-border-radius: 6px !important; /*  Tab border radius -- Changes the tabs rounding  *//*  Default: 6px  */
--NavbarWidth: 43; /*  Default values: 36 - 43  */
--TabsHeight: 36; /*  Minimum: 30  *//*  Default: 36  */
--TabsBorder: 8; /*  Doesnt do anything on small layout  *//*  Default: 8  */
--NavbarHeightSmall: calc(var(--TabsHeight) + var(--TabsBorder))  /*  Only on small layout  *//*  Default: calc(var(--TabsHeight) + var(--TabsBorder))  *//*  Default as a number: 44  */}


@media screen and (min-width:1325px)    /*  Only the tabs space will grow from here  */
{:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px)!important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(1325px / 100 * var(--NavbarWidth)) !important} #nav-bar{margin-right: calc(100vw - calc(1325px / 100 * var(--NavbarWidth))) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important}}

@media screen and (min-width:950px) and (max-width:1324px)    /*  Both the tabs space and the navbar will grow  */
{:root #nav-bar{margin-top: calc(var(--TabsHeight) * -1px - var(--TabsBorder) * 1px) !important; height: calc(var(--TabsHeight) * 1px + var(--TabsBorder) * 1px)} #TabsToolbar{margin-left: calc(var(--NavbarWidth) * 1vw) !important} #nav-bar{margin-right: calc(100vw - calc(var(--NavbarWidth) * 1vw)) !important; vertical-align: center !important} #urlbar-container{min-width: 0px !important;  flex: auto !important} toolbarspring{display: none !important} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}

@media screen and (max-width:949px)    /*  The window is not enough wide for a one line layout */
{:root #nav-bar{padding: 0 5px 0 5px!important; height: calc(var(--NavbarHeightSmall) * 1px) !important} toolbarspring{display: none !important;} #TabsToolbar, #nav-bar{transition: margin-top .25s !important}}
#nav-bar, #PersonalToolbar{background-color: #0000 !important;background-image: none !important; box-shadow: none !important} #nav-bar{margin-left: 3px;} .tab-background, .tab-stack { min-height: calc(var(--TabsHeight) * 1px) !important}

/*  Removes urlbar border/background  */
#urlbar-background {
  border: none !important;
  outline: none !important;
  transition: .15s !important;
}

/*  Removes the background from the urlbar while not in use  */
#urlbar:not(:hover):not([breakout][breakout-extend]) {
    > #urlbar-background {
        box-shadow: none !important;
        background: #0000 !important;
    }
}

/*  Removes annoying border  */
#navigator-toolbox {
    border: none !important
}

/* Fades window while not in focus */
#navigator-toolbox-background:-moz-window-inactive {
  filter: contrast(90%)
}

/* Remove fullscreen warning border */
#fullscreen-warning {
  border: none !important;
  background: -moz-Dialog !important;
}



/* tabs */
.tabbrowser-tab:not(:hover):not([visuallyselected], [multiselected]) {
    transition: .5s !important;
    filter: opacity(50%) !important;
}

#TabsToolbar #firefox-view-button[open] > .toolbarbutton-icon, .tabbrowser-tab:is([visuallyselected], [multiselected]) {
    background: none !important;
    filter: none !important;
    & .tab-background {
        background: none !important;
        box-shadow: none !important;
        /*border-bottom: 2px solid AccentColor !important;*/
        border-bottom-right-radius: 0 !important;
        border-bottom-left-radius: 0 !important;
    }
}

.tabbrowser-tab:hover .tab-background {
    background: none !important;
}

/* remove gap after pinned tabs */
#tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
  > #tabbrowser-arrowscrollbox
  > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) { margin-inline-start: 0 !important; }


/* show favicon when media is playing but tab is hovered */
.tab-icon-image:not([pinned]) { opacity: 1 !important; }

/* Makes the speaker icon to always appear if the tab is playing (not only on hover) */
.tab-icon-overlay:not([crashed]),
.tab-icon-overlay[pinned][crashed][selected] {

  top: 5px !important;
  z-index: 1 !important;

  padding: 1.5px !important;
  inset-inline-end: -8px !important;
  width: 16px !important; height: 16px !important;

  border-radius: 10px !important;
} 

.tabbrowser-tab:not([image]) .tab-icon-overlay:not([pinned], [sharing], [crashed]) {

  top: 0 !important;

  padding: 0 !important;
  margin-inline-end: 5.5px !important;
  inset-inline-end: 0 !important;

}

/* style and position speaker icon */
.tab-icon-overlay:not([sharing], [crashed]):is([soundplaying], [muted], [activemedia-blocked]) {

  stroke: transparent !important;
  background: transparent !important;
  opacity: 1 !important; fill-opacity: 0.8 !important;

  color: currentColor !important;

  stroke: var(--toolbar-bgcolor) !important;
  background-color: var(--toolbar-bgcolor) !important;

  margin-right: 15px !important;
} 


/*  Tabs close button  */
.tabbrowser-tab:not(:hover) .tab-close-button {
    opacity: 0% !important;
    transition: 0.3s !important;
    display: -moz-box !important;
}
.tab-close-button[selected]:not(:hover) {
    opacity: 45% !important;
    transition: 0.3s !important;
    display: -moz-box !important;
    background: none !important;
}
.tabbrowser-tab:hover .tab-close-button {
    opacity: 50%;
    transition: 0.3s !important;
    background: none !important;
    cursor: pointer;
    display: -moz-box !important;
}
.tab-close-button:hover {
    opacity: 100% !important;
    transition: 0.3s !important;
    background: none !important;
    cursor: pointer;
    display: -moz-box !important;
}
.tab-close-button[selected]:hover {
    opacity: 100% !important;
    transition: 0.3s !important;
    background: none !important;
    cursor: pointer;
    display: -moz-box !important;
}
`)
