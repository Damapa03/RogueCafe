extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	if Input.is_action_just_pressed("attack") and player.can_attack:
		change_state.emit("AttackState")

func update_physics() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.movement_speed)
	player.velocity.y = move_toward(player.velocity.y, 0, player.movement_speed)
	var direction: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if direction:
		change_state.emit("WalkState")
