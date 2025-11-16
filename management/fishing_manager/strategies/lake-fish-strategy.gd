class_name LakeFishStrategy
extends FishingStrategy

func pick_fish(fish_pool: Array, context: Dictionary) -> Dictionary:
	var bobber := context.get("bobber")
	var result_weights := {}

	for fish in fish_pool:
		var weight := fish["rarity_weight"]

		# Bobber affects bite chance globally
		if bobber:
			weight *= bobber.bite_chance_multiplier

		result_weights[fish] = weight

	return _weighted_random(result_weights)


func _weighted_random(weights: Dictionary) -> Dictionary:
	var total := 0.0
	for w in weights.values():
		total += w

	var rnd := randf() * total
	var cumulative := 0.0

	for fish in weights.keys():
		cumulative += weights[fish]
		if rnd <= cumulative:
			return fish

	return weights.keys()[0] # fallback
