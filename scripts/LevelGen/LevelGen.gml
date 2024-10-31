#macro CELL_WIDTH 32
#macro CELL_HEIGHT 32
#macro VOID -7
#macro WALL -8
#macro DECOR -9

#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8


function LoadStage(tilemap, decormap, index)
{
	// Initialization
	
	tilemap_clear(tilemap, 0)
	tilemap_clear(decormap, 0)
	
	var lvl = global.level_list[global.ACTIVE_LEVEL]
	var img = lvl.leveldata.stages[index]
	
	room_width = sprite_get_width(img) * CELL_WIDTH
	room_height = sprite_get_height(img) * CELL_HEIGHT
	
	width_ = room_width / CELL_WIDTH
	height_ = room_height / CELL_HEIGHT
	
	randomize()
	
	// Surface creation
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	var surf = surface_create(width_, height_)
	draw_clear(c_black)
	surface_set_target(surf)
	draw_sprite(img, 0, 0, 0)
	
	
	// Grid creation
	
	grid_ = ds_grid_create(width_, height_)
	ds_grid_set_region(grid_, 0, 0, width_, height_, VOID)


	// Walls

	for(var _x = 0; _x < width_; _x++)
	{
		for (var _y = 0; _y < height_; _y++)
		{
			var col = surface_getpixel(surf, _x, _y)
			
			if(col == c_white or _x >= sprite_get_width(img)) grid_[# _x, _y] = WALL
		}
	}
	
	
	// Decoration
	
	for(var _x = 1; _x < width_ - 1; _x++)
	{
		for (var _y = 1; _y < height_ - 1; _y++)
		{
			if(grid_[# _x, _y] == VOID and
			(grid_[# _x + 1, _y] == WALL or
			grid_[# _x - 1, _y] == WALL or
			grid_[# _x, _y + 1] == WALL or
			grid_[# _x, _y - 1] == WALL))
			grid_[# _x, _y] = DECOR
		}
	}
	
	
	// Tile placement: Walls
	
	for(var _x = 0; _x < width_; _x++)
	{
		for (var _y = 0; _y < height_; _y++)
		{
			if(grid_[# _x, _y] == WALL)
			{
				var n = true
				var w = true
				var e = true
				var s = true
				
				var nw = true
				var ne = true
				var sw = true
				var se = true
				
				if(_y-1 >= 0) {
					n = grid_[# _x, _y-1] == WALL;
					
					if(_x+1 < width_) ne = grid_[# _x + 1, _y-1] == WALL;
					if(_x-1 >= 0) nw = grid_[# _x-1, _y - 1] == WALL;
					
				}
				if(_x-1 >= 0) w = grid_[# _x-1, _y] == WALL;
				if(_x+1 < width_) e = grid_[# _x+1, _y] == WALL;
				
				if(_y+1 < height_) {
					s = grid_[# _x, _y+1] == WALL;
					
					if(_x+1 < width_) se = grid_[# _x + 1, _y+1] == WALL;
					if(_x-1 >= 0) sw = grid_[# _x-1, _y + 1] == WALL;
					
				}
				 
				var _tile_index = NORTH*n + WEST*w +EAST*e + SOUTH*s + 1
				
				if(!n and s and w and e and !se and !sw) _tile_index = 25
				if(!w and s and n and e and !se and !ne) _tile_index = 26
				if(!e and s and w and n and !nw and !sw) _tile_index = 27
				if(!s and n and w and e and !se and !nw) _tile_index = 28
				
				if(n and w and !nw and s and e) _tile_index = 17
				if(n and e and !ne and s and w) _tile_index = 18
				if(s and w and !sw and n and e) _tile_index = 19
				if(s and e and !se and w and n) _tile_index = 20
				
				if(n and e and w and s)
				{
					if(!nw and !ne and sw and se) _tile_index = 21
					if(!ne and !se and sw and nw) _tile_index = 22
					if(!sw and !se and nw and ne) _tile_index = 23
					if(!nw and !sw and se and ne) _tile_index = 24	
				}
				
				
				tilemap_set(tilemap, _tile_index, _x, _y)
			}
		}
	}
	
	
	// Tile placement: Decoration
	
	for(var _x = 1; _x < width_ - 1; _x++)
	{
		for (var _y = 1; _y < height_ - 1; _y++)
		{
			if(grid_[# _x, _y] == DECOR)
			{
				var n = true
				var w = true
				var e = true
				var s = true
				
				var nw = true
				var ne = true
				var sw = true
				var se = true
				
				if(_y-1 >= 0) {
					n = grid_[# _x, _y-1] == WALL;
					
					if(_x+1 < width_) ne = grid_[# _x + 1, _y-1] == WALL;
					if(_x-1 >= 0) nw = grid_[# _x-1, _y - 1] == WALL;
					
				}
				if(_x-1 >= 0) w = grid_[# _x-1, _y] == WALL;
				if(_x+1 < width_) e = grid_[# _x+1, _y] == WALL;
				
				if(_y+1 < height_) {
					s = grid_[# _x, _y+1] == WALL;
					
					if(_x+1 < width_) se = grid_[# _x + 1, _y+1] == WALL;
					if(_x-1 >= 0) sw = grid_[# _x-1, _y + 1] == WALL;
					
				}
				 
				var _tile_index = NORTH*n + WEST*w +EAST*e + SOUTH*s + 1
				
				tilemap_set(decormap, _tile_index, _x, _y)
			}
		}
	}
	
	for(var _x = 0; _x < width_; _x++)
	{
		for (var _y = 0; _y < height_; _y++)
		{
			var col = surface_getpixel(surf, _x, _y)
			
			if(col == c_lime) {obj_player.x = _x * CELL_WIDTH; obj_player.y = _y * CELL_HEIGHT}
			if(col == c_red) 
			{
				instance_create_layer(_x * CELL_WIDTH, (_y + 1) * CELL_HEIGHT, "Stage_Instances", obj_goal)
			}
			
			if(col == c_yellow) instance_create_layer(_x * CELL_WIDTH, _y * CELL_HEIGHT, "Stage_Instances", obj_collectible)
			
			if(col == c_blue and global.level_list[global.ACTIVE_LEVEL].leveldata.chaser != -1){
				instance_create_layer(_x * CELL_WIDTH, _y * CELL_HEIGHT, "Instances", obj_chaser)
			}
			
			if(col == c_aqua and global.level_list[global.ACTIVE_LEVEL].leveldata.patroller != -1){
				instance_create_layer(_x * CELL_WIDTH, _y * CELL_HEIGHT + CELL_HEIGHT, "Instances", obj_patroller)
			}
		}
	}
	
	// Cleanup
	
	ds_grid_destroy(grid_)
	
	surface_reset_target()
	surface_free(surf)
}