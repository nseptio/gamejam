extends Control

@onready var start_button: Button = $StartButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_game_pressed)
	start_button.grab_focus()

func _on_start_game_pressed() -> void:
	LevelManager.load_new_level( 
		"res://levels/area_01/A01.tscn",
		"StartGate",
		Vector2.ZERO
	)
	#get_tree().change_scene_to_file("res://levels/area_01/A01.tscn")
