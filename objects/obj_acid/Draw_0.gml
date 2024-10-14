var tileAmount = ceil(room_width / sprite_width)
var tileHeight = ceil(global.acid_height / sprite_height)

for(var i = -2; i < tileAmount + 2; i++)
{
	draw_sprite_ext(sprite_index, image_index, x + i * sprite_width, y, image_xscale, image_yscale, 0, acid_color, acid_alpha)
}

draw_set_alpha(acid_alpha)
draw_rectangle_color(0, y + sprite_height, room_width, room_height, acid_color, acid_color, acid_color, acid_color, false)
draw_set_alpha(1)