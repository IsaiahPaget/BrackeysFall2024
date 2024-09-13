extends Node

@onready var text_box_scene := preload("res://UI/SpeechBubble/SpeechBubble.tscn")

var _dialog_lines: Array[String] = []
var _current_line_index = 0

var _text_box
var _text_box_position: Vector2

var _is_dialog_active = false
var _can_advance_line = false

signal dialog_finished

func start_dialog(position: Vector2, lines: Array[String]):
	if _is_dialog_active or lines.size() <= 0:
		return

	_dialog_lines = lines
	_text_box_position = position

	_show_text_box()

	_is_dialog_active = true

func _show_text_box():
	_text_box = text_box_scene.instantiate()
	_text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(_text_box)
	_text_box.global_position = _text_box_position
	_text_box.display_text(_dialog_lines[_current_line_index])
	_can_advance_line = false

func _on_text_box_finished_displaying() -> void:
	_can_advance_line = true

func _unhandled_input(event) -> void:
	if (
		event.is_action_pressed("advance_dialog") &&
		_is_dialog_active &&
		_can_advance_line
	):
		_text_box.queue_free()

		_current_line_index += 1
		if _current_line_index >= _dialog_lines.size():
			_is_dialog_active = false
			_current_line_index = 0
			dialog_finished.emit()
			return
		_show_text_box()
