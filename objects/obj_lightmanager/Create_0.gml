lighting_surface = -1

var c = global.level_list[0].leveldata.ambient_light

light_ambient = make_color_rgb(c[0], c[1], c[2])

Reset = function()
{
	var _cw = camera_get_view_width(view_camera[0]);
    var _ch = camera_get_view_height(view_camera[0]);
    lighting_surface = surface_create(_cw, _ch);
    surface_set_target(lighting_surface);
    draw_set_colour(light_ambient);
    draw_set_alpha(0);
    draw_rectangle(0, 0, _cw, _cw, false);
    surface_reset_target();
}