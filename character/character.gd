class_name Character
extends CharacterBody2D

@export var move_duration = 0.3

var selected = true
var player_char = true

@onready var selection_frame: Line2D = %SelectionFrame
@onready var state_machine: CharStateMachine = %StateMachine
@onready var idle_state: CharacterState = %IdleState
@onready var move_state: CharacterState = %MoveState

func _ready() -> void:
	GlobalSignals.deselect_all.connect(_deselect)
	GlobalSignals.move_command.connect(_on_move_command)
	_deselect()

func _physics_process(delta: float) -> void:
	pass

func _deselect():
	selected = false
	selection_frame.visible = selected

func _on_move_command(target: Vector2):
	if not selected: return
	print(target)

func select():
	if not player_char: return
	selected = true
	selection_frame.visible = selected
