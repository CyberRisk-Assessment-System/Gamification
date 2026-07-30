extends Node

var mission1_completed = false
var mission2_completed = false

var dialogue_choices = []
var export_done = false

func record_choice(mission, question, choice_text):
	dialogue_choices.append({
		"mission": mission,
		"question": question,
		"choice": choice_text
	})

func check_all_missions_complete():
	if mission1_completed and mission2_completed and not export_done:
		export_done = true
		export_choices_to_csv()

func export_choices_to_csv():
	var file = FileAccess.open("user://dialogue_report.csv", FileAccess.WRITE)
	if file:
		file.store_line("Mission,Question,Choice Made")
		for item in dialogue_choices:
			var line = "\"%s\",\"%s\",\"%s\"" % [item["mission"], item["question"], item["choice"]]
			file.store_line(line)
		file.close()
		
		var global_path = ProjectSettings.globalize_path("user://dialogue_report.csv")
		OS.shell_open(global_path)
