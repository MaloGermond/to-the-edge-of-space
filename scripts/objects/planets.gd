extends Node2D

@export var angular_speed = 0.001
@export var sprite: Sprite2D
@export var albedo_texture: Texture2D
# @export var normal_texture: Texture2D
	
func _ready():
	if albedo_texture:
		print(albedo_texture)
		sprite.texture.diffuse_texture = albedo_texture
	
func _process(delta: float) -> void:
	rotation += angular_speed
