extends CanvasLayer


var in_transition = false
var showing = false

var other_menu = null

onready var enemy_button = $MarginContainer/HBoxContainer/Enemies/BookButton
onready var word_button = $MarginContainer/HBoxContainer/Words/BookButton
onready var map_button = $MarginContainer/HBoxContainer/Map/BookButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func show():
	in_transition = true
	$AnimationPlayer.play("Show")
	showing = true

func hide():
	in_transition = true
	$AnimationPlayer.play("Hide")
	showing = false

func toggle_menu(new_menu):
	if new_menu == other_menu:
		other_menu.hide()
		other_menu = null
	elif other_menu == null:
		other_menu = new_menu
		if showing:
			hide()
		other_menu.show()
	else:
		other_menu.hide()
		other_menu = new_menu
		other_menu.show()

func show_menu(menu):
	hide()
	menu.show()
	other_menu = menu

func _process(delta):
	if not in_transition:
		
		if Input.is_action_just_pressed("ui_home"):
			if showing:
				hide()
			else:
				if other_menu:
					if other_menu.showing:
						other_menu.hide()
					other_menu = null
				show()
		elif Input.is_action_just_pressed("menu_words"):
			toggle_menu($Words)
	
	if enemy_button.perform_click:
		enemy_button.perform_click = false
		print("performing the mufucking click")
	elif word_button.perform_click:
		word_button.perform_click = false
		show_menu($Words)

func _on_AnimationPlayer_animation_finished(anim_name):
	in_transition = false
