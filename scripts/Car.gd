extends Area2D

func _ready():
	self.area_entered.connect(car_prompt)
	#disable_zone()
	
	add_to_group("Car")
	
func car_prompt():
	#insert way to trigger the UI to prompt the user to enter the car
	
	#hide the player image visuals
	get_tree().call_group("Player", "hide_player")
	

func disable_zone():
	visible = false
	$CollisionShape2D.set_deferred("disabled",true)

func enable_zone():
	visible = true
	$CollisionShape2D.set_deferred("disabled",false)
