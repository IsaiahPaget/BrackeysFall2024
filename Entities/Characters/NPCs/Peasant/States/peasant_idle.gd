extends State
class_name PeasantIdle

@export var peasant: CharacterBody2D
@export var move_speed := 50.0
@export var talk_radius := 50.0

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

func Physics_Update(delta: float) -> void:
	if peasant:
		peasant.velocity = _move_direction * move_speed
	var player_dir = player.global_position - peasant.global_position
	if player_dir.length() < talk_radius:
		Transitioned.emit(self, "Talk")
