class_name Character
extends CharacterBody2D

@export var move_duration = 0.3

var selected = true
var player_char = true

@onready var state_machine: CharStateMachine = %StateMachine
@onready var idle_state: CharacterState = %IdleState
@onready var move_state: CharacterState = %MoveState

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func select():
	if not player_char: return
	selected = true
	print('selected')
