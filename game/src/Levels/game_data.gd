extends Node2D

#spawns player location to scene
var player_location1 = Vector2(236.82,789.579)
var player_location2 = Vector2(142.066, 699.882)
var player_spawn = load("res://src/Actors/Player.tscn")
var isCheckpoint5 = false
var checkpoint = null
var isCheckpointPassed = false
var isRightAnswer = false
var questionList
var userName = ""
var playerScore = 0
var playerCode = 0000
var save_user_url = "https://digiseiklus.digikapp.ee/saveUser.php"
var update_score_url = "https://digiseiklus.digikapp.ee/update.php"
var gameResults_url = "https://digiseiklus.digikapp.ee/tulemused2.html"
var answeredQuestion = ""
var rightAnswer

var CP1_location = Vector2(3877.99,811.591)
var CP2_location = Vector2(7402.33,700.833)
var CP3_location = Vector2(11383.663,701.1)
var CP4_location = Vector2(14619.867,810.552)


func _ready():
	set_process(true)
	set_process_input(true)
	player_spawn = player_spawn.instance()
	
	if get_node("res://src/Levels/Level1.tscn"):
		GameData.set("player_location", player_location1)	
		print("Level1_player location1" + userName )
		
	else:
		GameData.set("player_location", player_location2)
	
	GameData.set("player_spawn", player_spawn)
	GameData.set("isCHeckpointPassed", isCheckpointPassed)
	GameData.set("isCheckpoint5", isCheckpoint5)
	GameData.set("checkpoint", checkpoint)
	GameData.set("CP1_location", CP1_location)
	GameData.set("CP2_location", CP2_location)
	GameData.set("CP3_location", CP3_location)
	GameData.set("CP4_location", CP4_location)
	
	GameData.set("playerScore", playerScore)
	GameData.set("playerCode", playerCode)
	GameData.set("rightAnswer", rightAnswer)
		
var questionList1 = { 
	1:{
		"label": "Mängid koos sõpradega arvutis ja avaneb aken: “Kliki siia ja võida miljon eurot!”. Mida teed?  ",
		"answer1": "Klikin lingil, et täpsemalt uurida ",
		"answer2": "Küsin sõpradelt, mida teha ",
		"answer_right": "Sulgen akna ja mängin sõpradega edasi "	
	 
	},
	2:{
		"label": "Kas veebis avaldatud pilti on võimalik kustutada?",
		"answer1":"Jah, alati.",
		"answer_right": "Ei ole.",
		"answer2":"Pole teada."	
		
	},
	3:{
		"label": "Kas internetist leitud pilte võib sotsiaalmeedias vabalt avaldada?",
		"answer_right": "Võib kui piltide omanik seda lubab.",
		"answer2": "Ei või mitte kunagi.",
		"answer1": "Internetis võib kõike vabalt avaldada."
	}
}
var questionList2 = {
	1:{
		"label": "Kuidas reageerid kui sõber kirjutab sulle Messengeris: “Olen lollakas ja hüppan aknast alla.”?",
		"answer1": "Kirjutad vastuseks naeratavad emojid.",
		"answer_right": "Helistad sõbrale ja uurid, kas see oli ikka tema ise kes kirjutas.",
		"answer2": "Ignoreerid teda."	
	},
	2:{
		"label": "Sõber tahab sinult sinu Facebooki konto parooli saada. Kas annad?",
		"answer1": "Kindlasti - ta ju hea sõber!",
		"answer_right": "Üritad leida viisaka võimaluse keelduda.",
		"answer2": "Annad sõbrale vale parooli."
	},
	3:{
		"label": "Mis funktsioon on arvutis tulemüüril?",
		"answer1": "Jahutab arvutit.",
		"answer_right": "Ei lase võõraid internetist sinu arvutile ligi.",
		"answer2": "Kaitseb arvutit viiruste eest."
	}
}
var questionList3 = {
	1:{
		"label": "Milline neist on turvaline salasõna?",
		"answer1": "MinuNimiOnKarl123",
		"answer_right": "5870wJK446",
		"answer2": "Password"
	},
	2:{
		"label": "Internetis enim levinud suhtlusportaal?",
		"answer1": "Instagram",
		"answer_right": "Facebook",
		"answer2": "LinkedIn"
	},
	3:{
		"label": "Portaal, kus inimesed saavad “säutsuda”?",
		"answer1": "Facebook",
		"answer_right": "Twitter",
		"answer2": "Snapchat"
	}
}
var questionList4 = {
	1:{
		"label": "Milline järgnevast on tark käitumine internetis?",
		"answer1": "Võõrale inimesele enda isikuandmete ja aadressi avaldamine.",
		"answer_right": "Isikuandmete mitteavaldamine.",
		"answer2": "Suvalistele inimestele endast piltide saatmine."
	},
	2:{
		"label": "Keda peaksid lisama sotsiaalvõrgustikes sõprade nimekirja?",
		"answer1": "Mingi tüübi, kellega mitu aastat tagasi ühel sünnipäeval korra rääkisid",
		"answer_right": "Inimesi, keda päriselt tunned",
		"answer2": "Suvalised inimesed, keda otsingust leiad"
	},
	3:{
		"label": "Milliseid ekraanilukke on võimalik nutitelefonile peale panna?",
		"answer1": "Sõrmejälg, lihtne avamine ühe nupu abil",
		"answer_right": "Kood, muster, sõrmejälg",
		"answer2": "Kood, muster, lihtne avamine ühe nupu abil"
	}
}
var questionList5 = {
	1:{
		"label": "Milline neist on usaldusväärne pood rakenduste allalaadimiseks?",
		"answer1": "Aliexpress.com",
		"answer_right": "Google Play",
		"answer2": "Ebay"
	},
	2:{
		"label": "Miks pole soovitatav kasutada paroolita WIFI võrke?",
		"answer1": "Need on liiga turvalised",
		"answer_right": "Need ei ole sama turvalised kui parooliga võrgud",
		"answer2": "Need tavaliselt ei tööta"
	},
	3:{
		"label": "Milline neist tunnustest viitab küberkiusamisele?",
		"answer1": "Sõbralikult sotsiaalmeedias pildi kommenteerimine",
		"answer_right": "Ähvardavad, õelad e-kirjad ja tekstisõnumid",
		"answer2": "Luba küsimine enne sinu pildi jagamist"
	}
}
