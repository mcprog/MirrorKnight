extends TextureButton


const Items = preload("res://Scripts/Items.gd")
const Inventory = preload("res://Scripts/Inventory.gd")

export(int) var default_item;

var inventory: Inventory

var item

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = owner
	if default_item > 0:
		set_item_id(default_item);
	else:
		pass
		

func set_item_id(id: int):
	item = Items.Items[id]
	set_item(item);

func set_item(item):
	self.item = item
	if item:
		hint_tooltip = item[Items.NameK];
		$TextureRect.texture = item[Items.TexK];

func un_set():
	item = null
	$TextureRect.texture = null
	hint_tooltip = ""



func _on_Slot_pressed():
	print("slot pressed")
	
	if inventory.is_dragging():
		if item:
			var old_drag = inventory.get_dragging()
			inventory.set_dragging(item)
			set_item(old_drag)
		else:
			print("is dragging setting slot to dragging")
			set_item(inventory.get_dragging())
			inventory.set_dragging(null)
	else:
		inventory.set_dragging(item)
		un_set()



