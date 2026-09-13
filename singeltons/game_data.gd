extends Resource
class_name GameData

@export_storage var health_max := 10
@export_storage var health_current := health_max

# ================================ inventory
@export_storage var main_weapon := preload("uid://cy0meaiqukmuc")
@export_storage var secondary_weapon := preload("uid://c3umjnbpi7bwk")
@export_storage var slot_1: Item
@export_storage var slot_2: Item
@export_storage var slot_3: Item

@export_storage var armor: Item
@export_storage var inventory: Array[Item]
