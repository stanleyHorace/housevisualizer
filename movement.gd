extends CharacterBody3D

@onready var cam: Camera3D= $Camera3D
var SPEED := 3.5
var initial_position := Vector3.ZERO
@export var GRAVITY := 9.8
@export var SENSITIVITY := 0.003
@export var JUMP_VELOCITY := 6.0
@export var MAX_FALL_TIME := 3.0
var rotation_x := 0.0
var falling_timer := 0.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	initial_position = global_position
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		rotation_x = clamp(rotation_x - event.relative.y * SENSITIVITY, deg_to_rad(-80), deg_to_rad(80))
		cam.rotation.x = rotation_x
	elif event.is_action("ui_cancel"):
		get_tree().quit()
	elif event.is_action("reload"):
		resetPos()
	elif event.is_action_pressed("sprint"):
		SPEED=5.0
	elif event.is_action_released("sprint"):
		SPEED=3.5
	
func _physics_process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("left"):
		direction -= transform.basis.z
	if Input.is_action_pressed("right"):
		direction += transform.basis.z
	if Input.is_action_pressed("down"):
		direction -= transform.basis.x
	if Input.is_action_pressed("up"):
		direction += transform.basis.x

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
		falling_timer += delta
		if falling_timer > MAX_FALL_TIME:
			resetPos()
	else:
		falling_timer = 0.0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

	direction = direction.normalized() * SPEED
	velocity.y -= GRAVITY * delta
	velocity.x = direction.x
	velocity.z = direction.z

	move_and_slide()

func resetPos():
	#$Camera3D.set_modulate(lerp($Camera3D.get_modulate(), Color(0,0,0,1), 0.2))
	global_position = initial_position+ Vector3.UP*10
	velocity = Vector3.ZERO
	falling_timer = 0.0
