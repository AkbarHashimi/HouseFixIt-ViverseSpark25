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
@onready var player = $Player

func _ready():
	player.becomeHuman()

func _process(delta):
	
	var move_x: int = 0
	var move_y: int = 0
	
	var tile_set_data = $Level.tile_map_data
	
	if (delay > 0):
		delay -= 1
		return
	
	if (Input.is_key_pressed(KEY_E)):
		var local_pos = $Level.to_local(player.global_position)
		var map_pos = $Level.local_to_map(local_pos)
		
		print("\nPlayer: ", player.global_position, "\nLocal: ", local_pos, "\nMap: ", map_pos)
		
		delay = 15
		
	elif (Input.is_key_pressed(KEY_M)):
		var local_pos = $Level.to_local(player.global_position)
		var map_pos = $Level.local_to_map(local_pos)
		var tile_data = $Level.get_cell_tile_data(map_pos)
		
		print(tile_set_data)
		print("\nTile: ", tile_data)
		
		delay = 15
		
	elif (Input.is_key_pressed(KEY_X)):
		player.becomeHuman()
	elif (Input.is_key_pressed(KEY_Z)):
		player.becomeCar()
	elif (Input.is_action_pressed("ui_right")):
		move_x = 64
		delay = 15
	elif (Input.is_action_pressed("ui_left")):
		move_x = -64
		delay = 15
	elif (Input.is_action_pressed("ui_up")):
		move_y = -64
		delay = 15
	elif (Input.is_action_pressed("ui_down")):
		move_y = 64
		delay = 15
	else:
		return
	
	player.move_local_x(move_x)
	player.move_local_y(move_y)
