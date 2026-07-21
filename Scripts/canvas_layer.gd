extends CanvasLayer

func _input(event):

	if visible and event.is_action_pressed("ui_accept"):

		$DialogueBox.visible = false

		var player = get_tree().current_scene.get_node("player")
		player.can_move = true
