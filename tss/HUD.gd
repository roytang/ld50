extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func show_message(text):
	$Message.text = text
	$Message.show()


func _on_Player_died():
	show_message("YOU DIED!")


func _on_Player_update_hud(_player):
	$ColorRect/BombCount.text = str(_player.bombs)
	
