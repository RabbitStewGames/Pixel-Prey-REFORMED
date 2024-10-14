if(IMMUNITY <= 0 and JUMPBOOST_TIMER > 0)
	draw_self()
	
if(JUMPBOOST_TIMER <= 0 and JUMPBOOST_TIMER % 2 == 0)
	draw_self()

if(IMMUNITY > 0 and IMMUNITY % 2 == 0)
	draw_self()