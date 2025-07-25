extends State

@export var _movement_speed: float = 300.0

@onready var player: CharacterBody2D = $"../.."


func enter() -> void:
	pass


func exit() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, _movement_speed)
	player.velocity.y = move_toward(player.velocity.y, 0, _movement_speed)


func update() -> void:
	if Input.is_action_just_pressed("attack"):
		change_state.emit("AttackState")
	
	if Input.is_action_just_pressed("dash"):
		change_state.emit("DashState")


func update_physics() -> void:
	var direction: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if !direction:
		change_state.emit("IdleState")
		return
	
	player.velocity = direction * _movement_speed
