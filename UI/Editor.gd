extends VBoxContainer

@onready var damagebox = $DamageContainer/DamageBox
@onready var rangebox =  $RangeContainer/RangeBox
@onready var healthbox = $HealthContainer/Healthbox
@onready var coolbox = $CooldownContainer/CooldownBox
@onready var chargebox = $ChargeContainer/ChargeBox


var LastSelection
var apply = false

var old_dmg
var old_range
var old_hp
var old_cooldown
var old_charge

# Called when the node enters the scene tree for the first time.
func _ready():
	LastSelection = global.CurrentSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.CurrentSelection != LastSelection:
		editor_update()
		
		old_dmg = global.CurrentSelection.damage
		old_range = global.CurrentSelection.range
		old_hp = global.CurrentSelection.hp_val
		old_cooldown = global.CurrentSelection.cooldown
		old_charge = global.CurrentSelection.charge
		
		LastSelection = global.CurrentSelection

	
func editor_update():
	rangebox.value = global.CurrentSelection.range / 10
	damagebox.value = global.CurrentSelection.damage
	healthbox.value = global.CurrentSelection.hp_val / 10
	coolbox.value = global.CurrentSelection.cooldown
	chargebox.value = global.CurrentSelection.charge
	if LastSelection != null:
		if apply == false:
			LastSelection.range = old_range
			LastSelection.damage = old_dmg
			LastSelection.hp_val = old_hp
			LastSelection.hp_scene.initialize_hp()
			LastSelection.cooldown = old_cooldown 
			LastSelection.charge = old_charge
			
		apply = false


func _on_button_pressed():
	apply = true
	
func _on_damage_box_value_changed(value):
	global.CurrentSelection.damage = damagebox.value 

func _on_range_box_value_changed(value):
	global.CurrentSelection.range = rangebox.value * 10

func _on_healthbox_value_changed(value):
	global.CurrentSelection.hp_val = healthbox.value * 10
	global.CurrentSelection.hp_scene.initialize_hp()

func _on_cooldown_box_value_changed(value):
	global.CurrentSelection.cooldown = coolbox.value

func _on_charge_box_value_changed(value):
	global.CurrentSelection.charge = chargebox.value
