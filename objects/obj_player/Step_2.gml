if(instance_exists(obj_ui_options)  or STATE != PlayerState.Default) return;

X_OLD = x
Y_OLD = y
GROUNDED_OLD = GROUNDED
SUBMERGED_OLD = SUBMERGED
DOWN_OLD = DOWN
LEFT_OLD = LEFT
RIGHT_OLD = RIGHT

if(keyboard_check_pressed(vk_escape) and !instance_exists(obj_ui_options))
{
	instance_create_depth(0,0,-9999, obj_ui_options)	
}