extends Area2D

var dmg = 10
var direction 
var speed
var parent


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += direction * speed * delta
	if global_position > Vector2(1920, 1080):
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(dmg, parent)
