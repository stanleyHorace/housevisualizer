extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is MeshInstance3D and !(child.name=="floor_001" or child.name.contains("bed") or child.name.contains("erson")or child.name.contains("hair")):
			child.create_trimesh_collision()
