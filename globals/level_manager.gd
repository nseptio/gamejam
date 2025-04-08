extends Node
var current_tilemap_bounds: Array[Vector2]
signal tilemap_bounds_changed(bounds: Array[Vector2])

func _ready() -> void:
	print("LevelManager ready")
	# Print the number of connections to our signal
	print("Initial signal connections: ", get_signal_connection_list("tilemap_bounds_changed").size())

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	print("LevelManager: Changing Camera Bounds: ", bounds)
	current_tilemap_bounds = bounds
	print("Connections before emit: ", get_signal_connection_list("tilemap_bounds_changed").size())
	tilemap_bounds_changed.emit(bounds)
	print("Signal emitted")
