extends Node

var numHouses = 3
var houseList
func _ready():
	houseList = get_tree().get_nodes_in_group("House")
	
	houseList[0].enable_house()
	houseList[1].enable_house()
	houseList[2].enable_house()
	
