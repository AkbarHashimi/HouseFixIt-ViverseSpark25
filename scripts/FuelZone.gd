extends Area2D

func _ready():
	self.area_shape_entered.connect(add_gas)
	disable_zone()
	
	add_to_group("Fuel_Zone")
	
func add_gas():
	disable_zone()
	get_tree().call_group("Player", "add_gas")

func disable_zone():
	visible = false
	$CollisionShape2D.set_deferred("disabled",true)

func enable_zone():
	visible = true
	$CollisionShape2D.set_deferred("disabled",false)
