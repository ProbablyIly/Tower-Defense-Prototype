extends StaticBody2D

@onready var hp = $ProgressBar
@onready var placed = false
@onready var group = "tower"
@onready var colour = modulate
@onready var mouse = false

@onready var sprite =  $AnimatedSprite2D


var creationTime: float = 0
var minutes = 0
var hours = 0
var mins = 0



func _ready():
	creationTime = Time.get_ticks_msec() / 1000.0


func _process(delta):
	if hp.value < 1:
		queue_free()
		
	if mouse and Input.is_action_just_pressed("lmb"):
		
		for node in get_tree().get_nodes_in_group("selectable"):
			node.remove_from_group("selection")
			
		add_to_group("selection")
		
		for node in get_tree().get_nodes_in_group("selectable"):
			if node.is_in_group("selection"):
				node.sprite.material.set_shader_parameter("apply_outline", 1)
				global.CurrentSelection = node
			else:
				node.sprite.material.set_shader_parameter("apply_outline", 0)

func take_damage(dmg):
	if placed:
		hp.value -= dmg

func _on_area_2d_mouse_entered():
	mouse = true

func _on_area_2d_mouse_exited():
	mouse = false
		
