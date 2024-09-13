extends CharacterBody2D

@onready var _hud = get_tree().get_first_node_in_group("Hud")
@onready var AS = $AnimatedSprite2D
@onready var rate_persuation_level := 1.0 / get_tree().get_first_node_in_group("NPCs").get_child_count()
@export var persuation_level := 1.0

@export var speed = 300.0
@export var success_particles: GPUParticles2D
@export var fail_particles: GPUParticles2D

var points := 0

var _direction: Vector2


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(
		Input.get_axis("player_left", "player_right"),
		Input.get_axis("player_up", "player_down") / 2,
	)
	if direction.length() > 0:
		velocity = direction.normalized() * speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	_animate()
	move_and_slide()

func successful_persuade() -> void:
	if _hud.lives_bar.value >= _hud.lives_bar.max_value * (persuation_level / _hud.persuation_bar.max_value):
		persuation_level += 1

	if success_particles:
		if _hud:
			_hud.set_persuation(persuation_level)
		success_particles.emitting = true

func fail_persuade() -> void:
	persuation_level *= 1 + -rate_persuation_level
	if persuation_level < 1:
		persuation_level = 1
	if fail_particles:
		if _hud:
			_hud.set_persuation(persuation_level)
		fail_particles.emitting = true

func _animate() -> void:
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
