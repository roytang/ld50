extends AnimatedSprite


var explosion = preload("res://Explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(4, 4)
	get_tree().get_root().add_child(explosion_instance)
	var bodies = $Killzone.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("bombable"):
			body.emit_signal("bombed")
	queue_free()
