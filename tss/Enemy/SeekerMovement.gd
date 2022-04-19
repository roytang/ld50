extends Sprite

## this script mostly exists to customize the movement behavior of the parent
var explosion = preload("res://Explosion.tscn")

var velocity;
var parent;

func _ready():
	parent = get_parent()
	velocity = Vector2(parent.speed, 0)

func _physics_process(delta):
	velocity.x = parent.speed

	var player = parent._player
	if !is_instance_valid(player):
		return
		
	var angle = parent.position.direction_to(player.position).angle()
		
	parent.rotation = lerp_angle(parent.rotation, angle, 0.3 * delta)	
		
	var motion = (velocity*delta)
	motion = motion.rotated(parent.rotation)
	
	parent.move_and_collide(motion)
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
		body.emit_signal("hit")

