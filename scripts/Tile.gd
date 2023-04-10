extends Node2D

class_name ChessTile

var color
var size
signal clicked(tile)

func initialize(color: Color, initial_position: Vector2, initial_size = 128):
	self.position = initial_position * initial_size
	self.size = initial_size
	self.color = color
	$Collision.shape.size = Vector2.ONE * initial_size
	$Collision.position = Vector2.ONE * (initial_size / 2)
	return self
	
func _draw():
	draw_rect(Rect2(Vector2.ZERO, Vector2.ONE * size), color)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed == true:
		clicked.emit(self)
