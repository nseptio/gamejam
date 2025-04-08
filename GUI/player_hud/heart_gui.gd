class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var value: int = 2:
	set(_value):
		value = _value
		_update_sprite()

func _update_sprite() -> void:
	sprite.frame = value
