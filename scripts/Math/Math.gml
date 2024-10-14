function towards(v1, v2, spd){
	spd = clamp(spd, 0,1)
	var dst = v2 - v1

    var percent = dst * spd
	
	return v1 + percent
}