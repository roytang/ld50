extends Node2D

signal hit

var _player
export var autoaim = true

var bullet = preload("res://Bullet.tscn")
var bullet_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/MainScene/Player")

func _on_ShotTimer_timeout():
	if is_instance_valid(_player):
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.friendly = false
		# enemy bullets can only hit the player on layer 2
		bullet_instance.set_collision_layer_bit(0, false)
		bullet_instance.set_collision_layer_bit(1, true)
		bullet_instance.set_collision_mask_bit(0, false)
		bullet_instance.set_collision_mask_bit(1, true)
		if autoaim: # automatically set angle based on player position
			var angle = _player.position - bullet_instance.position
			bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(angle.angle()))
		else: # automatically set angle based on parent position
			var angle = bullet_instance.position - get_parent().position
			bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(angle.angle()))
		get_tree().get_root().add_child(bullet_instance)
