extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var dialog_key
export(Texture) var portrait

var dialogs;

var current_dialog;

const Dialogs = {
	"WelcomeStanlu": [
		["Stanlu tootoodefosko", 
		"welcome to Stanlu",
		 0, 0]
	],
	"Grandmother Meefa": [
		["tootoo zeelibao . eef deooha'Meefa chis . daymas loyapulo limochis ?", 
		"Hello youngling. I am grandmother Meefa. Are you well today?",
		 1, -1],
		["limo wearlu . eef koi chisah'deooha chis . eef eaha eve chis teeheedoebo defosko chis . tamalo eru deoooha boochis . daymas limoquipu deoobachi wearlu ?",
		"Good to hear. I am not a real grandmother. I am a mother to those in town. That is why I am called grandmother. Would you enjoy hearing a story?",
		2, -1]
	]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func load_dialogs():
	dialogs = Dialogs[dialog_key]
	$Control/Panel/Name.text = dialog_key
	$Control/Panel/Portrait.texture = portrait
	current_dialog = dialogs[0]
	update_dialog(current_dialog)

func update_dialog(new_dialog):
	$Control/Panel/ScrollContainer/Line.text = new_dialog[0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
