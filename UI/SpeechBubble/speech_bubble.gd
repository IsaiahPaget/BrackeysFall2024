extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

@export var max_width := 256

@export var letter_time := 0.03
@export var space_time := 0.06
@export var punc_time := 0.2

var _text = ""
var _letter_index = 0

signal finished_displaying()

func display_text(text_to_display: String) -> void:
	_text = text_to_display
	if label:
		label.text = text_to_display
	print("hello1?")

	await resized
	custom_minimum_size.x = min(size.x, max_width)

	if size.x >= max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		print("hello2?")

	print(global_position.x - size.x / 2)
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24

	label.text = ""
	_display_letter()

func _display_letter() -> void:
	label.text += _text[_letter_index]

	_letter_index += 1

	if _letter_index >= _text.length():
		finished_displaying.emit()
		return

	match _text[_letter_index]:
		"!", ".", ",", ":", ";", "?":
			timer.start(punc_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func _on_letter_displaytimer_timeout() -> void:
	_display_letter()
