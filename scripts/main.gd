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
	
	if (delay > 0):
		delay -= 1
		return
	
	if (Input.is_key_pressed(KEY_X)):
		player.becomeHuman()
	elif (Input.is_key_pressed(KEY_Z)):
		player.becomeCar()
		
	if (Input.is_action_pressed("ui_right")):
		$Player.move_local_x(64)
		delay = 20
	elif (Input.is_action_pressed("ui_left")):
		player.move_local_x(-64)
		delay = 20
	elif (Input.is_action_pressed("ui_up")):
		player.move_local_y(-64)
		delay = 20
	elif (Input.is_action_pressed("ui_down")):
		player.move_local_y(64)
		delay = 20
