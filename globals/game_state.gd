extends Node

signal item_collected(item_id: String)

var picked_up_items := {} # Dictionary[string]bool

func is_item_collected(item_id: String) -> bool:
	return picked_up_items.has(item_id)

func mark_item_collected(item_id: String) -> void:
	if picked_up_items.has(item_id):
		return
	picked_up_items[item_id] = true
	emit_signal("item_collected", item_id)
