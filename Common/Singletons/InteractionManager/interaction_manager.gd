extends Node2D

@onready var _player = get_tree().get_first_node_in_group("Player")
@onready var _label = $Label

const BASE_TEXT = "[E] to "

var _active_areas = []
var _can_interact = true

func register_area(area: InteractionArea):
	_active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = _active_areas.find(area)
	if index != -1:
		_active_areas.remove_at(index)

func _process(_delta: float) -> void:
	if _active_areas.size() > 0 && _can_interact:
		_active_areas.sort_custom(_sort_by_distance_to_player)
		_label.text = BASE_TEXT + _active_areas[0].action_name
		_label.global_position = _active_areas[0].global_position
		_label.global_position.y -= 36
		_label.global_position.x -= _label.size.x / 2
		_label.show()
	else:
		_label.hide()

func _sort_by_distance_to_player(area_1: InteractionArea, area_2: InteractionArea) -> InteractionArea:
	var area_1_to_player = _player.global_position.distance_to(area_1)
	var area_2_to_player = _player.global_position.distance_to(area_2)
	return area_1_to_player < area_2_to_player
	
func _input(event) -> void:
	if event.is_action_pressed("interact") && _can_interact:
		if _active_areas.size() > 0:
			_can_interact = false
			_label.hide()

			await _active_areas[0].interact.call()
			_can_interact = true
