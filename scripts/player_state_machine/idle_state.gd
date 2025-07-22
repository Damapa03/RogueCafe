extends State

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	if Input.is_action_just_pressed("attack"):
		change_state.emit("AttackState")

func update_physics() -> void:
	var direction: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	if direction:
		change_state.emit("WalkState")
