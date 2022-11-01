extends Node

export (PackedScene) var to_instance
export var spawn_cap = 20

onready var timer = $Timer

func _ready():
	start_timer()

func start_timer():
	# Random wait time
	var wait = 3
	timer.wait_time = wait
	timer.start()

func _on_timeout():
	# Don't spawn if enemy cap reached
	if (get_tree().get_nodes_in_group("enemies").size() < spawn_cap):
		# Find random visible spawnpoint, if one exists
		var spawnpoints = get_tree().get_nodes_in_group("eligible_spawnpoints")
		if spawnpoints.size() > 0:
			var spawnpoint = spawnpoints[randi() % spawnpoints.size()]
			# Create baddie and set position
			var to_spawn = to_instance.instance()
			to_spawn.global_position = spawnpoint.global_position
			# Add as sibling
			get_parent().add_child(to_spawn)
	# Reset timer
	start_timer()
