extends Node

@onready var CurrentSelection = null

@onready var Currency = 1.0

@onready var charge = 60

func increase_currency():
	Currency += round(Currency)/10
	
func increase_charge():
	if charge < 60:
		charge += 1 * get_process_delta_time()

func _physics_process(delta):
	increase_charge()
	if Input.is_action_just_pressed("delete") and CurrentSelection != null:
		CurrentSelection.queue_free()
		CurrentSelection = null
