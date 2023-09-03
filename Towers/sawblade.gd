extends StaticBody2D

@onready var hp = $HealthBar/ProgressBar
@onready var hp_scene = $HealthBar
@onready var placed = false
@onready var group = "tower"
@onready var colour = modulate
@onready var mouse = false
@onready var gizmo = $Gizmo
@onready var sprite =  $Sprite
@onready var timer = $Timer


var killed = 0
@export var damage = 5
@export var range = 140
@export var hp_val = 30
@export var cooldown = 1
@export var charge = 6

var dmg_off = 0
var range_off = 0
var hp_off = 0
var cooldown_off = 0
var charge_off = 0

var dmg_og = damage/5
var range_og = (range-100)/10
var hp_og = hp_val/10
var cooldown_og = cooldown*5
var charge_og = charge

var creationTime: float = 0
var minutes = 0
var hours = 0
var mins = 0

var projectile = preload("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	creationTime = Time.get_ticks_msec() / 1000.0
	timer.wait_time = cooldown
	timer.start()

func _process(delta):

		
	check_selection()
		
	
func check_selection():
	if mouse and not gizmo.move and Input.is_action_just_pressed("lmb"):
		if self.is_in_group("selection"):
			self.remove_from_group("selection")
			self.sprite.material.set_shader_parameter("apply_outline", 0)
			self.sprite.material.set_shader_parameter("width", 6)
			global.CurrentSelection = null
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
		if hp.value < 1:
			queue_free()

func _on_area_2d_mouse_entered():
	mouse = true

func _on_area_2d_mouse_exited():
	mouse = false
		
func _on_timer_timeout():
	var target = target()
	if target != null:
		if charge <= global.charge:
			global.charge -= charge
			shoot_projectile(target)
		
	
func shoot_projectile(current_target):
	var projectile_instance = projectile.instantiate()

	
	var direction = (current_target.position - self.position).normalized()
	projectile_instance.global_position = self.position
	
	var speed = 1000
	
	var angle = atan2(direction.y, direction.x)
	
	projectile_instance.rotation_degrees = rad_to_deg(angle)
	
	projectile_instance.direction = direction
	projectile_instance.speed = speed
	projectile_instance.dmg = damage
	projectile_instance.parent = self
	
	get_tree().get_root().add_child(projectile_instance)
	
func target():
	var targets = get_tree().get_nodes_in_group("enemy")
	var nearest_target = null
	var nearest_distance = range*2
	
	for target in targets:
		var distance = self.position.distance_to(target.position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_target = target
			
	return nearest_target
	
