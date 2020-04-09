extends CanvasLayer

const Language = preload("res://Scripts/Language.gd")


var knowledge;

onready var translation = $MarginContainer/Panel/MarginContainer/Translations/VBoxContainer/Translation
onready var holder = $MarginContainer/Panel/MarginContainer/Translations/VBoxContainer


func _ready():
	$AnimationPlayer.play("Show")
	knowledge = Language.Lexicon
	begin_show()

func begin_show(): # called at begging of show animation
	for i in knowledge:
		var copy = translation.duplicate()
		copy.set_values(i, knowledge[i])
		copy.visible = true
		holder.add_child(copy)




func _on_Close_pressed():
	$AnimationPlayer.play("Hide")
