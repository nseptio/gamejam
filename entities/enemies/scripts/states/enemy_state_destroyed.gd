class_name EnemyStateDestroyed extends EnemyState

@export var animation_name: String = "destroyed"
@export var knockback_speed: float = 400.0
@export var decelerate_speed: float = 10.0

@export_category("AI")

var _direction: Vector2
var _damage_position: Vector2

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

# What happens if the player enter the state
func enter() -> void:
	enemy.is_invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * (-knockback_speed)
	
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()

# What happens if the player exit the state
func exit() -> void:
	pass


# What happens during _process update in this state?
func process(_delta: float) -> EnemyState:
	enemy.velocity = enemy.velocity * decelerate_speed * _delta
	return null


# What happens during _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> EnemyState:
	return null

func _on_animation_finished(_animation_name: String) -> void:
	enemy.queue_free()

func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)

func disable_hurt_box() -> void:
	var hurt_box: HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
