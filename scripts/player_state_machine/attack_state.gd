extends State

@export var _attack_cooldown_duration: float = 0.5

@onready var player_animation: AnimationPlayer = $"../../PlayerAnimation"
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer


func _ready() -> void:
	player_animation.animation_finished.connect(_attack_animation_ended)


func enter() -> void:
	if attack_cooldown_timer.time_left > 0:
		_change_back_state()
		return
	player_animation.play("attack_animation")


func exit() -> void:
	if attack_cooldown_timer.time_left > 0:
		return
	player_animation.play("idle_animation")
	attack_cooldown_timer.wait_time = _attack_cooldown_duration
	attack_cooldown_timer.start()


func _attack_animation_ended(anim_name: String) -> void:
	if anim_name == "attack_animation":
		_change_back_state()


func _change_back_state() -> void:
	if Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")) == Vector2.ZERO:
		change_state.emit("IdleState")
	else:
		change_state.emit("WalkState")
