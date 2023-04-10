extends "res://scripts/Piece.gd"

var already_moved = false

func move_to(pos: Vector2):
	super(pos)
	already_moved = true

func get_possible_tiles():
	var moves = []
	
	# Always can move one tile
	var move_one_up = Vector2.UP * size
	moves.append(Piece.Move.new(move_one_up, false))
	
	# In first move, can move two tiles
	if not already_moved:
		var move_two_up = Vector2.UP * 2 * size
		moves.append(Piece.Move.new(move_two_up, false))
		
	# Pawn can capture in diagonal
	var diagonal_right = Piece.Move.new((Vector2.UP + Vector2.RIGHT) * size)
	var diagonal_left = Piece.Move.new((Vector2.UP + Vector2.LEFT) * size)
	moves.append_array([diagonal_right, diagonal_left])
	
	return moves

