class_name EnemyStateWander extends EnemyState

@export var animation_name: String = "walk"
@export var wander_speed: float = 20.0

@export_category("AI")
@export var state_animation_duration: float = 0.5
@export var state_cycle_min: int = 1
@export var state_cycle_max: int = 3
@export var next_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

func init() -> void:
	pass

# What happens if the player enter the state
func enter() -> void:
	_timer = randi_range(state_cycle_min, state_cycle_max) * state_animation_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(animation_name)

# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> EnemyState:
	return null
