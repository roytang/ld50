extends KinematicBody2D

signal died
signal hit
signal update_hud
signal pickup

export var speed = 100
export var bullet_speed = 800
export var fire_rate = 0.2
var can_fire = true
var bombs = 3

var bullet = preload("res://Bullet.tscn")
var bomb = preload("res://Bomb.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("update_hud", self)


func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		
	if Input.is_action_pressed("fire2") and can_fire and bombs > 0:
		var bomb_instance = bomb.instance()
		bomb_instance.position = get_global_position()
		get_tree().get_root().add_child(bomb_instance)
		print("Dropped a bomb!")
		bombs = bombs - 1
		emit_signal("update_hud", self)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
		
	move_and_slide(direction * speed)
		


func _on_Player_hit():
	get_tree().call_group("spawner", "emit_signal", "deactivate")
	get_tree().call_group("enemy", "emit_signal", "deactivate")
	var camera = $Camera2D
	# remove_child(camera)
	camera.position = get_global_position()
	get_tree().get_root().add_child(camera)
	queue_free()
	emit_signal("died")


func _on_Player_pickup(pickup_type):
	if pickup_type == "bomb":
		bombs = bombs + 1
		emit_signal("update_hud", self)
