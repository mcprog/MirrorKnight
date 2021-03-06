extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const KeyVariety = "variety";
const KeyWeakness = "weakness";
const KeyFeature = "feature";
const KeyDrops = "drops";
const KeyIcon = "icon";

const EnemyData = {
	"slime": {
		KeyVariety: "There are four types of slimes. Red, green, yellow, and blue",
		KeyWeakness: "Each type of slime is weak to a certain color of light. Except for yellow, it has no preference.",
		KeyFeature: "Slimes bounce towards me. They seem have a small chance to duplicate on death",
		KeyDrops: "Slimes drop special loot. I cannot find these drops anywhere else.",
		KeyIcon: preload("res://Sprites/slime-icon.png")
	},
	"bat": {
		KeyVariety: "There seems to be only one type of bat. However, the rat seems to be a close cousin",
		KeyWeakness: "The bat seems to hate light of any kind. Maybe I can procure a lantern to ward them off",
		KeyFeature: "The bat seems to be able to find me from very far away. I should be careful when entering dark areas. Lest he find me before I find him.",
		KeyDrops: "Guano is a unqique drop from bats. Ew",
		KeyIcon: preload("res://Sprites/bat-icon.png")
	}
}

var showing
var in_transistion

onready var dex = $Control/Panel/Dex;
onready var detail = $Control/Panel/Detail;
onready var kills_val = $Control/Panel/Detail/Stats/KillsVal;
onready var deaths_val = $Control/Panel/Detail/Stats/DeathsVal;
onready var exp_val = $Control/Panel/Detail/Stats/ExpVal;

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_panel()





func click_detail(enemy_name: String) -> void:
	dex.visible = false;
	detail.visible = true;
	var enemy_data = EnemyData[enemy_name];
	if enemy_data != null:
		$Control/Panel/Detail/About/Name.text = enemy_name.capitalize();
		$Control/Panel/Detail/About/Variety.text = enemy_data[KeyVariety];
		$Control/Panel/Detail/About/Weakness.text = enemy_data[KeyWeakness];
		$Control/Panel/Detail/About/Feature.text = enemy_data[KeyFeature];
		$Control/Panel/Detail/About/Drops.text = enemy_data[KeyDrops];
		$Control/Panel/Detail/Stats/Icon.texture = enemy_data[KeyIcon];
		kills_val.text = "0";
		deaths_val.text = "0";

func reset_panel():
	dex.visible = true;
	detail.visible = false;

func show():
	if in_transistion:
		return
	in_transistion = true
	$Control/AnimationPlayer.play("Show")
	showing = true
	
func hide():
	if in_transistion:
		return
	in_transistion = true
	$Control/AnimationPlayer.play("Hide")
	showing = false

func done_transition():
	in_transistion = false;
	reset_panel()

func update_vals():
	var raw_exp = float(kills_val.text) - float(deaths_val.text) * .5
	exp_val.text = str(raw_exp)

func _on_Close_pressed():
	hide()


func _on_Slime_pressed():
	click_detail("slime");


func _on_Bat_pressed():
	click_detail("bat");


func _on_AddKill_pressed():
	kills_val.text = str(float(kills_val.text) + 1)
	update_vals()


func _on_AddDeath_pressed():
	deaths_val.text = str(float(kills_val.text) + 1)
	update_vals()
