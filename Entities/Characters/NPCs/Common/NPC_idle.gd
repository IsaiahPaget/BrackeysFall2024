extends State
class_name NPCIdle

@export var npc: CharacterBody2D
@export var wander_time: float

var player: CharacterBody2D
var _move_direction: Vector2

func _wander() -> void:
	_move_direction = Vector2(randf_range(-1, 1),randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	_wander()

func Update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		_wander()

func Physics_Update(_delta: float) -> void:
	if npc:
		npc.velocity = _move_direction * npc.move_speed
	var player_dir = player.global_position - npc.global_position
	if player_dir.length() < npc.talk_radius:
		Transitioned.emit(self, "Talk")
