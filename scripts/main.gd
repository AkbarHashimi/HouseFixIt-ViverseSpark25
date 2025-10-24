extends Node

var direction: String
var move_x: int = 0
var move_y: int = 0

const full_time: int = 80
var timer: int = 0
var day: int = 1
var score: int = 0
var day_score: int = 0

const car_time: int = 1
const walk_time: int = 4
const tile_size: int = 64

@onready var player = $Player
@onready var human = $Player/Human
@onready var car = $Player/Car
@onready var level = $Level
@onready var hud = $Hud
@onready var houses = get_tree().get_nodes_in_group("House")
@onready var fuel_zones = get_tree().get_nodes_in_group("Fuel_Zone")

var moved: bool
var num_houses: int = 2 # increases each day
var num_fuel_zones: int = 4 # decreases some days?

var max_tank: int = 50 # decreases on some days?
var gas: int = max_tank

var carPosition : Vector2
var humanPosition : Vector2
var tilePosition : Vector2i
var level_region : Vector2i

func _ready():
	player.becomeCar()
	timer = full_time # Arbitrary time
	
	add_to_group("Level")
	
	# move player to starting location
	
	
	# set randomize seed
	randomize()
	
	# setup houses
	resetHouses()
	updateHud()

func _input(event):
	
	move_x = 0
	move_y = 0
	direction = ""
	
	if (Input.is_action_just_pressed("ui_right")):
		direction = "right"
		move_x = tile_size
	elif (Input.is_action_just_pressed("ui_up")):
		direction = "up"
		move_y = -tile_size
	elif (Input.is_action_just_pressed("ui_left")):
		direction = "left"
		move_x = -tile_size
	elif (Input.is_action_just_pressed("ui_down")):
		direction = "down"
		move_y =tile_size
	#Getting into or out of car
	elif (Input.is_action_just_pressed("enter-exit")):
		if (player.playerState == "car"): 
			carPosition = level.to_local(car.global_position)
			player.becomeHuman()
		elif (player.playerState == "human"):
			humanPosition = level.to_local(human.global_position)
			if(carPosition == humanPosition):
				player.becomeCar()
			else:
				pass # go back to car message needed
	
	moved = handleMovement()
	
	if moved:	
		handleGas()
		handleTime()
		
		if (timer <= 0):
			reset()
			
		updateHud()
	
func handleMovement():		
	# Check move viability
	if (player.playerState == "car"):
		if(gas <= 0):
			return false # Player cannot drive with empty gas can	
		var local_pos = level.to_local(car.global_position)
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
			return false	
	
	#Move player or human		
	if(player.playerState == "car"):
		if (move_x < 0):
			player.scale.x = -1
			player.rotation_degrees = 0
		else:
			player.scale.x = 1
			player.rotation_degrees = 0
		if (move_y > 0):
			player.rotation_degrees = 90
		elif (move_y < 0):
			player.rotation_degrees=-90
		player.global_translate(Vector2(move_x, move_y))
		
	elif(player.playerState == "human"):
		if (move_x < 0):
			human.scale.x = -1
		else:
			human.scale.x = 1
		human.global_translate(Vector2(move_x, move_y))
	return true

func handleGas():
	if (player.playerState == "car"):
		gas -= 1

func handleTime():
	if (player.playerState == "car"):
		timer -= car_time
	else:
		timer -= walk_time

func updateHud():
	hud.change_days(day)
	hud.change_fuel(gas)
	hud.change_time(timer)
	hud.change_score(score)

func reset():
	# reset player position
	
	resetTimer()
	resetHouses()
	resetFuelZones()
	day_score = 0

func resetTimer():
	timer = full_time
	day += 1

func resetHouses():
	get_tree().call_group("House", "disable_house")
	
	if (day % 2 == 0):
		num_houses += 2 # difficulty increases
	
	# temporary check to prevent crashing
	if (num_houses > houses.size()):
		return
	
	for i in range(0, num_houses):
		# get random number
		# modulo with number of houses
		var j = randi() % houses.size()
		while (houses[j].is_disabled == false):
			j += 1
			if (j >= houses.size()):
				j = 0
		houses[j].enable_house()
	
	# Entering new day

func resetFuelZones():
	get_tree().call_group("Fuel_Zone", "disable_zone")
	
	if (day % 3 == 0):
		num_fuel_zones -= 1
	
	# temporary check to prevent crashing
	if (num_fuel_zones > fuel_zones.size()):
		return
	
	'''
	for i in range(0, num_fuel_zones):
		var j = randi() % fuel_zones.size()
		while (not fuel_zones[j].isDisabled):
	'''

func add_score():
	score += 1
	day_score += 1
	hud.change_score(score)
	if (day_score == num_houses):
		reset()

func add_traffic_penalty(penalty_cost):
	timer -= penalty_cost
	hud.change_time(timer)
