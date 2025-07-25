extends State

var _player_states: Dictionary[String, State]
var _active_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			_player_states[child.name] = child
			child.change_state.connect(_change_player_state)
	print(_player_states)
	_active_state = _player_states["IdleState"]


func _process(delta: float) -> void:
	_active_state.update()


func _physics_process(delta: float) -> void:
	_active_state.update_physics()


func _change_player_state(new_state_name: String) -> void:
	var new_state: State = _player_states.get(new_state_name)
	if new_state == null:
		print("El estado del Player: " + new_state_name + " no existe")
		return
	
	if new_state == _active_state:
		return
	
	_active_state.exit()
	_active_state = new_state
	_active_state.enter()
	print(_active_state)
