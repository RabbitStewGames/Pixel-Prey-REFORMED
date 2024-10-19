if(STAGE == 0)
	draw_sprite_ext(sprite_index, image_index, window_get_width()/2+x_offset,window_get_height()/2, global.GameScale - .5, global.GameScale -.5 , 0, colorblend, ALPHA)
else
	draw_sprite_ext(sprite_index, 0, window_get_width()/2+x_offset,window_get_height()/2, global.GameScale - .5, global.GameScale -.5 , 0, colorblend, ALPHA)