extends Node2D


var bomb_pickup = preload("res://Items/BombPickup.tscn")
var _player
export var min_pickup_dist = 300
export var max_pickup_dist = 600
export var timer_base_time = 10
export var enemy_spawn_base_time = 10
var enemy_spawn_time = enemy_spawn_base_time
var enemy_spawn_min_time = 3

var spawn_points = [
	Vector2(0, 0),
	Vector2(1024, 600),
	Vector2(1024, 0),
	Vector2(0, 600),
]

var spawn_list = [
		# list is padded so that weaker enemies have larger odds
		{
			"name": "Mickey",
			"scene": "res://Enemy/Mickey.tscn",
			"id": 0
		},
		{
			"name": "Mickey",
			"scene": "res://Enemy/Mickey.tscn",
			"id": 0
		},
		{
			"name": "Mickey",
			"scene": "res://Enemy/Mickey.tscn",
			"id": 0
		},
		{
			"name": "Cross",
			"scene": "res://Enemy/Cross.tscn",
			"id": 1
		},
	]	


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_player = get_node("/root/MainScene/Player")
	$DropSpawnTimer.wait_time = timer_base_time + randi() % timer_base_time
	$DropSpawnTimer.start()
	# immediately spawn one enemy
	_on_EnemySpawnTimer_timeout()
	$EnemySpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DropSpawnTimer_timeout():
	if is_instance_valid(_player):
		var pickup_instance = bomb_pickup.instance()
		# spawn pickup 100-200 units away
		var rand_direction = Vector2(randf()*2-1, randf()*2-1)
		var rand_x = randi()%(max_pickup_dist-min_pickup_dist) + min_pickup_dist
		var rand_y = randi()%(max_pickup_dist-min_pickup_dist) + min_pickup_dist
		var offset = Vector2(rand_x, rand_y) * rand_direction
		pickup_instance.position = _player.get_global_position() + offset
		get_tree().get_root().add_child(pickup_instance)
	# random wait until next drop
	$DropSpawnTimer.wait_time = timer_base_time + randi() % timer_base_time


func _on_EnemySpawnTimer_timeout():
	print("TIMER!")
	if is_instance_valid(_player):
		# spawn random component and attach it to the parent
		var count_opts = spawn_list.size()
		var new_spawn_data = spawn_list[randi() % count_opts]
		var spawn_scene = load(new_spawn_data["scene"])
		var spawn_instance = spawn_scene.instance()
		count_opts = spawn_points.size()
		spawn_instance.position = spawn_points[randi() % count_opts]
		get_tree().get_root().call_deferred("add_child", spawn_instance)
	
	# random wait until next drop
	$EnemySpawnTimer.wait_time = enemy_spawn_time + randi() % 10
	enemy_spawn_time = enemy_spawn_time - 2
	if enemy_spawn_time < enemy_spawn_min_time:
		enemy_spawn_time = enemy_spawn_min_time

