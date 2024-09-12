extends CanvasLayer

@onready var persuation_bar = %Persuation_ProgressBar
@onready var lives_bar = %Lives_ProgressBar
@onready var time_bar = %Time_ProgressBar

func _ready() -> void:
	lives_bar.max_value = get_tree().get_first_node_in_group("NPCs").get_child_count()

func _process(_delta: float) -> void:
	if lives_bar:
		if lives_bar.value >= lives_bar.max_value:
			get_tree().change_scene_to_file("res://Stages/SavedEruption/MainSavedEruption.tscn")

func set_persuation(x: int) -> void:
	if persuation_bar:
		persuation_bar.value = x

func add_life() -> void:
	if lives_bar:
		lives_bar.value += 1

func decrease_time() -> void:
	if time_bar:
		time_bar.value -= 1
	if time_bar.value <= time_bar.min_value:
		get_tree().change_scene_to_file("res://Stages/Eruption/MainEruption.tscn")

func _on_count_down_timeout() -> void:
	decrease_time()
	pass
	
