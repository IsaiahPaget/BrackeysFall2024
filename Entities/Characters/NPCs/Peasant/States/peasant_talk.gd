extends State
class_name PeasantTalk

@export var peasant: CharacterBody2D
@export var move_speed := 50.0
@export var talk_radius := 50.0

var player: CharacterBody2D

func Enter() -> void:
	player = get_tree().get_first_node_in_group("Player")


func Physics_Update(_delta: float) -> void:
	var direction = player.global_position - peasant.global_position
	if direction.length() < talk_radius:
		peasant.velocity = Vector2()
	else:
		Transitioned.emit(self, "Idle")
