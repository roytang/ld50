extends Node2D


var _parent

var component_list = [
		{
			"name": "SwarmSpawner",
			"scene": "res://Enemy/SwarmSpawner.tscn",
			"id": 0
		},
		{
			"name": "Turret",
			"scene": "res://Enemy/Turret.tscn",
			"id": 1
		},
		{
			"name": "DoubleTurret",
			"scene": "res://Enemy/DoubleTurret.tscn",
			"id": 2
		},
		{
			"name": "OctoTurret",
			"scene": "res://Enemy/OctoTurret.tscn",
			"id": 3
		},
	]	


# Called when the node enters the scene tree for the first time.
func _ready():
	_parent = get_parent()
	randomize()
	var count_opts = component_list.size()
	
	for child in _parent.get_children():
		if child.is_in_group("componentslot"):
			# spawn random component and attach it to the parent
			var new_component_data = component_list[randi() % count_opts]
			var comp_scene = load(new_component_data["scene"])
			var comp_instance = comp_scene.instance()
			comp_instance.position = child.position
			print(comp_instance)
			_parent.call_deferred("add_child", comp_instance)
			# print(comp_instance.get_parent())
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
