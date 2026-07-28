extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var sensitivity = 0.003

@onready var camera = $Camera3D

var can_move = true


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	# Hold Alt to show the mouse
	if event.is_action_pressed("alt"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# Release Alt to capture the mouse again
	if event.is_action_released("alt"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	# Only rotate the camera when the mouse is captured
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return

	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(
			camera.rotation.x,
			deg_to_rad(-60),
			deg_to_rad(70)
		)


func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func _physics_process(delta: float) -> void:
	if !can_move:
		return

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass
