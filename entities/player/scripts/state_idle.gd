class_name State_Idle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

# What happens if the player enter the state
func enter() -> void:
	player.update_animation("idle")


# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null


## What happens during _physics_process update in this state?
func physics(_delta: float) -> State:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
