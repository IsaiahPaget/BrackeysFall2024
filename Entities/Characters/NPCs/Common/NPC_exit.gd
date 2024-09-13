extends State
class_name NPCExit

@export var npc: CharacterBody2D

@onready var _nav_agent := %NavigationAgent2D as NavigationAgent2D
@onready var _pf_timer_ := %PathFinderTimer as Timer
@onready var _interaction_area := %InteractionArea as InteractionArea

var _hud: CanvasLayer
var _exit: Area2D
var _exit_distance: Vector2
var _player: CharacterBody2D

func Enter() -> void:
	_hud = get_tree().get_first_node_in_group("Hud")
	_player = get_tree().get_first_node_in_group("Player")
	_exit = get_tree().get_first_node_in_group("Exit")
	if _pf_timer_:
		_pf_timer_.start()

	_exit_distance = _exit.global_position - npc.global_position 
	if _interaction_area:
		_interaction_area.queue_free()

func Exit() -> void:
	if _pf_timer_:
		_pf_timer_.stop()

func Physics_Update(_delta: float) -> void:
	var dir = npc.to_local(_nav_agent.get_next_path_position()).normalized()
	npc.velocity = dir * npc.move_speed

	if _exit_distance.length() < 10:
		_exit_town()

func _exit_town():
	if _player:
		_player.successful_persuade()
		_player.points += 1
	
	if npc:
		if _hud:
			_hud.add_life()
		npc.queue_free()
	

func _make_path() -> void:
	_nav_agent.target_position = _exit.global_position

func _on_timer_timeout() -> void:
	# Check if npc has left
	_exit_distance = _exit.global_position - npc.global_position 
	_make_path()
