gml_pragma("global", "InitGame()")

function InitGame()
{
	global.GameWidth = 640
	global.GameHeight = 360
	
	global.halloweenEvent = true // current_month == 10
	
	UpdateWindow(2, false)
}