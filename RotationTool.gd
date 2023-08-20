extends Node2D

@onready var mid = $Middle #Marker2D
@onready var controller = $Middle/Sprite2D
@onready var parent = $".."

var rad = 150
var angle = 0.0
var mouse = false
var held = false

func _ready():
	controller.position = mid.position + Vector2(rad, 0)

func _process(delta):
	if mouse == true:
		if Input.is_action_pressed("lmb"):
			held = true

	if held:
		var mouse_pos = get_global_mouse_position()
		var direction = mouse_pos - mid.global_position
		angle = direction.angle()

	if Input.is_action_just_released("lmb"):
		held = false
		
	parent.rotation = angle


func _draw():
	draw_arc(mid.position, rad, 0, 360, 64, Color.WHITE)

func _on_area_2d_mouse_entered():
	mouse = true

func _on_area_2d_mouse_exited():
	mouse = false
