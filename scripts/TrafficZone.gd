extends Area2D

var penaltyCost: int = 10

func _ready():
	self.area_exited.connect(add_movement_penalty)
	disable_zone()
	
	add_to_group("Traffic_Zone")
	
func add_movement_penalty():
	get_tree().call_group("Level", "add_traffic_penalty", penaltyCost)

func disable_zone():
	visible = false
	$CollisionShape2D.set_deferred("disabled",true)

func enable_zone():
	visible = true
	$CollisionShape2D.set_deferred("disabled",false)
	
func change_penalty_cost(newCost: int):
	penaltyCost = newCost
