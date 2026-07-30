extends CanvasLayer

@onready var dialogue_box = $DialogueBox
@onready var label = $DialogueBox/Label

var dialogue_lines = []
var current_line = 0
var player = null


func start_dialogue(lines, player_node):
	player = player_node
	player.can_move = false

	dialogue_lines = lines
	current_line = 0

	dialogue_box.visible = true
	label.text = dialogue_lines[current_line]


func _input(event):

	if !dialogue_box.visible:
		return

	if !event.is_action_pressed("ui_accept"):
		return

	current_line += 1

	if current_line < dialogue_lines.size():
		label.text = dialogue_lines[current_line]
		return

	# --------------------------
	# Dialogue Finished
	# --------------------------

	dialogue_box.visible = false
	player.can_move = true

	# =====================================================
	# AISHA MISSION
	# =====================================================

	if dialogue_lines.size() == 2 \
	and dialogue_lines[0] == "Aisha: Someone left this plugged into the shared PC.":

		var choice_menu = get_tree().current_scene.get_node("CanvasLayer/ChoiceMenu")
		choice_menu.show_menu("aisha")
		return

	# =====================================================
	# LEE FIRST DIALOGUE
	# =====================================================

	if dialogue_lines.size() == 3:

		var lee = get_tree().current_scene.get_node("Lee")

		lee.start_walk([
			get_tree().current_scene.get_node("DeskTarget"),
			get_tree().current_scene.get_node("WalkPoint1"),
			get_tree().current_scene.get_node("WalkPoint2"),
			get_tree().current_scene.get_node("CoffeeMachineTarget")
		])

		return

	# =====================================================
	# LEE THANK YOU
	# =====================================================

	if dialogue_lines.size() == 1 \
	and dialogue_lines[0] == "Lee: Thank you!":

		MissionManager.mission1_completed = true

		var lee_area = get_tree().current_scene.get_node("Lee/Area3D")
		lee_area.monitoring = false

		var computer = get_tree().current_scene.get_node("LeeComputer/Area3D")
		computer.can_use = false
		computer.monitoring = false

		return

	# =====================================================
	# AISHA END DIALOGUE (optional)
	# =====================================================

	if dialogue_lines.size() == 1 \
	and dialogue_lines[0].begins_with("Aisha:"):

		# Mission 2 can be marked complete here later.
		pass
