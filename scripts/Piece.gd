extends Node2D

class_name Piece

@export var inner_label = 0
var size
var team

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
	$Collision.position = Vector2.ONE * (initial_size / 2)
	return self
	
func move_to(pos: Vector2):
#	print(self.position, pos)
	self.position = pos
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed == true:
		clicked.emit(self)

# Return all possible movements from a piece
func get_possible_tiles() -> Array[Move]:
	return []

# Represents a piece move
# position is the neighboor tile
# is_capture, default is true, if piece can capture another piece in computed tile after aply position
class Move:
	var position: Vector2
	var is_capture: bool
	
	func _init(position: Vector2, is_capture = true):
		self.position = position
		self.is_capture = is_capture
		
	func _to_string():
		return str("PieceMove: position=", position, ", capturing=", is_capture)
