extends VBoxContainer


func _ready():
	visible = false


func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("debug"):
		if visible == true:
			visible = false
		else:
			visible = true
			
func _on_kill_enemies_pressed():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.queue_free()
	
