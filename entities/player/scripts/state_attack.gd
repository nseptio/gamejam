class_name State_Attack extends State

var is_attacking: bool = false

@export var attack_audio: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var attack_audio_player: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func init() -> void:
	pass

# What happens if the player enter the state
func enter() -> void:
	player.update_animation("attack")
	attack_animation.play("attack_" + player.animation_direction())
	animation_player.animation_finished.connect(_end_attack)
	
	attack_audio_player.stream = attack_audio
	attack_audio_player.pitch_scale = randf_range(0.9, 1.1)
	attack_audio_player.play()
	
	is_attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true


# What happens if the player exit the state
func exit() -> void:
	animation_player.animation_finished.disconnect(_end_attack)
	hurt_box.monitoring = false
	is_attacking = false


# What happens during _process update in this state?
func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if !is_attacking:
		if player.direction == Vector2.ZERO:
			return idle
		return walk
	return null


## What happens during _physics_process update in this state?
func physics(_delta: float) -> State:
	return null


# What happens during input events update in this state?
func handle_input(_event: InputEvent) -> State:
	return null

func _end_attack( _newAnimationName: String) -> void:
	is_attacking = false
