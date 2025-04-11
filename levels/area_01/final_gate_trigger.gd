extends Area2D

var gate_removed = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player") and not gate_removed:
		remove_final_gate()

func remove_final_gate():
	var final_gate = get_parent().get_node_or_null("FinalGate")
	if final_gate != null:
		gate_removed = true
		print("Gate removed!")
		final_gate.queue_free()
	else:
		print("Final Gate not found or already removed")
