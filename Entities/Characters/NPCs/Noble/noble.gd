extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _dialog_processor = DialogProcessor

@export var move_speed := 50.0
@export var talk_radius := 30.0
@export var persuation_level := 1
@export var positive_dialog = ""
@export var negative_dialog = ""
var positive_dialog_lines: Array[String]
var negative_dialog_lines: Array[String]

var _direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positive_dialog_lines = _dialog_processor.extract_dialog(positive_dialog)
	negative_dialog_lines = _dialog_processor.extract_dialog(negative_dialog)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	animate()
	move_and_slide()

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
