extends State
@onready var player_animation: AnimationPlayer = $"../../PlayerAnimation"

func enter() -> void:
	player_animation.animation_finished.connect(_attack_animation_ended)
	player_animation.play("attack_animation")

func exit() -> void:
	player_animation.animation_finished.disconnect(_attack_animation_ended)
	player_animation.play("idle_animation")


func _attack_animation_ended(anim_name: String) -> void:
	if anim_name == "attack_animation":
		change_state.emit("IdleState")
