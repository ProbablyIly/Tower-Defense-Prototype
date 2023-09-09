extends Node

var x_axis = 2100
var enemy_scene = preload("res://Enemies/enemy.tscn")

var hoards = []
var timer := Timer.new()


signal filler_signal
signal chunk_signal()

var start_filler = false
var start_chunk = false

var filler = 0
var chunk = 0
var chunk_r = "none"

var timedout = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if start_filler:
		if global.killed == filler:
			filler_signal.emit()
	if start_chunk:
		chunk_clear(chunk)

func spawn_enemy(n):
	for i in n:
		var spawn_location = Vector2(x_axis, randi_range(0, 27)*40)
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = spawn_location
		get_tree().get_root().add_child(enemy_instance)


func start_round():
	initiate_round()
	
	var current_hoard = 0
	var chunk_rolls = [0.3, 0.2, 0.5]
	
	for hoard in hoards:
		global.killed = 0
		filler = round(randi_range(1, hoards[0]/5))
		spawn_enemy(filler)
		
		print ("started filler " + str(hoard) + " with " + str(filler))
		start_filler = true
		await filler_signal
		start_filler = false
		print ("finished filler " + str(hoard) + " killed " + str(global.killed))

		chunk_rolls.shuffle()
		for chunks_current in chunk_rolls:
			global.killed = 0
			chunk = round(chunks_current*hoard)
			spawn_enemy(chunk)
			add_child(timer)
			timer.timeout.connect(self._on_timer_timeout)
			start_timer(chunk)
			print("started chunk " + str(chunks_current) + " with " + str(chunk))
			start_chunk = true
			await chunk_signal
			start_chunk = false
			print("finished chunk " + str(chunks_current) + " due to " + str(chunk_r))

func start_timer(chunk):

	var round_t = global.round
	var hoard_t = (hoards.size()+1)*2
	var chunk_t = chunk*10
	print(round_t * hoard_t * chunk_t)
	timer.wait_time = (round_t * hoard_t * chunk_t)/10
	print(timer.wait_time)
	timer.one_shot = true
	timer.start()

func chunk_clear(n1):	
		
	if global.killed == n1/2:
		chunk_r = "kills"
		chunk_signal.emit()

	if timedout:
		chunk_r = "timeout"
		chunk_signal.emit()
		timedout = false
		
	
	var full_hp = []
	for node in get_tree().get_nodes_in_group("enemy"):
		if node.hp_val == node.hp.value:
			full_hp.append(node)
	if full_hp.is_empty():
		chunk_r = "damage"
		chunk_signal.emit()
		

func initiate_round():
	
	var pool = 20 + (global.round * 10 * randf_range(0.5,1.5) * global.difficulty)
	
	var split = randi_range(0,3)

	if split == 0:
		hoards.append(pool/2)
		hoards.append(pool/2)
	elif split == 1:
		hoards.append(pool/4)
		hoards.append(pool/4)
		hoards.append(pool/2)
	elif split == 2:
		hoards.append(pool/3)
		hoards.append(pool/3)
		hoards.append(pool/3)
	elif split == 3:
		hoards.append(pool)
		#logic for boosted round


func _on_timer_timeout():
	timedout = true
