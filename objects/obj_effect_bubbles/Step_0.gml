y -= 15/60
if(random(1) >= .8)
{
	if(random(1) >= .5)
	x++
	else
	x--
}

lifetime--

if(y <= obj_acid.y + 16 or lifetime <= 0) instance_destroy()