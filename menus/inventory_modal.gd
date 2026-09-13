@tool
extends Modal

@onready var main_weapon_box: PanelContainer = %MainWeaponBox
@onready var slot_1_box: PanelContainer = %Slot1Box
@onready var slot_2_box: PanelContainer = %Slot2Box
@onready var slot_3_box: PanelContainer = %Slot3Box

func _ready() -> void:
	super()
	main_weapon_box.item = Utils.game_data.main_weapon
