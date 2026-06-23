// glide.include("userChrome.ts")
glide.include("bottom.ts")

// From keymaps.mts
glide.keymaps.set(["normal", "insert", "visual"], "<A-t>", "mode_change ignore");
glide.keymaps.set("ignore", "<A-t>", "mode_change normal");
// Config docs:
//
//   https://glide-browser.app/config
//
// API reference:
//
//   https://glide-browser.app/api
//
// Default config files can be found here:
//
//   https://github.com/glide-browser/glide/tree/main/src/glide/browser/base/content/plugins
//
// Most default keymappings are defined here:
//
//   https://github.com/glide-browser/glide/blob/main/src/glide/browser/base/content/plugins/keymaps.mts
//
// Try typing `glide.` and see what you can do!

glide.g.mapleader = "<C-b>";

glide.addons.install("https://addons.mozilla.org/firefox/downloads/file/4598854/ublock_origin-1.68.0.xpi")



glide.keymaps.set("normal", "<leader>r", "config_reload");

// glide.prefs.set("general.useragent.override", "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/53736 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36");
glide.prefs.set("toolkit.legacyUserProfileCustomizations.stylesheets", true);
glide.prefs.set("devtools.debugger.prompt-connection", false);
glide.prefs.set("media.videocontrols.picture-in-picture.audio-toggle.enabled", true);
glide.prefs.set("browser.fullscreen.autohide", false);
glide.prefs.set("browser.download.autohideButton", false);
glide.prefs.set("media.hardware-video-decoding.force-enabled", true)
glide.prefs.set("browser.tabs.unloadOnLowMemory", true);
glide.prefs.set("browser.tabs.min_inactive_duration_before_unload", 100000);
glide.prefs.set("gfx.webrender.all", true);

glide.keymaps.set(["normal", "insert"], "W", function() { glide.tabs.unload(); });
glide.keymaps.set(["normal", "insert"], "<C-1>", "tab 0");
glide.keymaps.set(["normal", "insert"], "<C-2>", "tab 1");
glide.keymaps.set(["normal", "insert"], "<C-3>", "tab 2");
glide.keymaps.set(["normal", "insert"], "<C-4>", "tab 3");
glide.keymaps.set(["normal", "insert"], "<C-5>", "tab 4");
glide.keymaps.set(["normal", "insert"], "<C-6>", "tab 5");
glide.keymaps.set(["normal", "insert"], "<C-7>", "tab 6");
glide.keymaps.set(["normal", "insert"], "<C-8>", "tab 7");
glide.keymaps.set(["normal", "insert"], "<leader>x", "tab_close");
glide.keymaps.set(["normal", "insert"], "<C-j>", "tab_next");
glide.keymaps.set(["normal", "insert"], "<C-k>", "tab_prev");

glide.keymaps.set("normal", "]]", "tab_next");
glide.keymaps.set("normal", "[[", "tab_prev");
// glide.keymaps.set("normal", "]<Tab>", "tab_next");
// glide.keymaps.set("normal", "[<Tab>", "tab_prev");

glide.keymaps.set(["normal", "insert"], "<C-Backspace>", "back");

let lastDetached: { tabId: number; windowId: number; index: number } | null = null;
  // lastDetached = { tabId: tab.id, windowId: tab.windowId, index: tab.index };

glide.keymaps.set(["normal", "insert"], "W", async function() {
  const tab = await glide.tabs.active();
  const tabsInWindow = await browser.tabs.query({ windowId: tab.windowId });
  if (tabsInWindow.length <= 1) return;
  await browser.windows.create({ tabId: tab.id });
});

// if (glide.ctx.os === "macosx") {
//   glide.keymaps.set(["normal", "insert"], "<D-h>", "back");
//   glide.keymaps.set(["normal", "insert"], "<D-l>", "forward");
// } else {
//   // we don't use <C-l> on linux as it would conflict with a builtin keymap
//   glide.keymaps.set(["normal", "insert"], "<C-h>", "back");
//   glide.keymaps.set(["normal", "insert"], "<C-l>", "forward");
// }
// glide.keymaps.del(["normal", "insert"], "<C-l>");

// https://github.com/MrOtherGuy/firefox-csshacks/blob/master/chrome/numbered_tabs.css
glide.styles.add(css`
.tabbrowser-tab:first-child{ counter-reset: nth-tab 0 } /* Change to -1 for 0-indexing */
.tab-text::before{ content: counter(nth-tab) " "; counter-increment: nth-tab }
`)

// glide.autocmds.create("ConfigLoaded", async () => {
//   try {
//     const css_content = await glide.fs.read("userChrome.css", "utf8");
//     glide.styles.add(css_content);
//   } catch (err) {
//     console.warn("Could not load custom.css:", err);
//   }
// });


// const css = await glide.fs.read("userChrome.css", "utf8");
// glide.styles.add(css);
// if (await glide.fs.exists("userChrome.css")) {
//   const css = await glide.fs.read("userChrome.css", "utf8");
//   glide.styles.add(css);
// }
