extends StaticBody2D

@onready var hp = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp.value < 1:
		queue_free()


func take_damage(dmg):
	hp.value -= dmg
