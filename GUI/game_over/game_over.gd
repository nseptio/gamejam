extends Control

@onready var main_menu_button: Button = $MarginContainer/VBoxContainer/MainMenuButton
@onready var quit_button: Button = $MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	main_menu_button.pressed.connect(_on_start_game_pressed)
	quit_button.pressed.connect(_on_exit_pressed)
	main_menu_button.grab_focus()


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI/main_menu/MainMenu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
