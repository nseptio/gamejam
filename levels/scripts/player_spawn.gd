extends Node2D


func _ready() -> void:
	print("PlayerSpawn ready at position: ", global_position)
	visible = false
	if !PlayerManager.is_player_spanwed:
		print("Player not spawned yet, setting position")
		PlayerManager.set_player_position(global_position)
		PlayerManager.is_player_spanwed = true
		print("Player spawned")
