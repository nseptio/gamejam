extends Control

@onready var start_button: Button = $MarginContainer/VBoxContainer/StartButton
@onready var quit_button: Button = $MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_game_pressed)
	quit_button.pressed.connect(_on_exit_pressed)
	start_button.grab_focus()


func _on_start_game_pressed() -> void:
	#LevelManager.load_new_level( 
		#"res://levels/area_01/A01.tscn",
		#"StartGate",
		#Vector2.ZERO
	#)
	get_tree().change_scene_to_file("res://GUI/main_menu/Story.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
