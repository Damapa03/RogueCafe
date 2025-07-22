extends State
@onready var player: CharacterBody2D = $"../.."
@onready var dash_duration_timer: Timer = $DashDurationTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

@export var _dash_speed: float = 800
@export var _dash_duration: float = 0.3
@export var _dash_cooldown: float = 3.0

var _dash_direction: Vector2


func enter() -> void:
	_dash_direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if dash_cooldown_timer.time_left > 0 and _dash_direction:
		change_state.emit("WalkState")
	elif dash_cooldown_timer.time_left > 0:
		change_state.emit("IdleState")
	
	dash_duration_timer.wait_time = _dash_duration
	dash_duration_timer.start()


func exit() -> void:
	if dash_cooldown_timer.time_left == 0:
		dash_cooldown_timer.wait_time = _dash_cooldown
		dash_cooldown_timer.start()


func update() -> void:
	if dash_duration_timer.time_left == 0:
		change_state.emit("WalkState")


func update_physics() -> void:
	player.velocity.x = _dash_direction.x * _dash_speed
	player.velocity.y = _dash_direction.y * _dash_speed
	player.move_and_slide()
