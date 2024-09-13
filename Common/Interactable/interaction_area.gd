extends Area2D
class_name InteractionArea

@export var action_name = "interact"

var interact: Callable = func():
	print("missing an interact fn")


func _on_body_exited(_body: Node2D) -> void:
	InteractionManager.unregister_area(self)

func _on_body_entered(_body: Node2D) -> void:
	InteractionManager.register_area(self)

