COLLECTIBLE = global.level_list[global.ACTIVE_LEVEL].leveldata.collectibles[irandom(array_length(global.level_list[global.ACTIVE_LEVEL].leveldata.collectibles)-1)]

image_xscale = 2
image_yscale = 2

sprite_index = COLLECTIBLE.image
VALUE = COLLECTIBLE.value

image_speed = 0.5

COLLECTED = false

spd = 0

X_SCREEN = 0
Y_SCREEN = 0
SCALEX_SCREEN = image_xscale * global.GameScale * obj_view.ZOOM
SCALEY_SCREEN = image_yscale * global.GameScale * obj_view.ZOOM