extends KinematicBody2D

export var walk_speed = 60.0
export var turn_rate = 0.04

onready var nav = $NavigationAgent2D

func _physics_process(delta):
	# Find target
	var targets = get_tree().get_nodes_in_group("enemy_targets")
	
	# If target exists, find closest
	if targets.size() > 0:
		
		var closest = targets[0]
		var closest_dist = global_position.distance_squared_to(closest.global_position)
		for target in targets.slice(1, targets.size() - 1):
			var dist = global_position.distance_squared_to(target.global_position)
			if dist < closest_dist:
				closest = target
				closest_dist = dist
		
		# Update navigation target
		nav.set_target_location(closest.global_position)
		
		var move_dir = Vector2(cos(global_rotation), sin(global_rotation))
		
		# Update rotation (Zombies turn slowly...)
		var target_dir = (nav.get_next_location() - global_position).normalized()
		var angle_diff = move_dir.angle_to(target_dir)
		global_rotation += sign(angle_diff) * min(abs(angle_diff), turn_rate)
		
		# Move forward
		var move = walk_speed * max(0.0, move_dir.dot(target_dir)) * move_dir
		move_and_slide(move)
