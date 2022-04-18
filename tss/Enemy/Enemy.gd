extends KinematicBody2D

signal hit
signal child_created
signal child_destroyed

export var speed = 75
export var rotating = true
export var moving = true
export var hp = 1
export var dies_when_no_kids = false
export var can_be_hit = true

var hit_recovery_secs = 0.2 
var _player
var child_count = 0

var explosion = preload("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("/root/Player")
	connect("hit", self, "_on_Enemy_hit")
	connect("child_created", self, "_on_child_created")
	connect("child_destroyed", self, "_on_child_destroyed")
	get_parent().emit_signal("child_created")

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
			die()
		else:
			var _anim = get_node("AnimationPlayer")
			if is_instance_valid(_anim):
				_anim.play("hit")
		yield(get_tree().create_timer(hit_recovery_secs), "timeout")
		can_be_hit = true

func _on_Killzone_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("hit")

func die():
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	get_parent().emit_signal("child_destroyed")
	queue_free()

func _on_child_created():
	child_count = child_count + 1

func _on_child_destroyed():
	child_count = child_count - 1
	if child_count <= 0 and dies_when_no_kids:
		die()
