
if(instance_exists(obj_ui_options) or STATE != PlayerState.Default) return;

LEFT = global.left
RIGHT = global.right
UP = global.up
DOWN = global.duck
JUMP = global.jump
DASH = global.dash
SUBMERGED = y > obj_acid.y + 32