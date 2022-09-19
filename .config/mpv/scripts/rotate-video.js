// ~/.config/mpv/script-opts/rotate-video.conf
var opts = {
  cache_file: mp.utils.getenv("HOME") + ".mpv_rotate_hisory.json",
};

mp.options.read_options(opts, "rotate-video");
var rotate_config = opts.cache_file;

var config = {};
try {
  var rotate_config = "/home/rok/.mpv_rotate_hisory.json";
  config = JSON.parse(mp.utils.read_file(rotate_config));
} catch (err) {
  mp.msg.warn(err);
}

function rotate() {
  mp.set_property("video-rotate", 0);
  var full_path = get_full_path();
  if (full_path in config) {
    mp.set_property("video-rotate", config[full_path]);
  }
}

function cycle_video_rotate(amt) {
  mp.set_property(
    "video-rotate",
    (mp.get_property_number("video-rotate") + Number(amt)) % 360
  );

  var full_path = get_full_path();
  var cur = mp.get_property_number("video-rotate");
  config[full_path] = cur;

  if (cur == 0) {
    delete config[full_path];
  }
}

function get_full_path() {
  return mp.utils.join_path(
    mp.get_property_native("working-directory"),
    mp.get_property_native("path")
  );
}

function save_config() {
  mp.utils.write_file("file://" + rotate_config, JSON.stringify(config));
}

mp.register_event("file-loaded", rotate);
mp.register_event("shutdown", save_config);
mp.register_script_message("Cycle_Video_Rotate", cycle_video_rotate);
