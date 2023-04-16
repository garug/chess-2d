extends "res://scripts/Piece.gd"

func get_possible_tiles():
	var moves = []
	
	for i in range(0, board_size):
		var moves_step = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
		moves.append_array(moves_step.map(func(e): return e * i))

	return moves.map(func(e): return Piece.Move.new(e * size))
	
func state(pieces: Piece, tiles: ChessTile):
	pass
