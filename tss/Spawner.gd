extends AnimatedSprite

signal deactivate

var enemy = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var enemy_instance = enemy.instance()
	enemy_instance.position = get_global_position()
	get_tree().get_root().add_child(enemy_instance)


func _on_Spawner_deactivate():
	$Timer.stop()
