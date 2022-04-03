extends KinematicBody2D

signal hit

export var speed = 75
export var rotating = true
export var moving = true
export var hp = 1

var hit_recovery_secs = 0.2 
var can_be_hit = true
var _player

var explosion = preload("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/Player")
	connect("hit", self, "_on_Enemy_hit")


func _process(delta):
	if is_instance_valid(_player) and rotating:
		look_at(_player.get_global_position())

func _physics_process(delta):
	if is_instance_valid(_player) and moving:
		var direction = Vector2()
		direction = _player.get_global_position() - get_global_position()
		direction = direction.normalized()
		move_and_slide(direction*speed)


func _on_Enemy_hit():
	if can_be_hit:
		hp = hp - 1
		can_be_hit = false
		if hp == 0:
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_position()
			get_tree().get_root().add_child(explosion_instance)
			queue_free()
		else:
			var _anim = get_node("AnimationPlayer")
			if is_instance_valid(_anim):
				_anim.play("hit")
		yield(get_tree().create_timer(hit_recovery_secs), "timeout")
		can_be_hit = true

func _on_Killzone_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("hit")


