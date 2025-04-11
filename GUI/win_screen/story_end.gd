extends Control

@onready var main_menu_button: Button = $MainMenuButton

func _ready() -> void:
	main_menu_button.pressed.connect(_on_start_game_pressed)
	main_menu_button.grab_focus()


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI/main_menu/MainMenu.tscn")
