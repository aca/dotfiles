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

glide.g.mapleader = "<Space>";

glide.keymaps.set("normal", "<leader>r", "config_reload");

glide.prefs.set("toolkit.legacyUserProfileCustomizations.stylesheets", true);
glide.prefs.set("devtools.debugger.prompt-connection", false);
glide.prefs.set("media.videocontrols.picture-in-picture.audio-toggle.enabled", true);


glide.keymaps.set("normal", "<leader>x", "tab_close");
glide.keymaps.set(["normal", "insert"], "<C-j>", "tab_next");
glide.keymaps.set(["normal", "insert"], "<C-k>", "tab_prev");

glide.keymaps.set(["normal", "insert"], "<C-Backspace>", "back");
// if (glide.ctx.os === "macosx") {
//   glide.keymaps.set(["normal", "insert"], "<D-h>", "back");
//   glide.keymaps.set(["normal", "insert"], "<D-l>", "forward");
// } else {
//   // we don't use <C-l> on linux as it would conflict with a builtin keymap
//   glide.keymaps.set(["normal", "insert"], "<C-h>", "back");
//   glide.keymaps.set(["normal", "insert"], "<C-l>", "forward");
// }
// glide.keymaps.del(["normal", "insert"], "<C-l>");
