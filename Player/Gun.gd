extends Node2D

onready var anim_player = $AnimationPlayer
onready var audio_player = $AudioStreamPlayer2D

export var _range = 500
export var damage = 10

func _input(event):
	if event.is_action_pressed("fire"):
		audio_player.play()
		anim_player.play("Fire")
		# Calculate ray direction
		var ray_dir = Vector2(cos(global_rotation), sin(global_rotation))
		var ray_target = global_position + _range * ray_dir
		# Cast ray
		var space = get_world_2d().direct_space_state
		var result = space.intersect_ray(global_position, ray_target)
		# If hit something, alert the hit object
		if not result.empty():
			var collider = result["collider"]
			if collider.has_method("attacked"):
				collider.attacked(damage)
