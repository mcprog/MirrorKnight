extends Object


enum AttackType {
	Normal, # sword attack and such
	Red, # red light attacks
	Green,
	Blue,
	Projectile # bullets, arrows, bolts, armor can specifically defend against this
}

enum AttackSeverity {
	Normal, # care about armor, 
	Critical, # ignore 50% or armor, 
	Supercritical, # ignore all armor
}

const Critical = 1.5
const Super = 3
const MaxProtection = 0.6

const RedArmor = {
	"protection": .3,
	"normal": .7,
	"red": 0,
	"green": 1,
	"blue": 1.1,
	"projectile": 1.2
}

const GoldArmor = {
	"protection": MaxProtection,
	"normal": .85,
	"red": 1.01,
	"green": 1.01,
	"blue": 1.01,
	"projectile": 1.2
}

const InvincibleArmor = {
	"protection": 1,
	"normal": 0,
	"red": 0,
	"green": 0,
	"blue": 0,
	"projectile": 0
}

const NoArmor = {
	"protection": 0,
	"normal": 1,
	"red": 1,
	"green": 1,
	"blue": 1,
	"projectile": 1
}

# utility func to map factors to enum attack_type
static func get_effective_factor(armor, attack_type):
	if attack_type == AttackType.Normal:
		return armor["normal"]
	elif attack_type == AttackType.Red:
		return armor["red"]
	elif attack_type == AttackType.Green:
		return armor["green"]
	elif attack_type == AttackType.Blue:
		return armor["blue"]
	else:
		return armor["projectile"]
		

static func effective_damage(damage, attack_type, attack_severity, armor):
	var factor = get_effective_factor(armor, attack_type)
	# substract the damage scaled by the leftover armor protection
	var calc_dmg = (damage - (damage * (1.0 - armor.protection))) * factor
	if attack_severity == AttackSeverity.Normal:
		return int( calc_dmg )
	elif attack_severity == AttackSeverity.Critical:
		return int( calc_dmg * Critical )
	else:
		return int( calc_dmg * Super )
	
