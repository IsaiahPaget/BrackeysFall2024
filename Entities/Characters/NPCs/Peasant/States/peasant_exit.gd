extends State
class_name PeasantExit

@export var peasant: CharacterBody2D
@onready var nav_agent := %NavigationAgent2D as NavigationAgent2D
@onready var pf_timer := %PathFinderTimer as Timer

var _exit: Area2D

func Enter() -> void:
	_exit = get_tree().get_first_node_in_group("Exit")
	if pf_timer:
		pf_timer.start()


func Exit() -> void:
	if pf_timer:
		pf_timer.stop()

func Physics_Update(_delta: float) -> void:
	var dir = peasant.to_local(nav_agent.get_next_path_position()).normalized()
	peasant.velocity = dir * peasant.move_speed

func _make_path() -> void:
	nav_agent.target_position = _exit.global_position

func _on_timer_timeout() -> void:
	_make_path()
