extends Panel

var current_mission = ""

@onready var lock_button = $VBoxContainer/LockButton
@onready var screen_button = $VBoxContainer/ScreenButton
@onready var leave_button = $VBoxContainer/LeaveButton
@onready var browse_button = $VBoxContainer/BrowseButton


func _ready():

	lock_button.pressed.connect(choice_pressed.bind(0))
	screen_button.pressed.connect(choice_pressed.bind(1))
	leave_button.pressed.connect(choice_pressed.bind(2))
	browse_button.pressed.connect(choice_pressed.bind(3))

	visible = false


func show_menu(mission):

	current_mission = mission
	visible = true

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	var player = get_tree().current_scene.get_node("player")
	player.can_move = false

	if mission == "lee":

		lock_button.text = "Lock Computer"
		screen_button.text = "Turn Off Screen"
		leave_button.text = "Leave It As It Is"
		browse_button.text = "Browse Files"

	elif mission == "aisha":

		lock_button.text = "Report"
		screen_button.text = "Remove Safely"
		leave_button.text = "Ignore"
		browse_button.text = "Open It"


func choice_pressed(choice):

	visible = false

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	var player = get_tree().current_scene.get_node("player")
	player.can_move = true

	# -----------------------
	# LEE MISSION
	# -----------------------
	if current_mission == "lee":

		var choices = {0: lock_button.text, 1: screen_button.text, 2: leave_button.text, 3: browse_button.text}
		MissionManager.record_choice("Lee Mission", "What will you do with Lee's computer?", choices[choice])

		var lee = get_tree().current_scene.get_node("Lee")

		lee.start_walk([
			get_tree().current_scene.get_node("CoffeeMachineTarget"),
			get_tree().current_scene.get_node("WalkPoint2"),
			get_tree().current_scene.get_node("WalkPoint1"),
			get_tree().current_scene.get_node("DeskTarget")
		])

		var dialogue = get_tree().current_scene.get_node("CanvasLayer")

		await get_tree().create_timer(2).timeout

		dialogue.start_dialogue([
			"Lee: Thank you!"
		], player)


	# -----------------------
	# AISHA MISSION
	# -----------------------
	elif current_mission == "aisha":

		var choices = {0: lock_button.text, 1: screen_button.text, 2: leave_button.text, 3: browse_button.text}
		MissionManager.record_choice("Aisha Mission", "What should we do about the USB?", choices[choice])

		match choice:

			0:
				print("Player chose REPORT")

			1:
				print("Player chose REMOVE SAFELY")

			2:
				print("Player chose IGNORE")

			3:
				print("Player chose OPEN IT")
		MissionManager.mission2_completed = true

		var dialogue = get_tree().current_scene.get_node("CanvasLayer")

		await get_tree().create_timer(0.5).timeout

		dialogue.start_dialogue([
			"Aisha: Hmm...Interesting Choice"
		], player)
