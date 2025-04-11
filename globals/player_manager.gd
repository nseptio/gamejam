extends Node
const PLAYER = preload("res://entities/player/Player.tscn")
const INVENTORY_DATA: InventoryData = preload("res://GUI/pause_menu/inventory/player_inventory.tres")
var player: Player
var is_player_spanwed: bool = false

func _ready() -> void:
	if get_tree().current_scene.name == "MainMenu":
		return
	if get_tree().current_scene.name == "GameOver":
		return
	if get_tree().current_scene.name == "Story":
		return
	
	print(get_tree().current_scene.name)
	add_player_instance()
	await get_tree().create_timer(0.5).timeout
	is_player_spanwed = true

func add_player_instance() -> void:
	print("Adding player instance")
	player = PLAYER.instantiate()
	add_child(player)
	print("Player added to scene")
	
func set_player_position(_new_pos: Vector2) -> void:
	if player == null:
		add_player_instance()
		is_player_spanwed = true
	print("Setting player position to: ", _new_pos)
	player.global_position = _new_pos

func set_as_parent(_parent: Node2D) -> void:
	if player == null:
		add_player_instance()
		is_player_spanwed = true
	if player.get_parent():
		player.get_parent().remove_child(player)
	_parent.add_child(player)

func unparent_player(_parent: Node2D) -> void:
	_parent.remove_child(player)
