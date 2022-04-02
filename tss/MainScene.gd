extends Node2D


var bomb_pickup = preload("res://BombPickup.tscn")
var _player
export var min_pickup_dist = 300
export var max_pickup_dist = 600
export var timer_base_time = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	_player = get_node("/root/MainScene/Player")
	$DropSpawnTimer.wait_time = timer_base_time + randi() % timer_base_time
	$DropSpawnTimer.start()


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
	$DropSpawnTimer.wait_time = 20 + randi() % 20
