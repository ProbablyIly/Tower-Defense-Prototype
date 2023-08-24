extends StaticBody2D

@onready var hp = $ProgressBar
@onready var placed = false
@onready var group = "tower"
@onready var colour = modulate
@onready var mouse = false

var selected = false

@onready var sprite =  $Sprite

@onready var gizmo = $Node2D


var creationTime: float = 0
var minutes = 0
var hours = 0
var mins = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	creationTime = Time.get_ticks_msec() / 1000.0
	gizmo.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
				node.sprite.material.set_shader_parameter("width", 12)
				global.CurrentSelection = node
				
			else:
				node.sprite.material.set_shader_parameter("apply_outline", 0)
				node.sprite.material.set_shader_parameter("width", 12)
				
				
	if is_in_group("selection"):
		selected = true
	else:
		selected = false
			
		
	if selected == true:
		gizmo.visible = true
	elif selected == false:
		gizmo.visible = false


func take_damage(dmg):
	hp.value -= dmg

func _on_area_2d_mouse_entered():
	mouse = true
	
func _on_area_2d_mouse_exited():
	mouse = false
