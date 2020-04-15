extends CanvasLayer


const Items = preload("res://Scripts/Items.gd")



const SlotCount = 25
export(Array, int) var slots

var actual_slots
var dragging

# Called when the node enters the scene tree for the first time.
func _ready():
	actual_slots = $MarginContainer/Panel/GridContainer.get_children()


func is_dragging() -> bool:
	return $DragTexture.texture;

func set_dragging(item):
	dragging = item;
	if dragging:
		$DragTexture.texture = dragging[Items.TexK]
	else:
		$DragTexture.texture = null

func set_dragging_id(id: int):
	dragging = Items.Items[id]
	$DragTexture.texture = dragging[Items.TexK]

func get_dragging():
	return dragging;
