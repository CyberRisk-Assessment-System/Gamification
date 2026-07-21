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

	if event.is_action_pressed("ui_accept"):

		current_line += 1

		if current_line < dialogue_lines.size():

			label.text = dialogue_lines[current_line]

		else:

			dialogue_box.visible = false
			player.can_move = true

			# --------------------------
			# FIRST DIALOGUE FINISHED
			# --------------------------
			if dialogue_lines.size() == 3:

				var lee = get_tree().current_scene.get_node("Lee")

				lee.start_walk([
					get_tree().current_scene.get_node("WalkPoint1"),
					get_tree().current_scene.get_node("WalkPoint2"),
					get_tree().current_scene.get_node("CoffeeMachineTarget")
				])

			# --------------------------
			# FINAL THANK YOU FINISHED
			# --------------------------
			elif dialogue_lines.size() == 1 and dialogue_lines[0] == "Lee: Thank you!":

				MissionManager.mission1_completed = true

				# Disable Lee interaction
				var lee_area = get_tree().current_scene.get_node("Lee/Area3D")
				lee_area.monitoring = false

				# Disable Computer interaction
				var computer = get_tree().current_scene.get_node("LeeComputer/Area3D")

				computer.can_use = false
				computer.monitoring = false
