extends KinematicBody2D

signal hit
signal deactivate

export var speed = 75

var _player
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/MainScene/Player")
	if _player:
		active = true


func _process(delta):
	if active:
		look_at(_player.get_global_position())

func _physics_process(delta):
	if active:
		var direction = Vector2()
		direction = _player.get_global_position() - get_global_position()
		direction = direction.normalized()
		move_and_slide(direction*speed)


func _on_Enemy_hit():
	queue_free()

func _on_Killzone_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("hit")


func _on_Enemy_deactivate():
	active = false
