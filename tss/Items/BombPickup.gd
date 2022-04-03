extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var can_pickup = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BombPickup_body_entered(body):
	if body.is_in_group("player") and can_pickup:
		can_pickup = false
		body.emit_signal("pickup", "bomb")
		visible = false
		$AudioStreamPlayer2D.play()


func _on_VanishTimer_timeout():
	$VanishAnimationPlayer.play("blink")


func _on_VanishAnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_AudioStreamPlayer2D_finished():
	queue_free()
