extends AnimatedSprite

signal deactivate

var enemy = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _on_Timer_timeout():
	var enemy_instance = enemy.instance()
	enemy_instance.position = get_global_position()
	# 1 in 10 chance the enemy is a bit faster
	var roll = randi() % 10
	if roll == 7:
		enemy_instance.speed += randi() % 50
	get_tree().get_root().add_child(enemy_instance)


func _on_Spawner_deactivate():
	$Timer.stop()
