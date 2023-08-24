extends Node2D

@onready var mid = $Middle #Marker2D
@onready var controller = $Middle/Sprite2D
@onready var parent = $".."

var rad = 150
var angle = 0.0
var rotate = false
var move = false
var held = false
var last
var mouse_move

func _ready():
	controller.position = mid.position + Vector2(rad, 0)

func _process(delta):
	if rotate == true:
		if Input.is_action_pressed("lmb"):
			held = true
			last = "rotate"
			
	if move == true:
		if Input.is_action_pressed("lmb"):
			held = true
			last = "move"
			
	if held and last == "rotate":
		var mouse_pos = get_global_mouse_position()
		var direction = mouse_pos - mid.global_position
		angle = direction.angle()
		
	if held and last == "move":
		mouse_move = get_global_mouse_position()

	if Input.is_action_just_released("lmb"):
		held = false
	
	if last == "rotate":
		parent.rotation = angle
	if last == "move":
		parent.position = mouse_move


func _draw():
	draw_arc(mid.position, rad, 0, 360, 64, Color.WHITE)

func _on_area_2d_mouse_entered():
	rotate = true

func _on_area_2d_mouse_exited():
	rotate = false

func _on_movement_mouse_entered():
	move = true

func _on_movement_mouse_exited():
	move = false
