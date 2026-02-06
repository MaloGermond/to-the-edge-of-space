extends CharacterBody2D

@export var rotation_speed: float = 0.2  # Vitesse de rotation (radians/seconde)
@export var acceleration: float = 20.0  # Accélération (pixels/seconde²)
@export var max_speed: float = 500.0     # Vitesse maximale
@export var speed_line: Line2D
var thresholds_press = 200
var keyPressed = false

var velocity_vector: Vector2 = Vector2.ZERO
var rotation_vector: float = 0

func _physics_process(delta: float) -> void:
	handleSpeedVector()
	# Rotation (gauche/droite)
	if Input.is_action_just_pressed("ui_left"):
		rotation_vector -= rotation_speed * delta  # Sens horaire
	if Input.is_action_just_pressed("ui_right"):
		rotation_vector += rotation_speed * delta  # Sens anti-horaire

	# Accélération (avant/arrière, selon l'orientation du vaisseau)
	if Input.is_action_pressed("ui_up"):
		var direction := Vector2.UP.rotated(rotation)  # Direction "avant" = vers le haut
		velocity_vector += direction * acceleration * delta
		velocity_vector = velocity_vector.limit_length(max_speed)

	if Input.is_action_pressed("ui_down"):
		var direction := Vector2.UP.rotated(rotation)  # Direction "arrière" = opposée au haut
		velocity_vector -= direction * acceleration * delta
		velocity_vector = velocity_vector.limit_length(max_speed)


	velocity = velocity_vector
	rotation += rotation_vector
	
	if velocity.length() < acceleration/2:
		velocity = Vector2.ZERO

	# if rotation < rotation_speed/2:
	# 	rotation = 0

	move_and_slide()


func handleSpeedVector():
	var points = [position,position+velocity]
	speed_line.points = points
