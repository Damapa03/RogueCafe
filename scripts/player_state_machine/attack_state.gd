extends State
@onready var player_animation: AnimationPlayer = $"../../PlayerAnimation"
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer

@export var _attack_cooldown_duration: float = 0.5


func enter() -> void:
	if attack_cooldown_timer.time_left > 0:
		change_state.emit("IdleState")
		return
	player_animation.animation_finished.connect(_attack_animation_ended)
	player_animation.play("attack_animation")

func exit() -> void:
	if attack_cooldown_timer.time_left > 0:
		return
	player_animation.animation_finished.disconnect(_attack_animation_ended)
	player_animation.play("idle_animation")
	attack_cooldown_timer.wait_time = _attack_cooldown_duration
	attack_cooldown_timer.start()


func _attack_animation_ended(anim_name: String) -> void:
	if anim_name == "attack_animation":
		change_state.emit("IdleState")
