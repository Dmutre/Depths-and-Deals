class_name Bobber
extends Node2D

# ========== CONFIGURABLE STATS ==========
@export var rarity_multiplier: float = 1.0   # affects fish rarity chances
@export var bite_chance_multiplier: float = 1.0
@export var size_factor: float = 1.0         # visual or gameplay size impact

var target_scene: Node = null

# ========== SPAWN & DESPAWN ==========
func spawn_at(position: Vector2, scene: Node) -> void:
	target_scene = scene

	# Add bobber into the scene if not yet added
	if not is_inside_tree():
		target_scene.add_child(self)

	global_position = position
	_on_spawned()

func despawn() -> void:
	_on_despawn()
	queue_free()

# ========== HOOK METHODS FOR CHILD CLASSES ==========
func _on_spawned() -> void:
	pass

func _on_despawn() -> void:
	pass
