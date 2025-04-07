class_name State extends Node

# Stores a reference to player that this state belongs to
static var player: Player
static var state_machine: PlayerStateMachine


func _ready() -> void:	
	pass


# What happens if the player enter the state
func enter() -> void:
	pass


# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> State:
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> State:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> State:
	return null
