extends Node

# pseudo code

'''
e.g.

struct Player {
	int location[2]; // relative to game map?
	bool isDriving;
	// etc.
}

struct Car {
	int location[2];
	int tank;
	// etc.
}

Tile TileMap[size.y][size.x]; // to get information from tile we are on

func main() {
	var input = getInput();
	var current_tile = TileMap[this->player->location->x]
								[this->player->location->y];
								
	var allowed_moves = current_tile->ruleset;
	
	// Tile has information about its ruleset
	// pull this information to check for valid moves
	// Stored as 4-bit flag? 0001 = 1 direction; 0011 = turn, 0101 is straight, etc.
	
	if (input == "interact") { // activating unique tiles? (houses & refills)
		if (current_tile.type() == "gascan") {
			fillMeter(current_tile);
		} else if (current_tile.type() == "house") {
			fixHouse(current_tile);
		}
	}
	
	else if (isValidMove(input, allowed_moves)) {
		movePlayer(input);
	} else {
		return; // no valid move, do not increment time
	}
	
	incrementTime(current_tile); // Tile has information about its time weight
	// also increments when player refills or fixes?
}

'''
	
	
