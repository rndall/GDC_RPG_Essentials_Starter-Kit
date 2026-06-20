class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State:
	set(new_value):
		current_state = new_value
		#if owner is Enemy:
			#print("Changed to %s" % current_state.name)
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transitioned)
	
	if initial_state:
		await owner.ready
		initial_state.enter()
		current_state = initial_state
 

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _on_child_transitioned(state: State, new_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state


func force_change_state(new_state_name: String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	if new_state and current_state != new_state:
		if current_state:
			current_state.exit()
		new_state.enter()
		current_state = new_state
