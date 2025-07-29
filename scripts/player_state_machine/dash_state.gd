extends State

var _dash_direction: Vector2

@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer


func _ready() -> void:
	dash_duration_timer.timeout.connect(_change_back_state)
	dash_cooldown_timer.timeout.connect(_enable_player_dash)


func enter() -> void:
	player.can_dash = false
	_dash_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	_setup_timer(dash_duration_timer, player.dash_duration)


func exit() -> void: 
	_setup_timer(dash_cooldown_timer, player.dash_cooldown)


func update() -> void:
	pass


func update_physics() -> void:
	player.velocity = _dash_direction * player.dash_speed


func _setup_timer(timer: Timer, wait_time: float) -> void:
	timer.wait_time = wait_time
	timer.start()


func _enable_player_dash() -> void:
	player.can_dash = true


func _change_back_state() -> void:
	if Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")) == Vector2.ZERO:
		change_state.emit("IdleState")
	else:
		change_state.emit("WalkState")
