extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _button = %InteractButton
@onready var _player = get_tree().get_first_node_in_group("Player")

@export var move_speed := 50.0
@export var talk_radius := 30.0
@export var persuation_level := 1

var _direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_show_convo_button()

func _physics_process(_delta: float) -> void:
	animate()
	move_and_slide()



func _show_convo_button() -> void:
	if _player and _button:
		var dir = _player.global_position - global_position
		if dir.length() < talk_radius:
			_button.visible = true
		else:
			_button.visible = false

func animate() -> void:
	if velocity.x > 0:
		_animated_sprite.play("Walk_Right")
		_direction.x = 1
		_direction.y = 0
	elif velocity.x < 0:
		_animated_sprite.play("Walk_Left")
		_direction.x = -1
		_direction.y = 0
	elif velocity.y < 0:
		_animated_sprite.play("Walk_Back")
		_direction.y = 1
		_direction.x = 0
	elif velocity.y > 0:
		_animated_sprite.play("Walk_Front")
		_direction.y = -1
		_direction.x = 0
	else:
		if _direction.x == 1:
			_animated_sprite.play("Idle_Right")
		elif _direction.x == -1:
			_animated_sprite.play("Idle_Left")
		elif _direction.y == 1:
			_animated_sprite.play("Idle_Back")
		elif _direction.y == -1:
			_animated_sprite.play("Idle_Front")
