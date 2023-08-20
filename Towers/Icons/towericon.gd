extends Area2D
@onready var anim = $AnimatedSprite2D/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_shape_entered(shape_idx):
	anim.play()


func _on_mouse_shape_exited(shape_idx):
	anim.pause()
