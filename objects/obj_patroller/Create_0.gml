attributes = global.level_list[global.ACTIVE_LEVEL].leveldata.patroller

image_xscale = 2
image_yscale = 2

active_animation = attributes.anim.idle
ate_player = false

dead_af = false
death_timer = 0

escape_progress = 0
escape_requirement = irandom(10) + 10

churn_timer = 30

stun = 0

vel = new Vector2(0, 0)

prompt_frame = 0

sprite_index = attributes.image
mask_index = attributes.mask

Direction = 1

sprite_set_speed(sprite_index, attributes.framerate, spritespeed_framespersecond)
sprite_set_offset(sprite_index, sprite_get_width(sprite_index)/2, sprite_get_height(sprite_index))
sprite_set_offset(mask_index, sprite_get_width(mask_index)/2, sprite_get_height(mask_index))
object_set_mask(object_index, attributes.mask)
