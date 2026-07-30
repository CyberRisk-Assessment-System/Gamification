extends Area3D

var dialogue_started := false

func _physics_process(_delta):

	if dialogue_started or MissionManager.mission2_completed:
		return

	if !MissionManager.mission1_completed:
		return

	for body in get_overlapping_bodies():

		if body.name == "player":

			dialogue_started = true

			var dialogue = get_tree().current_scene.get_node("CanvasLayer")

			dialogue.start_dialogue([
				"Aisha: Someone left this plugged into the shared PC.",
				"Aisha: What should we do?"
			], get_tree().current_scene.get_node("player"))

			return
