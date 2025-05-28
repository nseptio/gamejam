extends Node2D

var required_gems := [
	"gem-1",
	"gem-2",
	"gem-3"
]

func _ready() -> void:
	GameState.item_collected.connect(_on_item_collected)
	_check_and_open_gate()

func _on_item_collected(item_id: String) -> void:
	if item_id in required_gems:
		_check_and_open_gate()

func _check_and_open_gate() -> void:
	for gem_id in required_gems:
		if not GameState.is_item_collected(gem_id):
			return
	_open_gate()

func _open_gate() -> void:
	if not is_inside_tree():
		return
	print("All gems collected! Opening final gate...")
	queue_free()
