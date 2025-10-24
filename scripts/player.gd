extends Area2D

# custom methods
var playerState = "car"

func becomeHuman():
	$Human/playerSprite.z_index = 1
	$Car/CarSprite.z_index = 0
	$Human/playerSprite.visible = true
	playerState = "human"
	
func becomeCar():
	$Human/playerSprite.z_index = 0
	$Car/CarSprite.z_index = 1
	$Human/playerSprite.visible = false
	playerState = "car"
