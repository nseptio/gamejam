class_name EnemyStateIdle extends EnemyState

@export var animation_name: String = "idle"

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var after_idle_state: EnemyState

var _timer: float = 0.0

func init() -> void:
	pass

# What happens if the player enter the state
func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.update_animation(animation_name)


# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> EnemyState:
	return null
