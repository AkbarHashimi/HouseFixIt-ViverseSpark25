extends Area2D

func _ready():
	self.area_entered.connect(add_score)
	disable_house()
	
	add_to_group("House")
	
func add_score():
	disable_house()
	get_tree().call_group("Player", "add_score")

func disable_house():
	visible = false
	$CollisionShape2D.set_deferred("disabled",true)

func enable_house():
	visible = true
	$CollisionShape2D.set_deferred("disabled",false)
