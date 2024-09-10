extends CharacterBody2D

@onready var AS = $AnimatedSprite2D
@export var move_speed := 50.0
@export var talk_radius := 30.0
var _direction: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	animate()
	move_and_slide()

func animate() -> void:
	if velocity.x > 0:
		AS.play("Walk_Right")
		_direction.x = 1
		_direction.y = 0
	elif velocity.x < 0:
		AS.play("Walk_Left")
		_direction.x = -1
		_direction.y = 0
	elif velocity.y < 0:
		AS.play("Walk_Back")
		_direction.y = 1
		_direction.x = 0
	elif velocity.y > 0:
		AS.play("Walk_Front")
		_direction.y = -1
		_direction.x = 0
	else:
		if _direction.x == 1:
			AS.play("Idle_Right")
		elif _direction.x == -1:
			AS.play("Idle_Left")
		elif _direction.y == 1:
			AS.play("Idle_Back")
		elif _direction.y == -1:
			AS.play("Idle_Front")
