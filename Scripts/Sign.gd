extends Area2D

const Language = preload("res://Language.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var in_language = "Tootoo bao"
export var translated = "Hello person"

var in_range

var debug_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	in_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not in_range:
		return
	if Input.is_action_just_pressed("interact"):
		var ret = Language.translate_word(in_language, debug_index)
		if ret == null:
			pass
		print(ret);
		debug_index += 1


func _on_Sign_body_entered(body):
	in_range = true


func _on_Sign_body_exited(body):
	in_range = false
