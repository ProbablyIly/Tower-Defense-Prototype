extends HBoxContainer

@onready var CurrentTower = null
var tower_scene = load("res://Towers/tower.tscn")
var enemy_scene = load("res://Enemies/enemy.tscn")
var barricade_scene = load("res://Towers/obstacle.tscn")
var saw_scene = load("res://Towers/sawbladetower.tscn")
var IsSelected = false

@onready var alpha = Color.WHITE



# Called when the node enters the scene tree for the first time.
func _ready():
	alpha.a = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if IsSelected and CurrentTower != null:
		var mouse_pos = get_global_mouse_position()
		CurrentTower.position = CurrentTower.position.lerp(mouse_pos, delta * 50)
		CurrentTower.modulate = alpha

func _input(event):
	if Input.is_action_just_pressed("lmb") and CurrentTower != null:
			IsSelected = false
			CurrentTower.placed = true
			CurrentTower.add_to_group("tower")
			var newalpha = alpha
			newalpha.a = 1
			CurrentTower.modulate = newalpha 


func _on_tower_button_pressed():
	var tower_instance = tower_scene.instantiate()
	get_tree().get_root().add_child(tower_instance)
	CurrentTower = tower_instance
	IsSelected = true


func _on_enemy_pressed():
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = Vector2(1920, 540)
	get_tree().get_root().add_child(enemy_instance)


func _on_barricade_button_pressed():
	var barricade_instance = barricade_scene.instantiate()
	get_tree().get_root().add_child(barricade_instance)
	CurrentTower = barricade_instance
	IsSelected = true


func _on_saw_button_pressed():
	var saw_instance = saw_scene.instantiate()
	get_tree().get_root().add_child(saw_instance)
	CurrentTower = saw_instance
	IsSelected = true
