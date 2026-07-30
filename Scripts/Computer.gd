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


func _process(_delta):

	# Don't allow interaction after Lee's mission is over
	if MissionManager.mission1_completed:
		return

	if !can_use:
		return

	if !player_inside:
		return

	if Input.is_action_just_pressed("interact"):

		interact_label.visible = false

		# Open the Lee mission choice menu
		choice_menu.show_menu("lee")
