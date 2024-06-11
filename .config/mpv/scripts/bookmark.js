function get_cache_filename(cache) {
  return mp.utils.getenv("HOME") + "/.xcache/mpv/bookmark_" + cache +  ".json"
}

function get_full_path() {
  return mp.utils.join_path(
    mp.get_property_native("working-directory"),
    mp.get_property_native("path")
  );
}

function open(cache_name) {
    mp.msg.warn("bookmark open a");
    var config = {}
    var fname = get_cache_filename(cache_name)
    try {
      config = JSON.parse(mp.utils.read_file(fname));
    } catch (err) {
      mp.msg.warn(err);
      mp.utils.write_file("file://" + fname, "{}");
    }

    var keys = Object.keys(config)
    shuffleArray(keys)
    for(var k in keys) {
        if (k == 0) {
            mp.commandv("loadfile", keys[k])
        } else {
            mp.commandv("loadfile", keys[k], "append")
        }
    }
}

/* Randomize array in-place using Durstenfeld shuffle algorithm */
function shuffleArray(array) {
    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}

function unmark(cache_name) {
    var config = {}
    var fname = get_cache_filename(cache_name)
    try {
      config = JSON.parse(mp.utils.read_file(fname));
    } catch (err) {
      mp.msg.warn(err);
      mp.utils.write_file("file://" + fname, "{}");
    }
    var full_path = get_full_path();
    delete config[full_path]
    mp.utils.write_file("file://" + fname, JSON.stringify(config));
}

function mark(cache_name) {
    mp.msg.warn("bookmark save a");
    var config = {}
    var fname = get_cache_filename(cache_name)
    try {
      config = JSON.parse(mp.utils.read_file(fname));
    } catch (err) {
      mp.msg.warn(err);
      mp.utils.write_file("file://" + fname, "{}");
    }
    var full_path = get_full_path();
    config[full_path] = ""
    mp.utils.write_file("file://" + fname, JSON.stringify(config));
}


function save_config() {
  mp.utils.write_file("file://" + rotate_config, JSON.stringify(config));
}

mp.register_script_message("bookmark-mark", mark);
mp.register_script_message("bookmark-open", open);
mp.register_script_message("bookmark-unmark", unmark);
