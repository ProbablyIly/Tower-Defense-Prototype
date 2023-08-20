extends Node2D

@onready var mid = $Middle
var rad = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _draw():
	draw_arc(mid.position, rad, 0, 360, 64, Color.WHITE)
	
	
