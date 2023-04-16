extends Node2D

# Represents square side
@export var size = 8

# Save all possible moves without validation
@export var possible_moves = []

# Default size for tile on board, in pixels
var tile_size = 64

# Load scenes used to generate board
# Tile
var tile: PackedScene = load("res://Tile.tscn")

# Pieces
var pawn: PackedScene = load("res://pieces/generated_pieces/Pawn.tscn")
var rook: PackedScene = load("res://pieces/generated_pieces/Rook.tscn")
var horse: PackedScene = load("res://pieces/generated_pieces/Horse.tscn")
var bishop: PackedScene = load("res://pieces/generated_pieces/Bishop.tscn")
var queen: PackedScene = load("res://pieces/generated_pieces/Queen.tscn")
var king: PackedScene = load("res://pieces/generated_pieces/King.tscn")

# All tiles on board
var tiles: Array[ChessTile] = []

# All pieces on board
var pieces: Array[Piece] = []

# Piece when clicked
var active_piece: Piece
var active_state

func _ready():
	var color_secondary = Color("#000")
	var color_white = Color("#fff")
	
	for x in range(0, size):
		for y in range(0, size):
			# Generating board with tiles
			var generated_tile: ChessTile = tile.instantiate()
			var color = color_white if (x % 2 == 0) == (y % 2 == 0) else color_secondary
			generated_tile.initialize(color, Vector2(x,y), tile_size)
			generated_tile.clicked.connect(_tile_clicked)
			tiles.append(generated_tile)
			add_child(generated_tile)
			
			# Create a empty variable to represent a piece
			var piece

			# If the position has tile, override piece variable
			if y == 6 or y == 1:
				piece = pawn
			elif (x == 0 or x == 7) and (y == 0 or y == 7):
				piece = rook
			elif (x == 1 or x == 6) and (y == 0 or y == 7):
				piece = horse
			elif (x == 2 or x == 5) and (y == 0 or y == 7):
				piece = bishop
			elif x == 4 and (y == 0 or y == 7):
				piece = queen
			elif x == 3 and (y == 0 or y == 7):
				piece = king
			
			# If have a piece, instantiate and initialize
			if piece:
				var generated_piece: Piece = piece.instantiate()
				var piece_color = color_white if y == 7 or y == 6 else color_secondary
				generated_piece.initialize(piece_color, Vector2(x,y), tile_size)
				generated_piece.clicked.connect(_piece_clicked)
				generated_piece.board_size = size
				pieces.append(generated_piece)
				add_child(generated_piece)
				
func _piece_clicked(piece: Piece):
	if piece.is_queued_for_deletion():
		return

	_set_active_piece(piece)

func _tile_clicked(tile: ChessTile):
	# If board don't have active_piece, end interaction
	if not active_piece:
		return
		
	# If piece don't have iteraction with this tile, end interaction
	if active_state.find(tile) == -1:
		return
	
	# Checks if tile has another piece
	var pieces_in_tile = pieces.filter(func(e): return tile.position == e.position)
	
	if not pieces_in_tile.is_empty():
		_remove_piece(pieces_in_tile.front())
		
	active_piece.move_to(tile.position)
	_set_active_piece(null)


func _set_active_piece(piece: Piece):
	_clean_active_tiles()
	active_piece = piece
	$ActivePiece.text = str("Active Piece: ", str(piece) if piece else "None")
	
	# If piece is null, nothing more to do here
	if piece == null:
		active_state = null
		return
		
	active_state = piece.get_state(pieces, tiles)
	
	for tile in active_state:
		tile.active = true

func _used_movement(piece: Piece, tile: ChessTile):
	var filtered_possibilities = piece.get_possible_tiles().filter(func(e): return piece.position + e.position == tile.position)
	return filtered_possibilities.front() if not filtered_possibilities.is_empty() else null

func _remove_piece(piece: Piece):
	pieces.erase(piece)
	piece.queue_free()

func _clean_active_tiles():
	for active_tile in tiles.filter(func(e): return e.active):
		active_tile.active = false
