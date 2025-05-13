extends Camera3D

@export var sensitivity := 0.003
@export var character: CharacterBody3D

var rotation_x := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(-event.relative.x * sensitivity)
		rotation_x = clamp(rotation_x - event.relative.y * sensitivity, deg_to_rad(-80), deg_to_rad(80))
		rotation.x = rotation_x
