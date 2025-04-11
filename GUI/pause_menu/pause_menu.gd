extends CanvasLayer

signal show
signal hidden

@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer
@onready var button_main_menu: Button = $Control/HBoxContainer/Button_MainMenu
@onready var button_exit: Button = $Control/HBoxContainer/Button_Exit
@onready var item_description: Label = $Control/ItemDescription

var is_paused: bool = false

func _ready() -> void:
	hide_pause_menu()
	
	button_main_menu.pressed.connect(_on_main_menu_pressed)
	button_exit.pressed.connect(_on_exit_pressed)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !is_paused:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	show.emit()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()

func _on_main_menu_pressed() -> void:
	if !is_paused:
		return
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # TODO

func _on_exit_pressed() -> void:
	if !is_paused:
		return
	
	get_tree().quit()
	hide_pause_menu()

func update_item_description(description: String) -> void:
	item_description.text = description

func play_audio(audio: AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
