extends State


func enter() -> void:
	pass


func exit() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.movement_speed)
	player.velocity.y = move_toward(player.velocity.y, 0, player.movement_speed)


func update() -> void:
	if Input.is_action_just_pressed("attack") and player.can_attack:
		change_state.emit("AttackState")
	
	if Input.is_action_just_pressed("dash") and player.can_dash:
		change_state.emit("DashState")


func update_physics() -> void:
	var direction: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	direction = direction.normalized()
	player.velocity = direction * player.movement_speed
	if !direction:
		change_state.emit("IdleState")
