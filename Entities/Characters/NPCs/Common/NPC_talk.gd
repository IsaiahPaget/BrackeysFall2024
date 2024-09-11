extends State
class_name NPCTalk

@export var npc: CharacterBody2D
@export var alert_particles: GPUParticles2D
@export var angry_particles: GPUParticles2D


var _player: CharacterBody2D

func Enter() -> void:
	_player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float) -> void:
	_handle_talk()

func _handle_talk() -> void:
	var pressed = Input.is_key_pressed(KEY_E)
	if pressed:
		var dir = _player.global_position - npc.global_position
		if dir.length() < npc.talk_radius:
			if _player:
				if _player.persuation_level >= npc.persuation_level:
					alert_particles.emitting = true
					Transitioned.emit(self, "Exiting")
				else:
					angry_particles.emitting = true
					_player.fail_persuade()

func Physics_Update(_delta: float) -> void:
	var direction = _player.global_position - npc.global_position
	if direction.length() < npc.talk_radius:
		npc.velocity = Vector2()
	else:
		Transitioned.emit(self, "Idle")
