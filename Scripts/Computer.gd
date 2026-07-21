extends Area3D

var player_inside = false
var can_use = false

@onready var interact_label = $"../../CanvasLayer/InteractLabel"
@onready var choice_menu = $"../../CanvasLayer/ChoiceMenu"

func _ready():
	interact_label.visible = false
	choice_menu.visible = false


func _on_body_entered(body):
	if body.name == "player":
		player_inside = true

		if can_use:
			interact_label.visible = true


func _on_body_exited(body):
	if body.name == "player":
		player_inside = false
		interact_label.visible = false

func _process(delta):
	
	if MissionManager.mission1_completed:
		return

	if !can_use:
		return

	if player_inside and Input.is_action_just_pressed("interact"):

		interact_label.visible = false
		choice_menu.visible = true

		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		var player = get_tree().current_scene.get_node("player")
		player.can_move = false
