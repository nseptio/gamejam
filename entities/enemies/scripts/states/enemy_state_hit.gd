class_name EnemyStateHit extends EnemyState

@export var animation_name: String = "hit"
@export var knockback_speed: float = 400.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var next_state: EnemyState

var _damage_position: Vector2
var _direction: Vector2
var _is_animation_finished: bool = false

func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

# What happens if the player enter the state
func enter() -> void:
	enemy.is_invulnerable = true
	_is_animation_finished = false
	
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * (-knockback_speed)
	
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)

# What happens if the player exit the state
func exit() -> void:
		enemy.is_invulnerable = false
		enemy.animation_player.animation_finished.disconnect(_on_animation_finished)


# What happens during _process update in this state?
func process(_delta: float) -> EnemyState:
	if _is_animation_finished:
		return next_state
	enemy.velocity = enemy.velocity * decelerate_speed * _delta
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> EnemyState:
	return null

func _on_enemy_damaged(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)

func _on_animation_finished(_animation_name: String) -> void:
	_is_animation_finished = true
