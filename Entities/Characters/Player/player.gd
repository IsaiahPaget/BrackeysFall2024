extends CharacterBody2D

@onready var AS = $AnimatedSprite2D
@export var persuation_level := 1

const SPEED = 300.0
var _direction: Vector2


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(
		Input.get_axis("player_left", "player_right"),
		Input.get_axis("player_up", "player_down")
	)
	if direction.length() > 0:
		velocity = direction.normalized() * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

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

