image_alpha = 0

doingFailAnimation = true
fail_animation = global.level_list[global.ACTIVE_LEVEL].leveldata.gameovers[irandom(array_length(global.level_list[global.ACTIVE_LEVEL].leveldata.gameovers)-1)]
failAnimationTimer = 180
failAnimFrame = 0
failAnimFrameTimer = 15

doingScoreCount = false
scoreCountFinished = false
actionTimer = 0
scoreCountPhase = 0

talliedScore = 0
talliedStages = 0
talliedAvgTime = 0
talliedKills = 0
talliedCollectibles = 0
collectibleSprite = -1
collectibleSpriteFrame = 0

score_per_kill = 25
score_per_stage = 200
time_score = 100000

sfxpitch = 1

global.scoreboard.farthest_stage = obj_levelmanager.CURRENT_STAGE-1
global.scoreboard.average_time = obj_levelmanager.GetAverageTime()