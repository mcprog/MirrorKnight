extends Object


# lnaguage utility class

#obsolete
static func translate_word(sentence, index):
	var words_array = sentence.to_lower().split(" ");
	if index >= words_array.size():
		return null;
	return Lexicon[words_array[index]];

static func is_lower(string) -> bool:
	return string == string.to_lower();

static func get_translation_score(paragraph, knowledge: Dictionary) -> int:
	var words_array: Array = paragraph.split(" ");
	var translated: String = "";
	var words_count = 0.0;
	var translated_count = 0.0;
	for word in words_array:
		var sub_words = word.split("'")
		for sub_word in sub_words:
			if is_lower(sub_word):
				words_count += 1
				if knowledge.has(sub_word):
					translated_count += 1
	return translated_count / words_count


static func translate_paragraph(paragraph, knowledge: Dictionary) -> String:
	var words_array: Array = paragraph.split(" ");
	var translated: String = "";
	for word in words_array:
		var sub_words = word.split("'")
		var apos = ""
		if word != "." and word != "?":
			translated += " "
		
		for sub_word in sub_words:
			translated += apos
			if knowledge.has(sub_word):
				translated += knowledge[sub_word].to_upper()
			else:
				translated += sub_word
			apos = "'"
		
	return translated


const TestKnowledge = {
	"bao": "person",
	"tootoo": "hello",
	"limo": "joy",
	"deooha": "grandmother",
	"eef": "me"
}

const Lexicon = {
	".": ".",
	"?": "?",
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
	"eaha": "mother",
	"zeeli": "child",
	"yapulo": "day",
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
	"wearlu": "to hear",
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
	"tamla": "far",
	"eru": "why",
	# pronouns
	"eef": "me",
	"daymas": "you",
	"tas": "you scum",
	"lo": "it",
	"loo": "she",
	"vee": "we",
	"mast": "you all",
	"eve": "they",
	# compound: noun + noun = noun
	"biskdoebo": "forest",
	"vecunedoebo": "firepit",
	"gadoebo": "field",
	"heedoebo": "house",
	"kipuah": "cave",
	"tamalo": "that",
	"ayupuah": "gold mine",
	"ofoebosefrilleen": "bronze",
	"opopo": "same",
	"lobachi": "language",
	"deooha": "grandmother",
	"zeelibao": "youngling",
	"loyapulo": "today",
	"teeheedoebo": "town",
	# compound: noun + verb = verb
	"verbrisoth": "to fish",
	"tamlavu": "to travel",
	"preoivu": "to leave",
	"preoida": "to retrieve",
	"cheda": "to have",
	"baochis": "to speak",
	"isorecto": "to beg",
	"wuipolkvu": "to advance",
	"vecunevulpus": "to desire",
	"limoquipu": "to enjoy",
	"tootoodefosko": "to welcome",
	"limochis": "to be well",
	"boochis": "to call",
	# compound: verb + noun = noun
	"isobao": "hunter",
	"verbrisothbao": "fisherman",
	"tambao": "traveler",
	"bremoleskuru": "thanks",
	"koibao": "another",
	"uruche": "gift",
	"chisbao": "speaker",
	"bachi": "speech",
	"caolibao": "stranger",
	"chisah": "reality"
}
