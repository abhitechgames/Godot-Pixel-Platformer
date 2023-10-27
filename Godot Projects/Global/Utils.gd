extends Node

const SAVE_PATH = "res://savebin.bin"
	
func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"Gold" : GameManager.GOLD,
	}
	
	var json_data = JSON.stringify(data)
	file.store_line(json_data)

func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				GameManager.GOLD = current_line["Gold"]
	
