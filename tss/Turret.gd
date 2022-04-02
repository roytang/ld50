extends KinematicBody2D


var _player
var active = false

var bullet = preload("res://Bullet.tscn")
var bullet_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/MainScene/Player")
	if is_instance_valid(_player):
		active = true

func _process(delta):
	if is_instance_valid(_player):
		look_at(_player.get_global_position())

func _on_ShotTimer_timeout():
	if is_instance_valid(_player):
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.friendly = false
		# enemy bullets can only hit the player on layer 2
		bullet_instance.set_collision_layer_bit(0, false)
		bullet_instance.set_collision_layer_bit(1, true)
		bullet_instance.set_collision_mask_bit(0, false)
		bullet_instance.set_collision_mask_bit(1, true)
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)

