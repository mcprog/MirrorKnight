extends CanvasLayer

const Language = preload("res://Scripts/Language.gd")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var dialog_key
export(Texture) var portrait

const NPCNameIndex = 0
const LanguageIndex = 0
const EnglishIndex = 1
const TranslateThreshhold = .8

var dialogs;

var current_dialog;

var dialog_index;

const Dialogs = {
	"Sign": [
		["Stanlu tootoodefosko", 
		"welcome to Stanlu",
		 0, 0]
	],
	"Grandmother Meefa": [
		["deooha'Meefa", "Grandmother Meefa"],
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
	$Control/Panel/Name.text = dialogs[NPCNameIndex][EnglishIndex]
	$Control/Panel/Portrait.texture = portrait
	dialog_index = 1
	current_dialog = dialogs[dialog_index]
	update_dialog(current_dialog[LanguageIndex])

func update_dialog(raw_text):
	$Control/Panel/ScrollContainer/Line.text = raw_text


func _on_Translate_pressed():
	var trans_text = Language.translate_paragraph(current_dialog[LanguageIndex], Language.Lexicon)
	update_dialog(trans_text)
	var score = Language.get_translation_score(current_dialog[LanguageIndex], Language.Lexicon)
	print(str(score))
