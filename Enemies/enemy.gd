extends CharacterBody2D

const SPEED = 300.0

var can_attack = false
var detect_range = 100
var attack_target

var dmg = 10

@onready var current_target

@onready var hp = $HealthBar/ProgressBar
@onready var hp_scene = $HealthBar

var hp_val = 30

func _ready():
	current_target = find()
	print(current_target)
  
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if current_target != null:
		var direction = (current_target.position - position).normalized()
		var velocity = direction * SPEED * delta
		position += velocity
		move_and_slide()
		
	if current_target == null:
		current_target = find()
	

func find():
	var targets = get_tree().get_nodes_in_group("tower")
	var nearest_target = null
	var nearest_distance = 1000000000
	
	for target in targets:
		var distance = self.position.distance_to(target.position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_target = target
			
	return nearest_target


func _on_attack_body_entered(body):
	if body.is_in_group("tower"):
		can_attack = true
		attack_target = body
		

func _on_timer_timeout():
	if can_attack:
		attack_target.take_damage(dmg)


func _on_attack_body_exited(body):
	if body == attack_target:
		can_attack = false
		current_target = null
		
func take_damage(dmg, parent):
		hp.value -= dmg
		if hp.value < 1:
			queue_free()
			parent.killed += 1


