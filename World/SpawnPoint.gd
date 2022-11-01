extends Node2D

onready var visibility = $VisibilityNotifier2D

func _ready():
	if not visibility.is_on_screen():
		add_to_group("eligible_spawnpoints")

func _on_screen_entered():
	remove_from_group("eligible_spawnpoints")

func _on_screen_exited():
	add_to_group("eligible_spawnpoints")
