class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var is_invulnerable: bool = false

@export var hp: int = 6
@export var max_hp: int = 6

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var blink_effect: AnimationPlayer = $BlinkEffect

@onready var hit_box: HitBox = $HitBox
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine


signal direction_changed(new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

func _ready() -> void:
	PlayerManager.player = self
	state_machine.initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_hp(99) # temp


# Called every frame
func _process(_delta: float) -> void:
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()


func _physics_process(_delta: float) -> void:
	# Move the player
	move_and_slide()


func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() /  TAU * DIR_4.size()))
	var new_direction: Vector2 = DIR_4[direction_id]
	
	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func update_animation(state: String) -> void:
	animation_player.play(state + "_" + animation_direction())


func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	return "side"

func _take_damage(hurt_box: HurtBox) -> void:
	if is_invulnerable:
		return
	update_hp(-hurt_box.damage)
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_hp(99) # temp

func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)

func make_invulnerable(_duration: float = 1.0) -> void:
	is_invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	is_invulnerable = false
	hit_box.monitoring = true
