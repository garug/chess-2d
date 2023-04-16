extends "res://scripts/Piece.gd"

func get_state(pieces, tiles):
	var possibilities = []

	for tile in get_possible_tiles():
		var computed_position = tile.position + self.position
		var possible_tile = tiles.filter(func(t): return t.position == computed_position)
		
		if possible_tile.is_empty():
			continue
			
		var computed_tile = possible_tile.front()
		var possible_enemy = pieces.filter(func(t): return t.position == computed_position)
		
		if tile.is_capture:
			if not possible_enemy.is_empty():
				var computed_enemy = possible_enemy.front()
				if computed_enemy.team != self.team:
					possibilities.append(computed_tile)
		elif possible_enemy.is_empty():
			possibilities.append(computed_tile)

	return possibilities

func get_possible_tiles():
	var moves = []
	
	# Always can move one tile
	var move_one_up = Vector2.UP * size
	moves.append(Piece.Move.new(move_one_up))
	
	# In first move, can move two tiles
	if not already_moved:
		var move_two_up = Vector2.UP * 2 * size
		moves.append(Piece.Move.new(move_two_up))
		
	# Pawn can capture in diagonal
	var diagonal_right = Piece.Move.new((Vector2.UP + Vector2.RIGHT) * size, true)
	var diagonal_left = Piece.Move.new((Vector2.UP + Vector2.LEFT) * size, true)
	moves.append_array([diagonal_right, diagonal_left])
	
	return moves

