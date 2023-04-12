extends "res://scripts/Piece.gd"
	
func get_possible_tiles():
	var moves = []
	
	var axis_x = [Vector2.LEFT * 2, Vector2.RIGHT * 2]
	var axis_y = [Vector2.UP * 2, Vector2.DOWN * 2]
	
	var axis_x_curve = [Vector2.UP, Vector2.DOWN]
	var axis_y_curve = [Vector2.RIGHT, Vector2.LEFT]
	
	for move_1 in axis_x:
		for move_2 in axis_x_curve:
			moves.append(move_1 + move_2)
			
	for move_1 in axis_y:
		for move_2 in axis_y_curve:
			moves.append(move_1 + move_2)
			
	return moves.map(func(e): return Piece.Move.new(e * size))
