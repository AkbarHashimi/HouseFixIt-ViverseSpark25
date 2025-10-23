extends Node

var numHouses = 3
var List
func _ready():
	List = get_tree().get_nodes_in_group("Fuel_Zone")
	
	List[0].enable_zone()
	List[4].enable_zone()
	
