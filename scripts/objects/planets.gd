extends Node2D

@export var angular_speed = 0.001
	
func _process(delta: float) -> void:
	rotation += angular_speed
