extends KinematicBody2D

signal hit

export var speed = 80

var _player

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/MainScene/Player")
	print(_player)


func _process(delta):
	look_at(_player.get_global_position())

func _physics_process(delta):
	var direction = Vector2()
	direction = _player.get_global_position() - get_global_position()
	direction = direction.normalized()
	move_and_slide(direction*speed)


func _on_Enemy_hit():
	queue_free()
