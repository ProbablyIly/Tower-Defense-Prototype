extends StaticBody2D

@onready var hp = $HealthBar/ProgressBar
@onready var hp_scene = $HealthBar
@onready var placed = false
@onready var group = "tower"
@onready var colour = modulate
@onready var mouse = false
@onready var gizmo = $Gizmo
@onready var sprite =  $Sprite


@export var damage = 5
@export var range = 100
@export var hp_val = 30
@export var cooldown = 5
@export var charge = 12


var creationTime: float = 0
var minutes = 0
var hours = 0
var mins = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	creationTime = Time.get_ticks_msec() / 1000.0

func _process(delta):
	if hp.value < 1:
		queue_free()
		
	check_selection()
		
	
func check_selection():
	if mouse and not gizmo.move and Input.is_action_just_pressed("lmb"):
		if self.is_in_group("selection"):
			self.remove_from_group("selection")
			self.sprite.material.set_shader_parameter("apply_outline", 0)
			self.sprite.material.set_shader_parameter("width", 6)
		else:
			for node in get_tree().get_nodes_in_group("selectable"):
				node.remove_from_group("selection")
				
			add_to_group("selection")
			
			for node in get_tree().get_nodes_in_group("selectable"):
				if node.is_in_group("selection"):
					node.sprite.material.set_shader_parameter("apply_outline", 1)
					node.sprite.material.set_shader_parameter("width", 6)
					global.CurrentSelection = node
				
				else:
					node.sprite.material.set_shader_parameter("apply_outline", 0)
					node.sprite.material.set_shader_parameter("width", 6)
					
			queue_redraw()
	

func take_damage(dmg):
	if placed:
		hp.value -= dmg

func _on_area_2d_mouse_entered():
	mouse = true

func _on_area_2d_mouse_exited():
	mouse = false
		
		