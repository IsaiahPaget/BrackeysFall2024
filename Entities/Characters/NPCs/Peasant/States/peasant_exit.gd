extends State
class_name PeasantExit

@export var peasant: CharacterBody2D

@onready var nav_agent := %NavigationAgent2D as NavigationAgent2D
@onready var pf_timer := %PathFinderTimer as Timer

var _hud: CanvasLayer
var _exit: Area2D
var _exit_distance: Vector2
var _player: CharacterBody2D

func Enter() -> void:
	_hud = get_tree().get_first_node_in_group("Hud")
	_player = get_tree().get_first_node_in_group("Player")
	_exit = get_tree().get_first_node_in_group("Exit")
	if pf_timer:
		pf_timer.start()

	_exit_distance = _exit.global_position - peasant.global_position 

func Exit() -> void:
	if pf_timer:
		pf_timer.stop()

func Physics_Update(_delta: float) -> void:
	var dir = peasant.to_local(nav_agent.get_next_path_position()).normalized()
	peasant.velocity = dir * peasant.move_speed

	if _exit_distance.length() < 10:
		_exit_town()

func _exit_town():
	if _player:
		_player.successful_persuade()
		_player.points += 1
	
	if peasant:
		if _hud:
			_hud.add_life()
		peasant.queue_free()
	

func _make_path() -> void:
	nav_agent.target_position = _exit.global_position

func _on_timer_timeout() -> void:
	# Check if peasant has left
	_exit_distance = _exit.global_position - peasant.global_position 
	_make_path()
