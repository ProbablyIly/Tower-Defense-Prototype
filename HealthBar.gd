extends CanvasLayer


@onready var parent = $".."
@onready var hp = $ProgressBar
@onready var label = $ProgressBar/Label
var off_y
var off_x


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_hp()
	if parent.is_in_group("enemy"):
		off_y = -75
	else:
		off_y = -100
	off_x = hp.size.x*-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp.global_position.y = parent.position.y + off_y
	hp.global_position.x = parent.position.x + off_x

func _on_progress_bar_value_changed(value):
	label.text = str(hp.value) + "/" + str(hp.max_value)

func initialize_hp():
	hp.max_value = parent.hp_val
	hp.value = hp.max_value

	
