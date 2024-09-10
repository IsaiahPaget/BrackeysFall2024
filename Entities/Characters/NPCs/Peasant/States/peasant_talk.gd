extends State
class_name PeasantTalk

@export var peasant: CharacterBody2D

var _player: CharacterBody2D

func Enter() -> void:
	_player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float) -> void:
	_handle_talk()

func _handle_talk() -> void:
	var pressed = Input.is_key_pressed(KEY_E)
	if pressed:
		var dir = _player.global_position - peasant.global_position
		if dir.length() < peasant.talk_radius:
			if _player:
				if _player.persuation_level >= peasant.persuation_level:
					Transitioned.emit(self, "Exiting")

func Physics_Update(_delta: float) -> void:
	var direction = _player.global_position - peasant.global_position
	if direction.length() < peasant.talk_radius:
		peasant.velocity = Vector2()
	else:
		Transitioned.emit(self, "Idle")
