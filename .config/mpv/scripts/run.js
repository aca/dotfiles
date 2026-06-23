function get_full_path() {
  return mp.utils.join_path(
    mp.get_property_native("working-directory"),
    mp.get_property_native("path")
  );
}

mp.register_script_message("run", function() {
  var args = [];
  for (var i = 0; i < arguments.length; i++) {
    args.push(arguments[i]);
  }
  args.push(get_full_path());
  mp.osd_message("run: " + args.join(" "));
  mp.command_native_async({
    name: "subprocess",
    args: args,
    playback_only: false,
  }, function(success, result, error) {
    if (error) {
      mp.osd_message("run error: " + error);
    }
  });
});
