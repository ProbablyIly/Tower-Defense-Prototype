extends CanvasLayer


var off = Vector2(-65, -100)
@onready var parent = $".."
@onready var hp = $ProgressBar
@onready var label = $ProgressBar/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	hp.max_value = parent.hp_val
	hp.value = hp.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hp.global_position = parent.position + off

func _on_progress_bar_value_changed(value):
	label.text = str(hp.value) + "/" + str(hp.max_value)
