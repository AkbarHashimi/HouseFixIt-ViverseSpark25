extends Area2D

# custom methods
var playerState = "car"


#var b_isDriving: bool = false

func becomeHuman():
	$Human/playerSprite.visible = true
	$Car/CarSprite.visible = true
	playerState = "human"
	#b_isDriving = false

func becomeCar():
	$Human/playerSprite.visible = false
	$Car/CarSprite.visible = true
	playerState = "car"
	#b_isDriving = true

#func isDriving():
#	return b_isDriving
