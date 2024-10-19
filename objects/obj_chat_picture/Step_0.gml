if(exiting)
{
	if(alpha > 0) alpha -= 1/60
	else instance_destroy()
}
else
{
	if(alpha < 1) alpha += 1/60	
}

exists = true