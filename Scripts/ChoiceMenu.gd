extends Panel

func _ready():

	$VBoxContainer/LockButton.pressed.connect(choice_pressed)
	$VBoxContainer/ScreenButton.pressed.connect(choice_pressed)
	$VBoxContainer/LeaveButton.pressed.connect(choice_pressed)
	$VBoxContainer/BrowseButton.pressed.connect(choice_pressed)


func choice_pressed():

	visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	var player = get_tree().current_scene.get_node("player")
	player.can_move = true

	var lee = get_tree().current_scene.get_node("Lee")

	lee.start_walk([
		get_tree().current_scene.get_node("WalkPoint2"),
		get_tree().current_scene.get_node("WalkPoint1"),
		get_tree().current_scene.get_node("DeskTarget")
	])

	var dialogue = get_tree().current_scene.get_node("CanvasLayer")

	await get_tree().create_timer(2).timeout

	dialogue.start_dialogue([
		"Lee: Thank you!"
	], get_tree().current_scene.get_node("player"))
