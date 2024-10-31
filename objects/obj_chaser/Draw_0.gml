var alpha = 1

if(in_wall) alpha = 0.5

if((!dead_af and stun <= 0) or ((dead_af or stun > 0) and current_time % 2 == 0))
	draw_sprite_ext(sprite_index, image_index, x,y,image_xscale,image_yscale,image_angle,c_white,alpha)