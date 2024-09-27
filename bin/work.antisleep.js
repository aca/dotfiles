
// Move the mouse across the screen as a sine wave.
// var robot = require("@hurdlegroup/robotjs");

import robot from "@hurdlegroup/robotjs";

// while (true) {
//
// // Press enter.
// robot.keyTap("alt+tab");
//
// }
function sleep(ms) {
    Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, ms);
}

while (true) {
robot.keyTap('tab', 'command');
robot.keyTap('enter');
sleep(5000)
robot.moveMouse(1115, 483);
robot.mouseClick();

}
