extends Node2D

@onready var parent =  $".."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

	
func _draw():
	if parent.is_in_group("selection"):
		var local_position = global_transform.affine_inverse() * parent.global_position
		draw_circle(local_position, parent.range*2, Color(Color.DEEP_SKY_BLUE, 0.2))
		
