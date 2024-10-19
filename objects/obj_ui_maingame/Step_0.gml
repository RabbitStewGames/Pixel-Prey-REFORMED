if(collectible_sprite != -1){
	collectible_frame += 10/60
	if(collectible_frame > sprite_get_number(collectible_sprite)) collectible_frame = 0
}