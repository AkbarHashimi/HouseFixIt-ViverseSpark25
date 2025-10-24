extends Area2D

# custom methods
var playerState = "car"


var b_isDriving: bool = false

func becomeHuman():
	$Human/playerSprite.z_index = 1
	$Car/CarSprite.z_index = 0
	$Human/playerSprite.visible = true
	$Car/CarSprite.visible = true
	playerState = "human"
	b_isDriving = false

func becomeCar():
	$Human/playerSprite.z_index = 0
	$Car/CarSprite.z_index = 1
	$Human/playerSprite.visible = false
	$Car/CarSprite.visible = true
	playerState = "car"
	$playerSprite.visible = false
	$CarSprite.visible = true
	b_isDriving = true

func isDriving():
	return b_isDriving
