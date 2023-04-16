extends Node2D

class_name Piece

@export var inner_label = 0
var size
var team
var board_size = 0
var already_moved = false

# Signal saying "Hi, I'm clicked"
signal clicked(piece)

func _ready():
	$Label.text = str(inner_label)

func initialize(color: Color, initial_position: Vector2, initial_size = 128):
	self.position = initial_position * initial_size
	self.size = initial_size
	self.team = color
	$Label.size = Vector2.ONE * initial_size
	$Label.add_theme_color_override("font_color", color)
	$Collision.shape.size = Vector2.ONE * initial_size
	@warning_ignore("integer_division")
	$Collision.position = Vector2.ONE * (initial_size / 2)
	return self
	
func move_to(pos: Vector2):
#	print(self.position, pos)
	self.position = pos
	already_moved = true
	
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed == true:
		clicked.emit(self)

# Return all possible movements from a piece
func get_possible_tiles() -> Array[Move]:
	return []
	
func get_state(pieces: Array[Piece], tiles: Array[ChessTile]):
	return []

# Represents a piece move
# position is the neighboor tile
# is_capture, default is null, if piece can capture another piece in computed tile after apply position
class Move:
	var position: Vector2
	var is_capture
	
	func _init(pos: Vector2, capture = null):
		self.position = pos
		self.is_capture = capture
		
	func _to_string():
		return str("PieceMove: position=", position, ", capturing=", is_capture)
