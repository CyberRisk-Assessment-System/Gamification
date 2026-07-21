extends Area3D

var talked = false

func _on_body_entered(body):

	if MissionManager.mission1_completed:
		return

	if talked:
		return

	if body.name == "player":

		talked = true

		var dialogue_manager = get_tree().current_scene.get_node("CanvasLayer")

		dialogue_manager.start_dialogue([
			"Lee: Hey! I'm going to go get some coffee.",
			"Lee: Can you look after my computer?",
			"You: Yes."
		], body)
