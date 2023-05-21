extends "res://scripts/Piece.gd"

func get_state(pieces, tiles):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position + (Vector2.ONE * size / 2), global_position + Vector2(0,-64) + (Vector2.ONE * size / 2), 1, [self])
	var result = space_state.intersect_ray(query)

	print(global_position, global_position + Vector2(0,-64))
	
	print(result)
	return []

func get_possible_tiles():
	var moves = []
	
	for i in range(0, board_size):
		var moves_step = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
		moves.append_array(moves_step.map(func(e): return e * i))

	return moves.map(func(e): return Piece.Move.new(e * size))
