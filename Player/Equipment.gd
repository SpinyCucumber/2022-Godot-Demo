extends Node

export (PackedScene) var to_instance
export (Texture) var player_texture

var instance
var prev_texture

func equip(player):
	# Instance scene
	instance = to_instance.instance()
	player.sprite.add_child(instance)
	# Change texture
	prev_texture = player.sprite.texture
	player.sprite.texture = player_texture

func unequip(player):
	# Remove instanced scene
	player.sprite.remove_child(instance)
	# Revert texture
	player.sprite.texture = prev_texture
