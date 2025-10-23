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
var tile_size: int = 64

@onready var player = $Player
@onready var level = $Level

func _ready():
	player.becomeHuman()

func _process(delta):
	
	if (delay > 0):
		delay -= 1
		return
	
	var direction: String
	
	# Convert action press into string
	if (Input.is_action_pressed("ui_right")):
		direction = "right"
	elif (Input.is_action_pressed("ui_up")):
		direction = "up"
	elif (Input.is_action_pressed("ui_left")):
		direction = "left"
	elif (Input.is_action_pressed("ui_down")):
		direction = "down"
	
	# Check move viability
	var local_pos = level.to_local(player.global_position)
	var map_pos = level.local_to_map(local_pos)
	
	var tile = level.get_cell_tile_data(map_pos)
	var ruleset = tile.get_custom_data_by_layer_id(0)
	
	if direction not in ruleset:
		return
	
	# Move player
	var move_x: int = 0
	var move_y: int = 0
	
	if (direction == "right"):
		move_x = tile_size
	elif (direction == "left"):
		move_x = -tile_size
	elif (direction == "up"):
		move_y = -tile_size
	elif (direction == "down"):
		move_y = tile_size
	
	player.move_local_x(move_x)
	player.move_local_y(move_y)
	
	delay = 15
	
	return
