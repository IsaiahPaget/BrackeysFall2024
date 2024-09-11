extends State
class_name PeasantIdle

@export var peasant: CharacterBody2D

var player: CharacterBody2D
var _move_direction: Vector2
var _wander_time: float

func _wander() -> void:
	_move_direction = Vector2(randf_range(-1, 1),randf_range(-1, 1)).normalized()
	_wander_time = randf_range(1, 3)

func Enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	_wander()

func Update(delta: float) -> void:
	if _wander_time > 0:
		_wander_time -= delta
	else:
		_wander()

func Physics_Update(_delta: float) -> void:
	if peasant:
		peasant.velocity = _move_direction * peasant.move_speed
	var player_dir = player.global_position - peasant.global_position
	if player_dir.length() < peasant.talk_radius:
		Transitioned.emit(self, "Talk")
