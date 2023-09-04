extends Node

var x_axis = 2100
var enemy_scene = preload("res://Enemies/enemy.tscn")


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func spawn_enemy(n):
	for i in n:
		var spawn_location = Vector2(x_axis, randi_range(0, 27)*40)
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = spawn_location
		get_tree().get_root().add_child(enemy_instance)

