extends Object


# lnaguage utility class

static func translate_word(sentence, index):
	var words_array = sentence.to_lower().split(" ");
	if index >= words_array.size():
		return null;
	return Lexicon[words_array[index]];

const Lexicon = {
	# root nouns
	"bao": "person",
	"chulu": "animal",
	"briss": "apple",
	"deoo": "giant",
	"bisk": "tree",
	"vecune": "fire",
	"doebo": "place",
	"ga": "grass",
	"hee": "home",
	"verbriskata": "fish",
	"eah": "earth",
	"kipu": "darkness",
	"bremoleska": "gratitude",
	"ayut": "gold",
	"basko": "silver",
	"frilleen": "copper",
	"ofoebose": "tin",
	"limo": "joy",
	"tantos": "sadness",
	"ipol": "image",
	# root verbs
	"finko": "to see",
	"da": "to get",
	"vuloo": "to take",
	"baan": "to sit",
	"vu": "to go",
	"beth": "to finish",
	"valk": "to run",
	"isoth": "to hunt",
	"preoi": "to originate",
	"chis": "to be",
	"defosko": "to enter",
	"uru": "to give",
	"caoli": "to question",
	"recto": "to ask",
	"volpus": "to want",
	"quipu": "to do",
	# root misc
	"che": "belonging to",
	"tis": "many",
	"talss": "for",
	"dembiet": "can",
	"tootoo": "hello",
	"opo": "yes",
	"koi": "no",
	"iso": "please",
	"wuipolk": "forward",
	"tamla": "far"
}
