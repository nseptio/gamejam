class_name Plant extends Node

func _ready() -> void:
	$HitBox.Damaged.connect(_take_damage)

func _take_damage(_hurt_box: HurtBox) -> void:
	queue_free()
