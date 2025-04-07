class_name EnemyState extends Node

var enemy: Enemy
var state_machine: EnemyStateMachine

func _ready() -> void:
	pass

func init() -> void:
	pass

# What happens if the player enter the state
func enter() -> void:
	pass


# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> EnemyState:
	
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> EnemyState:
	return null
