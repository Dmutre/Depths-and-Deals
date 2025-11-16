class_name FishingFactory
extends Node

signal fish_bite_started(player)
signal fish_caught(player, fish_data)

var strategy: FishingStrategy = LakeFishStrategy.new()
var bite_timer := Timer.new()

func _ready():
	add_child(bite_timer)
	bite_timer.one_shot = true
	bite_timer.connect("timeout", Callable(self, "_on_bite_timeout"))

	print("FishingFactory ready.")


# Called by Player when bobber dropped
func start_fishing(player: Node, bobber, cast_power_ratio: float):
	var bite_time := randf_range(1.0, 3.0) # later depends on bobber

	bite_timer.start(bite_time)

	# Save context for later
	bite_timer.set_meta("player", player)
	bite_timer.set_meta("bobber", bobber)
	bite_timer.set_meta("power", cast_power_ratio)

	print("Fishing started, bite in:", bite_time)


func _on_bite_timeout():
	var player = bite_timer.get_meta("player")
	var bobber = bite_timer.get_meta("bobber")
	var power = bite_timer.get_meta("power")

	# Prepare context
	var ctx = {
		"bobber": bobber,
		"power": power
	}

	var fish_data = strategy.pick_fish(load("res://fishing/data/fish_database.gd").FISH_POOL, ctx)

	emit_signal("fish_bite_started", player)
	emit_signal("fish_caught", player, fish_data)
