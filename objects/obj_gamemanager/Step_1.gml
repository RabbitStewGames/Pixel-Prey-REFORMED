global.left = keyboard_check(vk_left) or keyboard_check(ord("A")) or gamepad_axis_value(0, gp_axislh) <= -.5
global.right = keyboard_check(vk_right) or keyboard_check(ord("D")) or gamepad_axis_value(0,gp_axislh) >= .5
global.up = keyboard_check(vk_up) or keyboard_check(ord("W")) or gamepad_axis_value(0, gp_axislv) == -1
global.duck = keyboard_check(vk_down) or keyboard_check(ord("S")) or gamepad_axis_value(0,gp_axislv) >= .25
global.jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("Z")) or gamepad_button_check_pressed(0, gp_face1)
global.dash = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("X")) or gamepad_button_check_pressed(0, gp_face3)

global.left_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A")) or (gamepad_axis_value(0, gp_axislh)  == -1 and !global.lhBlock)
global.right_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D")) or (gamepad_axis_value(0,gp_axislh)  == 1 and !global.lhBlock)
global.up_pressed = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or (gamepad_axis_value(0, gp_axislv) == -1 and !global.lvBlock)
global.duck_pressed = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S")) or (gamepad_axis_value(0,gp_axislv) == 1 and !global.lvBlock)

if(gamepad_axis_value(0, gp_axislh)  == -1 or gamepad_axis_value(0, gp_axislh)  == 1) global.lhBlock = true
if(abs(gamepad_axis_value(0, gp_axislh)) < .5) global.lhBlock = false


if(gamepad_axis_value(0, gp_axislv)  == -1 or gamepad_axis_value(0, gp_axislv)  == 1) global.lvBlock = true
if(abs(gamepad_axis_value(0, gp_axislv)) < .5) global.lvBlock = false
