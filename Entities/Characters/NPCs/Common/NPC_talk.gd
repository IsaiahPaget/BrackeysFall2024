extends State
class_name NPCTalk

@onready var interaction_area: InteractionArea = %InteractionArea
@export var npc: CharacterBody2D
@export var alert_particles: GPUParticles2D
@export var angry_particles: GPUParticles2D


var _player: CharacterBody2D

func Enter() -> void:
	interaction_area.interact = Callable(self, "_handle_talk")
	_player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float) -> void:
	pass

func _handle_talk() -> void:
	if _player.persuation_level >= npc.persuation_level:
		DialogManager.start_dialog(npc.global_position, npc.positive_dialog_lines)
		await DialogManager.dialog_finished
		alert_particles.emitting = true
		Transitioned.emit(self, "Exiting")
	else:
		DialogManager.start_dialog(npc.global_position, npc.negative_dialog_lines)
		await DialogManager.dialog_finished
		angry_particles.emitting = true
		_player.fail_persuade()

func Physics_Update(_delta: float) -> void:
	var distance_to_player = _player.global_position.distance_to(npc.global_position)
	if distance_to_player < npc.talk_radius:
		npc.velocity = Vector2()
	else:
		Transitioned.emit(self, "Idle")
