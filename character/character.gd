class_name Character
extends CharacterBody2D

@export var move_duration = 0.3

var selected = true
var path : Array[Vector2]

@onready var state_machine: CharStateMachine = %StateMachine
@onready var idle_state: CharacterState = %IdleState
@onready var move_state: CharacterState = %MoveState

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	_left_click(event)

func _left_click(event: InputEvent):
	if not selected: return
	if event is not InputEventMouseButton: return
	if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		path = Grid.get_world_path(global_position, get_global_mouse_position())
		move_state.update_path(path)
		state_machine.change_state(move_state)
