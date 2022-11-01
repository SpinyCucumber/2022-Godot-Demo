extends KinematicBody2D

enum Action { IDLE, WALK, SPRINT }

const move_inputs = ["move_down", "move_up", "move_right", "move_left"]
const action_to_anim = {
	Action.IDLE: "Idle",
	Action.WALK: "Walk",
	Action.SPRINT: "Sprint"
}

export var walk_speed = 100.0
export var sprint_speed = 200.0

onready var anim_player = $AnimationPlayer;

var curr_action = Action.IDLE;

func _physics_process(delta):
	# Update rotation
	global_rotation = get_global_mouse_position().angle_to_point(global_position)
	# Determine if walking
	var action = Action.IDLE
	for input in move_inputs:
		if Input.is_action_pressed(input):
			action = Action.WALK
			break
	# If walking and holding sprint input, is actually sprinting
	if action == Action.WALK:
		var speed = walk_speed
		if Input.is_action_pressed("sprint"):
			action = Action.SPRINT
			speed = sprint_speed
		# Calculate movement
		var move_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		var move_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		var move = speed * Vector2(move_x, move_y).normalized()
		# Apply movement
		move_and_slide(move)
	# If action is different from current action, update animation
	if action != curr_action:
		anim_player.play(action_to_anim[action])
	curr_action = action
