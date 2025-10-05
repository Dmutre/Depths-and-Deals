class_name Player
extends CharacterBody2D

@export var move_speed: float = 120.0
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var last_direction := "down"
var was_moving := false

var stop_frames := {
	"down": 0,
	"up": 16,
	"left": 12,
	"right": 8,
}

var walk_anims := {
	"down": "walk_down",
	"up": "walk_up",
	"left": "walk_left",
	"right": "walk_right",
}

func _physics_process(_delta):
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

	if direction != Vector2.ZERO:
		was_moving = true
		if abs(direction.x) > abs(direction.y):
			last_direction = "right" if direction.x > 0 else "left"
		else:
			last_direction = "down" if direction.y > 0 else "up"
		_play_walk(last_direction)
	else:
		if was_moving:
			was_moving = false
			anim.stop()
			sprite.frame = stop_frames.get(last_direction, 0)

func _play_walk(dir: String) -> void:
	var anim_name = walk_anims.get(dir, "")
	if anim_name != "" and anim.current_animation != anim_name:
		anim.play(anim_name)
