extends CharacterBody3D

@export var speed := 2.5

var path = []
var current_target = 0
var walking = false


func start_walk(points):
	path = points
	current_target = 0
	walking = true


func _physics_process(delta):

	if !walking:
		return

	if current_target >= path.size():
		walking = false
		velocity = Vector3.ZERO
		return

	var target = path[current_target]

	var direction = target.global_position - global_position
	direction.y = 0

	if direction.length() < 0.3:

		current_target += 1

		if current_target >= path.size():

			walking = false
			velocity = Vector3.ZERO

			# Enable the computer interaction
			var computer = get_tree().current_scene.get_node_or_null("LeeComputer/Area3D")

			if computer:
				computer.can_use = true

			return

		target = path[current_target]

		direction = target.global_position - global_position
		direction.y = 0

	direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	look_at(
		Vector3(
			target.global_position.x,
			global_position.y,
			target.global_position.z
		),
		Vector3.UP
	)

	move_and_slide()
