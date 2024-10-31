for(var _x = 0; _x < sprite_width; _x++)
{
	if(place_meeting(x,y,obj_levelmanager.TILEMAP))x++
	else break
}
for(var _y = 0; _y < sprite_height; _y++)
{
	if(place_meeting(x,y,obj_levelmanager.TILEMAP))y--
	else break
}
	
if(place_meeting(x,y,obj_levelmanager.TILEMAP))
{
	show_debug_message($"Obstacle '{object_get_name(object_index)}' got stuck and was removed.")
	instance_destroy()
}