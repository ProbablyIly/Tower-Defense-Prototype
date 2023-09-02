extends Node

@onready var CurrentSelection = null

@onready var Currency = 1.0

func increase_currency():
	Currency += round(Currency)/10

func _physics_process(delta):
	if Input.is_action_just_pressed("delete") and CurrentSelection != null:
		CurrentSelection.queue_free()
		CurrentSelection = null
