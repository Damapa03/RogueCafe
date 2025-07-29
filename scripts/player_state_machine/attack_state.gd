extends State

@onready var player_animation: AnimationPlayer = $"../../PlayerAnimation"
@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer


func _ready() -> void:
	player_animation.animation_finished.connect(_attack_animation_ended)
	attack_cooldown_timer.timeout.connect(_enable_player_attack)


func enter() -> void:
	player.can_attack = false
	player_animation.play("attack_animation")


func exit() -> void:
	player_animation.play("idle_animation")
	attack_cooldown_timer.wait_time = player.attack_cooldown_duration
	attack_cooldown_timer.start()


func update() -> void:
	if Input.is_action_just_pressed("dash") and player.can_dash:
		change_state.emit("DashState")


func _attack_animation_ended(anim_name: String) -> void:
	if anim_name == "attack_animation":
		_change_back_state()


func _enable_player_attack() -> void:
	player.can_attack = true


func _change_back_state() -> void:
	if Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")) == Vector2.ZERO:
		change_state.emit("IdleState")
	else:
		change_state.emit("WalkState")
