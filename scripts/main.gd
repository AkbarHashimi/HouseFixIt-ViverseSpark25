extends Node

# pseudo code

'''
// Level reads input

// Get viable moves from Path2D? of tile player stands on
	// player.location?
	// array of tiles?
	// get info from tile node?

// Level moves player object to new tile
	// direction interpreted from input
	// add displacemet to player.location
	// player.x += move_x
	// player.y += move_y

// Signal is emmitted from tile that was left
	// house/gas/traffic/regular have different signals
	// day counter/gas counter affected differently by player state
	// Signal has info about tile that was left
	
// Level updates gas can & day counter
	// gas can takes extra toll on traffic roads
	// day get incremented more if player is driving through traffic

// Car node only exists to track location if player is not in it
	// Otheriwise hide/delete the object until player exits
	// Gas can is handled by Level

// Player node exists to manipulate sprites and keep track of location
	// Movement/day counter is handled by Level


'''

var delay: int = 0

const full_time: int = 100
var timer: int = 0
var day: int = 0

const car_time: int = 1
const walk_time: int = 4
const tile_size: int = 64

@onready var player = $Player
@onready var human = $Player/Human
@onready var car = $Player/Car
@onready var level = $Level
@onready var houses = get_tree().get_nodes_in_group("House")

var num_houses: int = 10 # increases each day
var max_tank: int = 50 # decreases on some days?
var gas: int = max_tank

var carPosition : Vector2i
var humanPosition : Vector2i
var tilePosition : Vector2i
var level_region : Vector2i

func _ready():
	player.becomeHuman()
	timer = full_time # Arbitrary time
	
	# move player to starting location
	
	# set randomize seed
	randomize()
	
	# setup houses
	resetHouses(num_houses)

func _process(_delta):
	
	if (delay > 0):
		delay -= 1
		return
	
	var moved: bool = handleMovement()
	
	if not moved:
		return
	
	handleGas()
	handleTime()
	
	if (timer <= 0):
		resetTimer()
		resetHouses(num_houses)
	
	delay = 15
	
	return

func handleMovement():
	var direction: String
	var move_x: int = 0
	var move_y: int = 0	
	
	if (player.isDriving() and gas == 0):
		return false # Player cannot drive with empty gas can
	
	# Convert action press into string
	if (Input.is_action_pressed("ui_right")):
		direction = "right"
		move_x = tile_size
	elif (Input.is_action_pressed("ui_up")):
		direction = "up"
		move_y = -tile_size
	elif (Input.is_action_pressed("ui_left")):
		direction = "left"
		move_x = -tile_size
	elif (Input.is_action_pressed("ui_down")):
		direction = "down"
		move_y =tile_size
		
	#Getting out into or out of car	
	if (Input.is_key_pressed(KEY_X)):
		if (player.playerState == "car"): 
			player.becomeHuman()
		elif (player.playerState == "human"):
			player.becomeCar()
	
	# Check move viability
	if (player.playerState == "car"):
		var local_pos = level.to_local(player.global_position)
		var map_pos = level.local_to_map(local_pos)
		
		var tile = level.get_cell_tile_data(map_pos)
		var ruleset = tile.get_custom_data_by_layer_id(0)
	
		if direction not in ruleset:
			return false	
	else:
		var local_pos = level.to_local(human.global_position)
		var map_pos = level.local_to_map(local_pos)
		
		var tile = level.get_cell_tile_data(map_pos)
		var ruleset = tile.get_custom_data_by_layer_id(0)

		if direction not in ruleset:
			return true	
	
	#Move player or human		
	if(player.playerState == "car"):
		player.move_local_x(move_x)
		player.move_local_y(move_y)	
	elif(player.playerState == "human"):
		human.move_local_x(move_x)
		human.move_local_y(move_y)

func handleGas():
	if (player.isDriving()):
		gas -= 1

func handleTime():
	if (player.isDriving()):
		timer -= car_time
	else:
		timer -= walk_time

func add_traffic_penalty(penalty_cost):
	timer -= penalty_cost

func resetTimer():
	timer = full_time
	day += 1
	num_houses += 2 # difficulty increases

func resetHouses(num_houses):
	get_tree().call_group("House", "disable_house")
	
	for i in range(0, num_houses):
		# get random number
		# modulo with number of houses
		var j = randi() % houses.size()
		while (not houses[j].isDisabled()):
			j += 1
			if (j >= houses.size()):
				j = 0
		houses[j].enable_house()
	
	# Entering new day
