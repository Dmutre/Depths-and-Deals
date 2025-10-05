class_name Player extends CharacterBody2D

@export var move_speed: float = 120.0

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1

	direction = direction.normalized()
	velocity = direction * move_speed
	move_and_slide()
