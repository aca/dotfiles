glide.styles.add(css`
:root {
  --window-controls-width: 83px;
  --toolbar-bgcolor: #0a0a0a !important;
  --toolbar-color: #b0b0b0 !important;
  --tab-selected-textcolor: #e0e0e0 !important;
  --lwt-text-color: #b0b0b0 !important;
  --lwt-accent-color: #0a0a0a !important;
  --chrome-content-separator-color: #1a1a1a !important;
  --urlbar-box-bgcolor: #141414 !important;
  --urlbar-box-hover-bgcolor: #1e1e1e !important;
  --urlbar-box-active-bgcolor: #1e1e1e !important;
  --toolbarbutton-hover-background: #1e1e1e !important;
  --toolbarbutton-active-background: #252525 !important;
}

/* moving tabs bar down  */
:root:not([inDOMFullscreen]) #browser,
:root:not([inDOMFullscreen]) #customization-container {
  margin-bottom: calc(var(--tab-min-height) + var(--tab-block-margin)*2);
}
#TabsToolbar {
  margin-bottom: calc(-1 * var(--tab-min-height) - var(--tab-block-margin)*2);
  transform: translateY(calc(100vh - var(--tab-min-height) - var(--tab-block-margin)*2));
  background: #0a0a0a !important;
}
/* dark tab styling */
.tabbrowser-tab .tab-background {
  background: #0a0a0a !important;
}
.tabbrowser-tab:hover .tab-background {
  background: #1a1a1a !important;
}
.tabbrowser-tab .tab-label {
  color: #c0c0c0 !important;
  font-size: 0.8rem !important;
}
.tabbrowser-tab:hover .tab-label {
  color: #a0a0a0 !important;
}
.tabbrowser-tab[selected] .tab-label {
  color: #e0e0e0 !important;
}
#TabsToolbar .titlebar-spacer {
  width: 3px !important;
}
.titlebar-spacer {
  display: none !important;
}
#navigator-toolbox {
  border: none !important;
}
.browser-titlebar {
  opacity: 1 !important;
}
#nav-bar-customization-target,
#TabsToolbar-customization-target,
#PanelUI-button,
.urlbar-input-container {
  :root[tabsintitlebar] & {
    &:-moz-window-inactive {
      opacity: var(--inactive-titlebar-opacity);
    }
  }
}

/* browser toolbar: reserve space for window control buttons (mac) */
/* :root:not([inFullscreen]) #nav-bar-customization-target {
  margin-left: var(--window-controls-width);
} */

/* hide window control buttons (not needed on linux) */
.titlebar-buttonbox-container {
  display: none !important;
}

/* compact nav bar */
#nav-bar {
  --toolbar-start-end-padding: 0px !important;
  padding-left: 0 !important;
  margin-left: 0 !important;
  margin-top: -2px !important;
  margin-bottom: -2px !important;
  background: #0a0a0a !important;
  border: none !important;
}
/* dark urlbar */
.urlbar-background {
  background: #141414 !important;
  border: 1px solid #252525 !important;
  box-shadow: none !important;
  outline: none !important;
}
#urlbar[focused] .urlbar-background,
#urlbar:hover .urlbar-background,
#urlbar[open] .urlbar-background {
  border-color: #252525 !important;
  box-shadow: none !important;
  outline: none !important;
}
#urlbar .urlbar-input {
  color: #c0c0c0 !important;
  font-size: 0.85rem !important;
}
/* smaller font for nav bar */
#nav-bar {
  font-size: 0.85rem !important;
}
#nav-bar toolbarbutton {
  font-size: 0.85rem !important;
}
#nav-bar .toolbarbutton-icon {
  width: 14px !important;
  height: 14px !important;
}
#nav-bar .urlbar-icon {
  width: 14px !important;
  height: 14px !important;
}
#urlbar-container {
  --urlbar-container-height: 30px !important;
  flex: 1 !important;
  max-width: none !important;
  width: 100% !important;
}
#urlbar {
  --urlbar-height: 24px !important;
  --urlbar-toolbar-height: 30px !important;
  max-width: 100% !important;
}
#nav-bar-customization-target {
  padding-left: 0 !important;
  margin-left: 0 !important;
  display: flex !important;
  flex: 1 !important;
}
/* hide elements causing left space */
#taskbar-tabs-favicon,
#customizableui-special-spring1,
#vertical-spacer {
  display: none !important;
}
toolbartabstop {
  display: none !important;
}

/* move glide mode button to far right */
#glide-toolbar-mode-button {
  order: 1000 !important;
}
#downloads-button {
  order: 999 !important;
}
/* remove gaps between toolbar buttons */
#nav-bar-customization-target > :not(#urlbar-container) {
  margin-inline: 0 !important;
  padding-inline: 0 !important;
}

/* hide bookmark button */
#star-button-box,
#bookmarks-menu-button {
  display: none !important;
}

/* hide search engine switcher */
#urlbar-searchmode-switcher {
  display: none !important;
}

/* hide navigation buttons */
#back-button,
#forward-button,
#stop-reload-button {
  display: none !important;
}

/* hide tab close button while not hovered */
.tabbrowser-tab:not(:hover) .tab-close-button {
  display: none;
}

/* highlight current tab */
.tabbrowser-tab[selected] .tab-background {
  background: #1a1a1a !important;
  border-bottom: 2px solid #404040 !important;
}


/* ! Purely stylistic choices below, feel free to remove */

/* compact tabs */
:root:not([inDOMFullscreen]) #browser,
:root:not([inDOMFullscreen]) #customization-container {
  --tab-block-margin: 0px;
}
.tabbrowser-tab {
  padding: 0 !important;
}
#TabsToolbar {
  --tab-border-radius: 0px;
  --tab-block-margin: 0px;
}
#TabsToolbar .tab-close-button {
  --tab-border-radius: 4px;
}
#tabs-newtab-button,
#new-tab-button {
  padding: 0 !important;
}
#TabsToolbar-customization-target,
#tabbrowser-arrowscrollbox,
#pinned-tabs-container {
  height: var(--tab-min-height);
}
#TabsToolbar .titlebar-spacer {
  display: none;
}
.tab-context-line {
  transform: translateY(var(--tab-min-height));
  border-bottom-right-radius: 0 !important;
  border-bottom-left-radius: 0 !important;
}
#scrollbutton-up,
#scrollbutton-down {
  border: 0 !important;
  border-radius: 0 !important;
  padding-left: calc(var(--toolbarbutton-inner-padding) - 2px) !important;
  padding-right: calc(var(--toolbarbutton-inner-padding) - 2px) !important;
}

/* hide List All Tabs button */
#alltabs-button {
  display: none;
}

/* show borders between browsing window and toolbars */
#browser {
  border-block: 0.01px solid #1a1a1a;
}
/* dark bookmarks bar */
#PersonalToolbar {
  background: #0a0a0a !important;
}
#PlacesToolbarItems .bookmark-item {
  color: #808080 !important;
}
#PlacesToolbarItems .bookmark-item:hover {
  color: #c0c0c0 !important;
  background: #1a1a1a !important;
}

/* bookmarks toolbar separator color */
#PersonalToolbar toolbarseparator {
  opacity: .35;
}
`)
