extends State
@onready var player: CharacterBody2D = $"../.."
const SPEED: float = 300.0

func enter() -> void:
	pass


func exit() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	player.velocity.y = move_toward(player.velocity.y, 0, SPEED)

func update() -> void:
	if Input.is_action_just_pressed("attack"):
		change_state.emit("AttackState")

func update_physics() -> void:
	var direction: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if !direction:
		change_state.emit("IdleState")
		return
	
	if Input.is_action_just_pressed("dash"):
		change_state.emit("DashState")
	
	player.velocity.x = direction.x * SPEED
	player.velocity.y = direction.y * SPEED
	player.move_and_slide()
