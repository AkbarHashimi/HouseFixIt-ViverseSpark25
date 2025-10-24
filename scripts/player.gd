extends Area2D

# custom methods
var playerState = "car"
@onready var car = $Car/CarSprite
@onready var human = $Human/playerSprite


#var b_isDriving: bool = false

func becomeHuman():
	human.visible = true
	car.visible = true
	car.z_index = 1
	human.z_index = 2
	
	playerState = "human"
	#b_isDriving = false

func becomeCar():
	human.visible = false
	car.visible = true
	car.z_index = 2
	human.z_index = 1
	playerState = "car"
	#b_isDriving = true

#func isDriving():
#	return b_isDriving
