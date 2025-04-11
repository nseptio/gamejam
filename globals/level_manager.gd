extends Node

signal tilemap_bounds_changed(bounds: Array[Vector2])
signal level_load_started
signal level_loaded

var current_tilemap_bounds: Array[Vector2]
var target_transition: String
var position_offset: Vector2

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()


func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	print("LevelManager: Changing Camera Bounds: ", bounds)
	current_tilemap_bounds = bounds
	print("Connections before emit: ", get_signal_connection_list("tilemap_bounds_changed").size())
	tilemap_bounds_changed.emit(bounds)
	print("Signal emitted")

func load_new_level(
	level_path: String,
	_target_transition: String,
	_position_offset: Vector2
) -> void:
	
	print("Starting load new level...")
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out()
	level_load_started.emit()
	
	await get_tree().process_frame
	get_tree().change_scene_to_file(level_path)
	print("Set level to: ", level_path)
	
	await SceneTransition.fade_in()
	get_tree().paused = false
	
	await get_tree().process_frame
	level_loaded.emit()
