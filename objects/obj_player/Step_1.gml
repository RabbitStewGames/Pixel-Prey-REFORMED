
if(instance_exists(obj_ui_options) or STATE != PlayerState.Default) return;

LEFT = keyboard_check(global.options.keymap.left)
RIGHT = keyboard_check(global.options.keymap.right)
UP = keyboard_check(global.options.keymap.up)
DOWN = keyboard_check(global.options.keymap.duck)
JUMP = keyboard_check_pressed(global.options.keymap.jump)
DASH = keyboard_check_pressed(global.options.keymap.dash)
SUBMERGED = y > obj_acid.y + 32