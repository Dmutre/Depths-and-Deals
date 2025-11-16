class_name Player
extends CharacterBody2D

# ========== SETTINGS ==========
@export var move_speed: float = 120.0
@export var min_cast_power: float = 1.0
@export var max_cast_power: float = 100.0
@export var charge_speed: float = 30.0 # how much cast power increases per second
@export var max_cast_distance: float = 100.0 # max distance user can throw cast (bobber)
@export var min_cast_distance: float = 40.0
@export var equipped_bobber_scene: PackedScene   # the bobber the player uses now
@export var bobber_lowering = 48 # Player height in pixels
var current_bobber: Bobber = null   # runtime instance

# ========== NODES ==========
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var walk_sprite: Sprite2D = $Walk_Sprite2D
@onready var fish_sprite: Sprite2D = $Fish_Sprite2D

# ========== STATE ==========
enum State { IDLE, MOVING, FISH_CHARGING, FISH_CASTING, FISHING }
var state: State = State.IDLE

var cast_power := 0.0
var last_direction := "down"
var was_moving := false

# ========== ANIMATIONS ==========
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

var fish_anims := {
	"down": "fish_down",
	"up": "fish_up",
	"left": "fish_left",
	"right": "fish_right",
}

# Sprites that can be toggled (others will remain untouched)
@export var switchable_sprites: Array[StringName] = [
	"Walk_Sprite2D",
	"Fish_Sprite2D"
]

# ========== PROCESS ==========
func _physics_process(delta):
	match state:
		State.FISH_CHARGING, State.FISH_CASTING, State.FISHING:
			# disable movement while fishing
			return
		_:
			_handle_movement(delta)

func _process(delta):
	_handle_fishing_input(delta)

# ========== MOVEMENT ==========
func _handle_movement(_delta):
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
		state = State.MOVING
		was_moving = true
		if abs(direction.x) > abs(direction.y):
			last_direction = "right" if direction.x > 0 else "left"
		else:
			last_direction = "down" if direction.y > 0 else "up"
		_play_walk(last_direction)
	else:
		if was_moving:
			was_moving = false
			state = State.IDLE
			anim.stop()
			walk_sprite.frame = stop_frames.get(last_direction, 0)

func _play_walk(dir: String) -> void:
	set_active_sprite("Walk_Sprite2D")
	var anim_name = walk_anims.get(dir, "")
	if anim_name != "" and anim.current_animation != anim_name:
		anim.play(anim_name)

# ========== FISHING ==========
func _handle_fishing_input(delta):
	
	# =====================
	# START CAST (press)
	# =====================
	if Input.is_action_just_pressed("mouse_left") and state == State.IDLE:
		state = State.FISH_CHARGING
		cast_power = min_cast_power
		set_active_sprite("Fish_Sprite2D")

		var anim_name = fish_anims.get(last_direction, "")
		anim.play(anim_name)
		anim.pause()
		anim.seek(0.1)

		print("Started charging cast...")
		return

	# =====================
	# CHARGING
	# =====================
	if state == State.FISH_CHARGING and Input.is_action_pressed("mouse_left"):
		cast_power = min(cast_power + charge_speed * delta, max_cast_power)
		print("Charging: %.2f" % cast_power)
		return

	# =====================
	# RELEASE → CASTING
	# =====================
	if state == State.FISH_CHARGING and Input.is_action_just_released("mouse_left"):
		state = State.FISH_CASTING
		anim.play() # resume animation
		print("Casting with power %.2f" % cast_power)

		await anim.animation_finished

		_finish_fishing_casting_and_wait()
		return

	# =====================
	# SECOND CLICK → RETRIEVE
	# =====================
	if state == State.FISHING and Input.is_action_just_pressed("mouse_left"):
		print("Retrieving bobber...")

		_despawn_bobber()

		# TODO: play retrieve animation
		set_active_sprite("Walk_Sprite2D")

		state = State.IDLE
		return

func _finish_fishing_casting_and_wait():
	# set fishing sprite, user remains in last frame fishing animation and waits for fish
	state = State.FISHING

	var spawn_pos = _get_bobber_cast_position()
	_spawn_bobber_at(spawn_pos)

	print("Bobber spawned. Waiting for fish...")
	
func _spawn_bobber_at(spawn_position: Vector2):
	if not equipped_bobber_scene:
		push_error("No bobber assigned!")
		return

	if current_bobber:
		current_bobber.despawn()

	var bobber := equipped_bobber_scene.instantiate()

	# IMPORTANT: pass the target scene
	var scene = get_tree().current_scene

	bobber.spawn_at(spawn_position, scene)

	current_bobber = bobber
	print("Bobber spawned at:", spawn_position)
	
func _despawn_bobber():
	if current_bobber:
		current_bobber.despawn()
		return;
		
func _get_bobber_cast_position() -> Vector2:
	var power_ratio: float = cast_power / max_cast_power
	var distance: float = power_ratio * max_cast_distance

	distance = clamp(distance, min_cast_distance, max_cast_distance)

	var offset := Vector2.ZERO
	# we are lowering bobber to be in user foot height
	var lowering_height: float = bobber_lowering * 0.25

	match last_direction:
		"up":
			offset = Vector2(0, -distance)
		"down":
			offset = Vector2(0, distance)
		"left":
			offset = Vector2(-distance, lowering_height)
		"right":
			offset = Vector2(distance, lowering_height)

	return global_position + offset

# ========== SPRITE CONTROL ==========
# Called from AnimationPlayer to enable only the desired sprite
func set_active_sprite(active_name: String):
	for child in get_children():
		if child is Sprite2D and child.name in switchable_sprites:
			child.visible = child.name == active_name
