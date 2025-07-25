extends State

@export var _dash_speed: float = 800
@export var _dash_duration: float = 0.3
@export var _dash_cooldown: float = 3.0

var _dash_direction: Vector2

@onready var player: CharacterBody2D = $"../.."
@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

func _ready() -> void:
	dash_duration_timer.timeout.connect(_change_back_state)


func enter() -> void:
	if !_player_can_dash():
		_change_back_state()
		return
	
	_dash_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	_setup_timer(dash_duration_timer, _dash_duration)


func exit() -> void: 
	if _player_dashed():
		_setup_timer(dash_cooldown_timer, _dash_cooldown)


func update() -> void:
	pass


func update_physics() -> void:
	player.velocity = _dash_direction * _dash_speed


func _player_can_dash() -> bool:
	return dash_cooldown_timer.is_stopped()


func _player_dashed() -> bool:
	return dash_duration_timer.is_stopped() and dash_cooldown_timer.is_stopped()


func _setup_timer(timer: Timer, wait_time: float) -> void:
	timer.wait_time = wait_time
	timer.start()


func _change_back_state() -> void:
	if Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")) == Vector2.ZERO:
		change_state.emit("IdleState")
	else:
		change_state.emit("WalkState")
