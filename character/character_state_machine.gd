class_name CharStateMachine
extends Node

@export var initial_state: CharacterState
var character: Character
var current_state: CharacterState

func _ready() -> void:
	character = get_parent()
	for child in get_children():
		if child is not CharacterState: continue
		child.character = character
		child.state_machine = self
	change_state(initial_state)

func change_state(new_state: CharacterState) -> void:
	if new_state == null or new_state == current_state: return
	current_state.exit()
	current_state = new_state
	current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state != null:
		current_state.physics_process(delta)
