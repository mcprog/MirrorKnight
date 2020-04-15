extends CanvasLayer

const Language = preload("res://Scripts/Language.gd")


var knowledge;

onready var translation = $MarginContainer/Panel/MarginContainer/Translations/VBoxContainer/Translation
onready var holder = $MarginContainer/Panel/MarginContainer/Translations/VBoxContainer

var showing = false
var in_transition = false

func _ready():
	knowledge = Language.TestKnowledge
	load_knowledge()

func load_knowledge(): # called at begging of show animation
	for i in knowledge:
		var copy = translation.duplicate()
		copy.set_values(i, knowledge[i])
		copy.visible = true
		holder.add_child(copy)

func show():
	if in_transition:
		return
	in_transition = true
	$AnimationPlayer.play("Show")
	showing = true
	

func hide():
	if in_transition:
		return
	in_transition = true
	$AnimationPlayer.play("Hide")
	showing = false

# dont think i use this
func toggle():
	if in_transition:
		return;
	if showing:
		hide()
	else:
		show()


func _on_Close_pressed():
	hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	in_transition = false
