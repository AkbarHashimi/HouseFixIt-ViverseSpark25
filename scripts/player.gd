extends Area2D

# custom methods
var playerState = "car"
@onready var car = $Car/CarSprite
@onready var human = $Human/playerSprite

func becomeHuman():
	human.visible = true
	car.visible = true
	car.z_index = 1
	human.z_index = 2
	
	playerState = "human"

func becomeCar():
	human.visible = false
	car.visible = true
	car.z_index = 2
	human.z_index = 1
	playerState = "car"
