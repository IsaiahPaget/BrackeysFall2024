extends Node
class_name DialogProcessor

static func extract_dialog(dialog: String) -> Array[String]:
	var dialog_lines: Array[String]
	var line: String
	for character in dialog:
		if character == '\\':
			dialog_lines.push_back(line)
			line = ""
		else:
			line += character
	return dialog_lines
