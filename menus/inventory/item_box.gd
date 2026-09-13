extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect

var item: Item:
	set(value):
		item = value
		if is_node_ready():
			_update()

func _update():
	texture_rect.texture = item.icon if item else null

func _get_drag_data(at_position: Vector2) -> Variant:
	if item == null:
		return

	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(16, 16)
	c.modulate.a = 0.5
	set_drag_preview(c)

	return self

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var tmp = item
	item = data.item
	data.item = tmp
