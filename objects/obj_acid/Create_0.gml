sprite_index = global.level_list[0].leveldata.s_acid
image_xscale = 2
image_yscale = 2
image_speed = 0.25

sin_period = .001
sin_amplitude = 10
y_offset = 0

var c = global.level_list[0].leveldata.acid_color

acid_color = make_color_rgb(c[0], c[1], c[2])
acid_alpha = global.level_list[0].leveldata.acid_alpha

global.acidheight_drawn = y

y = room_height