global.left = keyboard_check(vk_left) or keyboard_check(ord("A")) or gamepad_axis_value(0, gp_axislh) <= -.5
global.right = keyboard_check(vk_right) or keyboard_check(ord("D")) or gamepad_axis_value(0,gp_axislh) >= .5
global.up = keyboard_check(vk_up) or keyboard_check(ord("W")) or gamepad_axis_value(0, gp_axislv) == -1
global.duck = keyboard_check(vk_down) or keyboard_check(ord("S")) or gamepad_axis_value(0,gp_axislv) >= .25
global.jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("Z")) or gamepad_button_check_pressed(0, gp_face1)
global.jump_released = keyboard_check_released(vk_space) or keyboard_check_released(ord("Z")) or gamepad_button_check_released(0, gp_face1)
global.jump_held = keyboard_check(vk_space) or keyboard_check(ord("Z")) or gamepad_button_check(0, gp_face1)
global.dash = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("X")) or gamepad_button_check_pressed(0, gp_face3)

global.left_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A")) or (gamepad_axis_value(0, gp_axislh)  == -1 and !global.lhBlock)
global.right_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D")) or (gamepad_axis_value(0,gp_axislh)  == 1 and !global.lhBlock)
global.up_pressed = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or (gamepad_axis_value(0, gp_axislv) == -1 and !global.lvBlock)
global.duck_pressed = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")) or (gamepad_axis_value(0,gp_axislv) == 1 and !global.lvBlock)

global.taunt = keyboard_check_pressed(vk_control) or keyboard_check_pressed(ord("C")) or gamepad_button_check_pressed(0, gp_face4)

if(gamepad_axis_value(0, gp_axislh)  == -1 or gamepad_axis_value(0, gp_axislh)  == 1) global.lhBlock = true
if(abs(gamepad_axis_value(0, gp_axislh)) < .5) global.lhBlock = false


if(gamepad_axis_value(0, gp_axislv)  == -1 or gamepad_axis_value(0, gp_axislv)  == 1) global.lvBlock = true
if(abs(gamepad_axis_value(0, gp_axislv)) < .5) global.lvBlock = false


if(keyboard_check(vk_anykey)) global.controlscheme = ControlScheme.Keyboard

var any_pressed = 0
for (var i = gp_face1; i < gp_extra6; i++){
    if gamepad_button_check(0, i){
        any_pressed = 1;
        break;
        }
    }
	
for (var i = gp_axislh; i < gp_axisrv; i++){
    if gamepad_axis_value(0, i) > .2 or gamepad_axis_value(0, i) < -.2{
        any_pressed = 1;
        break;
        }
    }
	
if(any_pressed)
{
	var desc = gamepad_get_description(0)
	
	if(string_pos("XInput", desc) != 0) global.controlscheme = ControlScheme.Xbox
	else if(string_pos("PLAYSTATION", desc) != 0)global.controlscheme = ControlScheme.Playstation
}