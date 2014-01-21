//Set custom stats and display a blurb about them.  No need to set up buttons, handled outside in 10045
public function customPCSetup():void {
	//Set as having history perk
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 1;
	if(player.short == "Vahdunbrii") {
		player.createBreastRow();
		player.createVagina();
		player.breastRows[0].breastRating = 3;
		player.clitLength = .5;
		player.fertility = 10;
		player.gender = 2;
		player.hipRating = 6;
		player.buttRating = 6;
		player.str = 15;
		player.tou = 15;
		player.spe = 18;
		player.inte = 17;
		player.sens = 15;
		player.lib = 15;
		player.cor = 0;
		notes = "No Notes Available.";
		player.HP = maxHP();
		player.hairLength=10;
		player.skinType = SKIN_TYPE_PLAIN;
		player.faceType = FACE_HUMAN;
		player.tailType = TAIL_TYPE_NONE;
		player.tongueType = TONUGE_HUMAN;
		player.femininity = 70;
		player.beardLength = 0;
		player.beardStyle = 0;
		player.tone = 30;
		player.thickness = 50;
		player.skinDesc = "skin";
		player.skinTone = "light";
		player.hairColor = "brown";
		player.balls = 0;
		player.cumMultiplier = 1;
		player.ballSize = 0;
		player.hoursSinceCum = 0;
		player.clitLength = 0;
		player.ass.analLooseness = 0;
		player.ass.analWetness = 0;
		player.ass.fullness = 0;
		player.fertility = 5;
		player.fatigue = 0;
		player.horns = 0;
		player.tallness = 67;
		player.tailVenom = 0;
		player.tailRecharge = 0;
		player.wingType = WING_TYPE_NONE;
		player.wingDesc = "non-existant";
		player.earType = EARS_CAT;
		player.lowerBody = LOWER_BODY_TYPE_CAT;
		player.tailType = TAIL_TYPE_CAT;
		player.createPerk("Incorporeality",0,0,0,0,"You seem to have inherited some of the spiritual powers of the residents of the afterlife!  While you wouldn't consider doing it for long due to its instability, you can temporarily become incorporeal for the sake of taking over enemies and giving them a taste of ghostly libido.");
		player.wingType = WING_TYPE_FEATHERED_LARGE;
		player.armType = ARM_TYPE_HARPY;
		player.hornType = HORNS_DRACONIC_X2;
		player.horns = 4;
		player.faceType = FACE_SPIDER_FANGS;
		player.hairLength = 69.2;
		player.hairColor = "dark blue";
		player.hairType = 2;
		player.skinAdj = "smooth";
		player.skinTone = "sanguine";
		player.tallness = 68;
		player.hipRating = 7;
		player.buttRating = 6;
		player.thickness = 4;
		player.tone = 98;
		player.breastRows[0].breastRating = 3;
		player.clitLength = 0.2;
		player.femininity = 85;
		//Beautiful Sword
		player.weapon = weapons.B_SWORD;
		player.armor = armors.SSARMOR;
		//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
		player.createStatusAffect("Kelt",100,0,0,0);		
		player.createKeyItem("Bow",0,0,0,0);
		inventory.createStorage();
		inventory.createStorage();
		inventory.createStorage();
		inventory.createStorage();
		inventory.createStorage();
		inventory.createStorage();
		player.createKeyItem("Camp - Chest",0,0,0,0);
		player.createKeyItem("Equipment Rack - Weapons",0,0,0,0);
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1;
		player.createKeyItem("Equipment Rack - Armor",0,0,0,0);
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1;
		//(Flexibility), (Incorporeality), History: Religious, Dragonfire, Brood Mother, Magical Fertility, Wet Pussy, Tough, Strong, Fast, Smart, History: Scholar, History: Slacker, Strong Back, Strong Back 2: Stronger Harder
		player.createPerk("Flexibility",0,0,0,0,"Due to your cat-like body, you're able to dodge attacks more often.");
		player.createPerk("History: Religious",0,0,0,0,"");
		player.createPerk("Dragonfire",0,0,0,0,"You're a cheater, cheater.");
		player.createPerk("Brood Mother",0,0,0,0,"Pregnancy moves twice as fast as a normal woman's.");
		player.createPerk("Fertile",1.5,0,0,0,"CHEATER JACKASS JERKFACE");
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
		player.createPerk("Wet Pussy",2,0,0,0,"Keeps your pussy from ever being anything less than wet.");
		player.createPerk("Tough", 0.25, 0, 0, 0,"Gain toughness 25% faster.");
		player.createPerk("Strong", 0.25, 0, 0, 0,"Gain strength 25% faster.");
		player.createPerk("Fast", 0.25, 0, 0, 0,"Gain speed 25% faster.");
		player.createPerk("Smart", 0.25, 0, 0, 0,"Gain intelligence 25% faster.");
		player.createPerk("History: Scholar", 0, 0, 0, 0,"You cheated.");
		player.createPerk("Strong Back",0,0,0,0,"Cheating Nerd!");
		player.itemSlot4.unlocked = true;
		player.itemSlot5.unlocked = true;
		player.createPerk("Strong Back 2: Strong Harder",0,0,0,0,"Cheating Nerd!");
		player.createPerk("History: Slacker",0,0,0,0,"Cheating Nerd!");
		player.str += 4;
		player.tou += 4;
		player.inte += 2;
		player.spe += 2;
		player.gems += 300;
		outputText("You're something of a powerhouse, and you wager that between your odd mutations, power strong enough to threaten the village order, and talents, you're the natural choice to send through the portal.");
	}
	if(player.short == "Leah") {
		player.armor = armors.URTALTA;
		if(player.hasPerk("Wizard's Endurance") < 0) player.createPerk("Wizard's Endurance",30,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		player.weapon = weapons.W_STAFF;
		player.itemSlot1.setItemAndQty(consumables.B__BOOK, 1);
		player.itemSlot2.setItemAndQty(consumables.W__BOOK, 2);

		player.createBreastRow();
		player.createVagina();
		player.breastRows[0].breastRating = 4;
		player.clitLength = .5;
		player.fertility = 10;
		player.gender = 2;
		player.hipRating = 8;
		player.buttRating = 8;
		player.str = 15;
		player.tou = 15;
		player.spe = 18;
		player.inte = 17;
		player.sens = 15;
		player.lib = 15;
		player.cor = 0;
		notes = "No Notes Available.";
		player.HP = maxHP();
		player.hairLength=13;
		player.skinType = SKIN_TYPE_PLAIN;
		player.faceType = FACE_HUMAN;
		player.tailType = TAIL_TYPE_NONE;
		player.tongueType = TONUGE_HUMAN;
		player.femininity = 85;
		player.beardLength = 0;
		player.beardStyle = 0;
		player.tone = 30;
		player.thickness = 50;
		player.skinDesc = "skin";
		player.skinTone = "olive";
		player.hairColor = "black";
		player.balls = 0;
		player.cumMultiplier = 1;
		player.ballSize = 0;
		player.hoursSinceCum = 0;
		player.clitLength = 0;
		player.ass.analLooseness = 0;
		player.ass.analWetness = 0;
		player.ass.fullness = 0;
		player.fertility = 5;
		player.fatigue = 0;
		player.horns = 0;
		player.tallness = 67;
		player.tailVenom = 0;
		player.tailRecharge = 0;
		player.wingType = WING_TYPE_NONE;
		player.wingDesc = "non-existant";
		player.tone = 30;
		player.thickness = 65;

	}
	if(player.short == "Lukaz") {
		//Specific Character	
		//Male. 11.5 inch dog dick, 4 balls, 2 inches in diameter.	
		player.createCock();
		player.cocks[0].cockLength = 11.5;
		player.cocks[0].cockThickness = 2;
		player.cocks[0].cockType = CockTypesEnum.DOG;
		player.cocks[0].knotMultiplier = 1.5;
		player.createBreastRow();
		player.breastRows[0].breastRating = 0;
		player.gender = 1;
		player.tallness = 71;
		player.hipRating = 4;
		player.buttRating = 4;
		player.femininity = 30;
		player.createCock();
		player.balls = 4;
		player.cumMultiplier = 4;
		player.ballSize = 2;
		player.str = 18;
		player.tou = 17;
		player.spe = 15;
		player.inte = 15;
		player.sens = 15;
		player.lib = 15;
		player.cor = 0;
		notes = "No Notes Available.";
		player.HP = maxHP();
		player.hairLength = 1;
		player.skinType = SKIN_TYPE_PLAIN;
		player.skinTone = "light";
		player.hairColor = "brown";
		player.faceType = FACE_HUMAN;
		player.tailType = TAIL_TYPE_NONE;
		player.tongueType = TONUGE_HUMAN;
		player.femininity = 50;
		player.beardLength = 0;
		player.beardStyle = 0;
		player.thickness = 50;
		player.skinDesc = "skin";
		player.hoursSinceCum = 0;
		player.clitLength = 0;
		player.ass.analLooseness = 0;
		player.ass.analWetness = 0;
		player.ass.fullness = 0;
		player.fertility = 5;
		player.fatigue = 0;
		player.horns = 0;
		player.tailVenom = 0;
		player.tailRecharge = 0;
		player.wingType = WING_TYPE_NONE;
		player.wingDesc = "non-existant";
		//"dog face, dog ears, draconic tail, blue fur.
		player.faceType = FACE_DOG;
		player.earType = EARS_DOG;
		player.tailType = TAIL_TYPE_DRACONIC;
		player.skinType = SKIN_TYPE_FUR;
		player.hairColor = "blue";
		player.skinDesc = "fur";
		player.tone = 88;
		player.tongueType = TONUGE_DRACONIC;
		//gel plate armor, warhammer, 88 body tone, 1 breast row, flat manly breasts, 0.2 inch nipples, 1 on each breast, draconic tongue, short hair-blue, light skin."	Lukaz
		player.createPerk("History: Fighter",0,0,0,0);
		player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
	}
	if(player.short == "Sora") {
		//Character Creation	Female,virgin	A kitsune with a snake-like tongue	Sora
		if(player.hasVagina()) player.vaginas[0].virgin = true;
		player.tongueType = TONUGE_SNAKE;
		player.earType = EARS_FOX;
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 2;
		player.inte = 30;
		if(player.hasStatusAffect("Bonus vCapacity") < 0) player.createStatusAffect("Bonus vCapacity",0,0,0,0);
		else player.addStatusValue("Bonus vCapacity",1,5+rand(10));
		outputText("As a Kitsune, you always got weird looks, but none could doubt your affinity for magic...");
	}
	if(player.short == "Nixi") {
		//-Perks
       	//fertility AND messy orgasm (hope that's not pushing it)
	   	player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
	   	player.createPerk("Fertile", 1.5, 0, 0, 0,"Makes you 15% more likely to become pregnant.");
       	//fighting history
		player.createPerk("History: Fighter",0,0,0,0);
		//3 starting perk points
		player.perkPoints = 3;
		//some starting gems (just go ahead and surprise me on the amount)
		player.gems = rand(800);
		//Specific Character
		//-Female... with a dog cock
		//11"" long, 2"" wide, 2.4"" knot
       	//no balls
		//virgin pussy, 0.2"" clit
		//wetness 2
		//fertility 30 
		//virgin bum
       	//anal wetness 1
		player.ass.analWetness = 2;
		player.gender = 3;
		player.createCock();
		player.cocks[0].cockLength = 11;
		player.cocks[0].cockThickness = 2;
		player.cocks[0].knotMultiplier = 1.2;
		player.cocks[0].cockType = CockTypesEnum.DOG;
		player.balls = 0;
		player.createBreastRow();
		player.createVagina();
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
		//1 pair DD's, 0.5"" nipples"
		player.breastRows[0].breastRating = 5;
		player.nippleLength = 0.5;
		player.clitLength = .5;
		player.fertility = 30;
		player.hipRating = 6;
		player.buttRating = 6;
		player.str = 15;
		player.tou = 15;
		player.spe = 18;
		player.inte = 17;
		player.sens = 15;
		player.lib = 15;
		player.cor = 0;
		notes = "No Notes Available.";
		player.HP = maxHP();
		
		player.skinType = SKIN_TYPE_PLAIN;
		player.faceType = FACE_HUMAN;
		player.tailType = TAIL_TYPE_NONE;
		player.tongueType = TONUGE_HUMAN;
		player.femininity = 85;
		player.beardLength = 0;
		player.beardStyle = 0;
		//75 muscle tone
		player.tone = 75;
		//25 thickness
		player.thickness = 25;
		player.skinDesc = "fur";
		player.skinType = SKIN_TYPE_FUR;
		player.skinTone = "light";
		player.hairColor = "silver";
		player.hairLength=10;
		//shoulder length silver hair

		player.balls = 0;
		player.cumMultiplier = 1;
		player.ballSize = 0;
		player.hoursSinceCum = 0;
		player.clitLength = 0;
		player.ass.analLooseness = 0;
		player.ass.analWetness = 0;
		player.ass.fullness = 0;
		player.fertility = 5;
		player.fatigue = 0;
		player.horns = 0;
		player.tallness = 82;
		player.tailVenom = 0;
		player.tailRecharge = 0;
		player.wingType = WING_TYPE_NONE;
		player.wingDesc = "non-existant";
		//6' 10"" german-shepherd morph, face ears hands feet tail, the whole nine yards
		player.faceType = FACE_DOG;
		player.lowerBody = LOWER_BODY_TYPE_DOG;
		player.tailType = TAIL_TYPE_DOG;
		player.earType = EARS_DOG;
		////"	"I'm picturing a tall, feminine German-Shepherd morph, solid white and gorgeous. She has both sets of genitals, with no balls, and a large set of breasts. She wields a large claymore and is dressed in a full chain vest and pants. 
		//large claymore (and the strength to use it)
		player.weapon = weapons.CLAYMOR;
		player.str = 40;
		//full chain
		player.armor = armors.FULLCHN;
		outputText("As a German-Shepherd morph, the rest of the village never really knew what to do with you... until they sent you through the portal to face whatever's on the other side...");
	}
	if(player.short == "Galatea") {
		//"(Dangit Fenoxo!  Stop adding sexy must-have things to the game!  If it's not too late to update it I've added in that sexy new armor.  Thanks!)		
		//Other:
  		if(!player.hasVagina()) {
			player.createVagina();
			if(player.clitLength == 0) player.clitLength = 0.25;
		}
		genderCheck();
		//Hair length: Very long
		player.hairLength = 22;
		//Breast size: HH
		player.breastRows[0].breastRating = 21;
  		//Femininity/Beauty: Very high
		player.femininity = 90;
		// Height: 5'4
		player.tallness = 64;

		//Perks: Feeder, Strong Back, Strong Back 2
		player.createStatusAffect("Feeder",0,0,0,0);
		player.createPerk("Feeder",0,0,0,0,"The LaBova has corrupted your breasts, preventing your lactation from decreasing and giving you an urge to feed it to others.");
		
		player.createPerk("Strong Back",0,0,0,0,"Cheating Nerd!");
		player.createPerk("Strong Back 2: Strong Harder",0,0,0,0,"Cheating Nerd!");

		//Equipment: 
    	//Weapon: Warhammer
		player.weapon = weapons.WARHAMR;
    	//Armor: Lusty shit
		player.armor = armors.LMARMOR;
		player.createPerk("Slutty Seduction",10 + flags[kFLAGS.BIKINI_ARMOR_BONUS],0,0,0,"Your incredibly revealing steel armor allows you access to 'Seduce', an improved form of 'Tease'.");

		//Stats: (if possible)
  		//Strength: 90
		player.str = 90;
  		//Fertility: 100
		player.fertility = 100;
		player.cor = 25;
		//Inventory: Lactaid, GroPlus, BimboLq
		player.itemSlot1.setItemAndQty(consumables.LACTAID,5);
		player.itemSlot2.setItemAndQty(consumables.GROPLUS,5);
		player.itemSlot3.setItemAndQty(consumables.BIMBOLQ,1);
		player.itemSlot4.unlocked = true;
		player.itemSlot4.setItemAndQty(armors.BIMBOSK,1);
		player.itemSlot5.unlocked = true;
		outputText("You've got large breasts prone to lactation.  You aren't sure WHY you got chosen as a champion, but with your considerable strength, you're sure you'll do a good job protecting Ingnam.");
	}
	if(player.short == "Siveen") {
		//Female
		//Virgin
		
		player.gender = 2;
		player.createVagina();
		player.clitLength = 0.25;
		//has a self-repairing hymen in her cunt"	"Angel
		//(means feathered wings on her back)
		player.wingType = WING_TYPE_HARPY;
		//Halo (Flaming)
		//D-cups
		player.createBreastRow();
		player.breastRows[0].breastRating = 4;
		//human skin
		//heart-shaped ass
		player.buttRating = 9;
		player.hipRating = 6;
		//Ass-length white and black hair
		player.hairLength = 30;
		player.hairColor = "white and black";
		//heterochromia (one blue eye one red eye)
		//7"" nips
		player.nippleLength = 7;
		//waif thin body
		player.thickness = 0;
		//Fallen Angel gear (complete with flaming sword and light arrows)
		//dark skin tone
		player.skinTone = "dark";
		player.weapon = weapons.S_BLADE;

		//Elfin ears
		player.earType = EARS_ELFIN;
		//tight asshole
		//human tongue
		//human face
		//no tail, fur, or scales"
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 0;
		player.str = 25;
		player.tou = 25;
		player.inte = 25;
		player.spe = 25;
		outputText("You are a literal angel from beyond, and you take the place of a vilage's champion for your own reasons...");
	}
	if(player.short == "Betram") {
		//Character Creation	
		//herm, canine cock - 8", virgin, tight, wet	
		//fox ears, tails, A cup breasts with normal nipples	Betram															
		player.earType = EARS_FOX;
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 1;
		if(player.biggestTitSize() > 1) player.breastRows[0].breastRating = 1;
		if(!player.hasCock()) {
			player.createCock();
			player.cocks[0].cockType = CockTypesEnum.DOG;
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].knotMultiplier = 1.4;
		}
		if(!player.hasVagina()) {
			player.createVagina();
			player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			player.clitLength = 0.25;
		}
		player.gender = 3;
		outputText("You're quite the foxy herm, and as different as you were compared to the rest of Ingnam, it's no suprise you were sent through first.");
	}
	if(player.short == "Ceveo") {
		//Male. 2 cock. 5.5 average thickness and 12 in with excessive thickness both pierced with silver rings. Balls, large, about the size of a billiard ball, four of them. All humanish, more details on the character.
		player.createCock();
		player.createCock();
		player.balls = 4;
		player.ballSize = 3;
		player.cocks[0].cockThickness = 5.5;
		player.cocks[1].cockThickness = 5.5;
		player.cocks[0].cockLength = 12;
		player.cocks[1].cockLength = 12;
		player.cocks[0].pierced = 2;
		player.cocks[1].pierced = 2;
		player.cocks[0].pShortDesc = "silver cock-ring";
		player.cocks[1].pShortDesc = "silver cock-ring";
		player.cocks[0].pLongDesc = "Silver cock-ring";
		player.cocks[1].pLongDesc = "Silver cock-ring";
		//"Androgynous face, large brown eyes, long black hair down to about ass level, full lips, pirced with one silver ring ass itself is round and thick, chest is flat, only two nipples, about nickle sized pierced with silver studs, skin of a pale ghostly transparent complexion, rest of the body is not notably muscular or chubby in any definite way, feet seem to taper off into full transparency. Full body housed in the lewd Inquisitor Armor, wielding a Wizard Staff. Starting at level 5 with tank, regeneration, healing, smarts, channeling, mage and incorperability perks, a full knowledge of 
		player.gender = 1;
		player.tallness = 72;
		player.femininity = 50;
		player.hairLength = 35;
		player.hairColor = "black";
		player.lipPierced = 2;
		player.lipPShort = "silver lip-ring";
		player.lipPLong = "Silver lip-ring";
		player.buttRating = 8;
		player.hipRating = 8;
		player.createBreastRow();
		player.nipplesPierced = 1;
		player.nipplesPShort = "silver studs";
		player.nipplesPLong = "Silver studs";
			
		player.skinTone = "ghostly pale";
		player.createPerk("Incorporeality",0,0,0,0,"You seem to have inherited some of the spiritual powers of the residents of the afterlife!  While you wouldn't consider doing it for long due to its instability, you can temporarily become incorporeal for the sake of taking over enemies and giving them a taste of ghostly libido.");
		player.armor = armors.I_CORST;
		player.level = 5;
		player.weapon = weapons.W_STAFF;

		player.createPerk("Regeneration",0,0,0,0);
		player.createPerk("Smart",0,0,0,0);
		player.createPerk("Channeling",0,0,0,0);
		player.createPerk("Mage",0,0,0,0);
		player.createPerk("History: Healer",0,0,0,0);
		player.createPerk("Tank",0,0,0,0);
		player.createStatusAffect("Knows Arouse",0,0,0,0);
		player.createStatusAffect("Knows Heal",0,0,0,0);
		player.createStatusAffect("Knows Might",0,0,0,0);
		player.createStatusAffect("Knows Charge",0,0,0,0);
		player.createStatusAffect("Knows Blind",0,0,0,0);
		player.createStatusAffect("Knows Whitefire",0,0,0,0);
		//magic, 50 Int, 50 tough, Speed 15, Str 10, 30 corruption, 30 libido, 10 sensitivity.
		player.inte = 50;
		player.tou = 50;
		player.spe = 15;
		player.str = 10;
		player.cor = 30;
		player.lib = 30;
		player.sens = 10;
		outputText("As a wandering mage you had found your way into no small amount of trouble in the search for knowledge.  A strange tome here, a ritual there, most people found your pale form unsettling, they would be further troubled if they could see your feet!  And lets not even begin on the blood magic.  Yes, your interest in examining every aspect of magic has run you down a strange path, so when you wandered into Ingram and began to hear of the exile of the Champion, and the superstitions that surrounded it you were intrigued, as every little rumor and ritual often had a grain of truth.  You snuck into the cave prior to the ritual, where the old man supposedly led every Champion, and there you found a strange portal that emanated a certain degree of spacial transparency -  more than the portal's own.  Within it must have been a whole new world!  Throwing caution to the wind, your curiosities engulfing you, you dove in with nary a thought for the consequences.");
	}
	if(player.short == "Nami") {
		//Female with the sand-trap black pussy
		//Non-Virgin
		//Fertility- Normal Starting Value
		//Wetness- Above Average
		//Looseness- Normal Starting Value
		//Clit-size- Normal Value"
		player.createVagina();
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
		player.clitLength = 0.25;
		player.vaginas[0].type = 5;
		player.vaginas[0].virgin = false;
		player.ass.analLooseness = 1;
		//Face- Canine
		player.faceType = FACE_DOG;
		//Ears- Canine
		player.earType = EARS_DOG;
		//Tail- Canine
		player.tailType = TAIL_TYPE_DOG;
		//Lower body- Canine
		player.lowerBody = LOWER_BODY_TYPE_DOG;
		//White Fur (if possible)
		player.skinType = SKIN_TYPE_FUR;
		player.hairColor = "white";
	 	player.skinDesc = "fur";
		//Body Thickness/breastsize/- As if I had selected the ""Average"" body type from the start.
		player.createBreastRow();
		player.breastRows[0].breastRating = 3;
		//Muscle Tone- A bit above average enough to trigger a mention of it in the desc.
		player.tone = 55;
		//Nipples-  As above on size but the black sand trap nipples.
		player.createStatusAffect("Black Nipples",0,0,0,0);
		//Hair Length- Long
		player.hairLength = 16;
		//Hair Color- Black
		//Skin Color- Light
		player.skinTone = "light";
		//Starting Equipment: Wizard's Robe, Wizards Staff, and one White and one Black book in inventory.
		//equipArmor("inquisitor's corset",false);
		player.armor = armors.W_ROBES;
		if(player.hasPerk("Wizard's Endurance") < 0) player.createPerk("Wizard's Endurance",30,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		
		player.weapon = weapons.W_STAFF;
		//Gift Perk- Smarts
		player.createPerk("Smart",0,0,0,0);
		//History- Schooling
		player.createPerk("History: Scholar",0,0,0,0);
		player.itemSlot1.setItemAndQty(consumables.W__BOOK,1);
		player.itemSlot2.setItemAndQty(consumables.B__BOOK,1);
			
		player.gender = 2;
		player.tallness = 64;
		player.femininity = 75;
		player.buttRating = 7;
		player.hipRating = 7;
		player.inte = 40;
		player.str = 20;
		player.spe = 25;
		player.tou = 15;
		
		clearOutput();
		outputText("Your exotic appearance caused you some trouble growing up, but you buried your nose in books until it came time to go through the portal.");
	}
	if(player.short == "Prismere") {
		//Specific Character	Female, virgin, high fertility, tight with standard wetness and clit.
		player.createVagina();
		player.clitLength = 0.25;
		player.fertility = 4;
		player.spe += 20;
		outputText("You're more of a scout than a fighter, but you still feel confident you can handle your responsibilities as champion.  After all, what's to worry about when you can outrun everything you encounter?  You have olive skin, deep red hair, and a demonic tail and wings to blend in with the locals.");
		//Perk is speed, she was a scout, and it'd be neat (if possible) to give her something akin to the Runner perk. She might not start out very strong or tough, but at least she's fast.
		player.createPerk("Fast",0.25,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Runner",0,0,0,0,"CHEATER JACKASS JERKFACE");
		//In the human world, Prismere began as a scout, helping patrol areas with portals to make sure demonspawn and corruption didn't reach the human homeland. She's gotten herself into a few tight spots because of it, but she's hard to keep pinned down. She has a fiance back in her village whom she fully intends to get back to, so her libido isn't especially high. 
		//As of the time the PC takes her on, she has some signs of demonic taint, so Corruption might start at 5 to 10 points."	"Breasts at E, height at 5'0, a curvy build with a more narrow waist and substantial hips and butt. Skin is olive, like a mocha, hair is long and wildly wavy, a deep red, and eyes are a stormy blue. Muscles are barely visible; what muscle she has is the lean build of a runner, not a fighter. Nipples aren't especially long, but more soft. 
		player.cor = 5;
		player.createBreastRow();
		player.breastRows[0].breastRating = 7;
		player.tallness = 60;
		player.hipRating = 8;
		player.buttRating = 8;
		player.thickness = 25;
		player.tone = 40;
		player.skinTone = "olive";
		player.hairLength = 30;
		player.hairColor = "deep red";
		player.femininity = 90;
		//She has a demonic tail and small demonic wings thanks to some encounters early on with succubus milk (that stuff is delicious!) but is otherwise still human.
		player.wingType = WING_TYPE_BAT_LIKE_LARGE;
		player.wingDesc = "large, bat-like";
		player.tailType = TAIL_TYPE_DEMONIC;
		//I feel really weird talking about all this, so if there's anything you need to change or can't do, or if I totally misinterpreted this, just shoot me an email! jordie.wierenga@gmail.com . Thanks in advance... I'm a big fan. "	Prismere
	}
	if(player.short == "Mihari") {
		//[Values will be listed as if taken from Minerva]
		//I'm kinda going under the assumption you are letting us go hog wild if not, take what's allowed and do what you wish out of what's below
		outputText("The portal is not something you fear, not with your imposing armor and inscribed spellblade.  You're much faster and stronger than every champion that came before you, but will it be enough?");
		//Core Stats:
		player.str = 40;
		player.tou = 20;
		player.spe = 100;
		player.inte = 80;
		player.lib = 25;
		player.sens = 15;
		
		//Body Values:
		//breastRows
		player.createBreastRow();
		//-breastRating: 5
		//-breasts: 2
		//-nipplesPerBreast: 1
		player.breastRows[0].breastRating = 5;
		player.buttRating = 2;
		player.createVagina();
		player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_TIGHT;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
		player.vaginas[0].virgin = true;
		player.clitLength = 0.2;
		player.earType = EARS_CAT;
		player.faceType = FACE_CAT;
		player.femininity = 100;
		player.fertility = 85;
		player.gender = 2;
		player.hairColor = "blonde";
		player.hairLength = 24;
		player.hipRating = 6;
		player.lowerBody = LOWER_BODY_TYPE_CAT;
		player.nippleLength = 0.5;
		//perks:
		player.createPerk("Agility",0,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Evade",0,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Runner",0,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Fast",0.25,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Fertile",1.5,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("Flexibility",0,0,0,0,"CHEATER JACKASS JERKFACE");
		player.createPerk("History: Scholar",0,0,0,0,"CHEATER JACKASS JERKFACE");

		player.skinDesc = "fur";
		player.skinTone = "ashen";
		player.skinType = SKIN_TYPE_FUR;
		player.tailType = TAIL_TYPE_CAT;
		player.tallness = 55;
		player.teaseLevel = 4;
		player.thickness = 10;
		player.tone = 75;
		player.tongueType = TONUGE_HUMAN;
		
		//Posted everything above sorry if it wasn't supposed to go there.
		//starting equipment: black leather armor surrounded by voluminous robes
		//starting weapon: Spellblade if not gamebreaking otherwise spear is fine.
		player.armor = armors.LTHRROB;
		player.weapon = weapons.S_BLADE;
		if(player.hasPerk("Wizard's Focus") < 0) player.createPerk("Wizard's Focus",.5,0,0,0,"Your wizard's staff grants you additional focus, reducing the use of fatigue for spells.");

	}
	if(player.short == "Aria") {
		outputText("It's really no surprise that you were sent through the portal to deal with the demons - you look enough like one as-is.  Your numerous fetish-inducing piercings, magical fox-tails, and bimbo-licious personality were all the motivation the elders needed to keep you from corrupting the village youth.");
		//2/26/2013 8:18:21	rdolave@gmail.com	Character Creation	"female DD breasts feminity 100 butt size 5 hip size 5 body thickness 10 clit I would like her nipples pierced with Ceraphs piercing
		//(on a side note how much do you think it would cost to add bell nipple,labia and clit piercings as well as an option for belly button piercings would like to see belly button piecings with a few different options as well.  Also would love to have handcuff ear piercings.)"	Would like the bimbo brain and bimbo body perks as well as the nine tail perks.  demonic high heels, pink skin, obscenely long pink hair  would like her to be a kitsune with the nine tails.  pink fur.  starting equipment would like to be the succubus whip and nurse's outfit.  Also would like the xmas perk and all three Vday perks	Aria															
		if(!player.hasVagina()) player.createVagina();
		if(player.femininity < 80) player.femininity = 80;
		player.createPerk("Bimbo Body",0,0,0,0,"Cheater.");
		player.createPerk("Bimbo Brains",0,0,0,0,"Cheater.");
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 9;
		player.createPerk("Enlightened Nine-tails",0,0,0,0);
		player.breastRows[0].breastRating = 5;
		player.femininity = 100;
		player.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
		player.skinTone = "pink";
		player.skinType = SKIN_TYPE_FUR;
		player.skinDesc = "fur";
		player.hairColor = "pink";
		player.hairLength = 50;
		player.hipRating = 5;
		player.buttRating = 5;
		player.thickness = 10;
		flags[kFLAGS.PC_FETISH] = 2;
		player.earsPierced = 1;
		player.earsPShort = "green gem-stone handcuffs";
		player.earsPLong = "Green gem-stone handcuffs";
		player.nipplesPierced = 1;
		player.nipplesPShort = "seamless black nipple-studs";
		player.nipplesPLong = "Seamless black nipple-studs";
		flags[kFLAGS.PC_FETISH] = 2;
		player.vaginas[0].clitPierced = 1;
		player.vaginas[0].clitPShort = "emerald clit-stud";
		player.vaginas[0].clitPLong = "Emerald clit-stud";
		player.vaginas[0].labiaPierced = 2;
		player.vaginas[0].labiaPShort = "ruby labia-rings";
		player.vaginas[0].labiaPLong = "Ruby labia-rings";
		player.createPerk("Elven Bounty",0,15,0,0,"After your encounter with an elf, her magic has left you with increased fertility.");
		player.createPerk("Pure and Loving",0,0,0,0,"Q-q-quit peaking in my code, desu-chan!");
		player.createPerk("Sensual Lover",0,0,0,0,"Q-q-quit peaking in my code, desu-chan!");
		player.createPerk("One Track Mind",0,0,0,0,"Q-q-quit peaking in my code, desu-chan!");
		player.weapon = weapons.SUCWHIP;
		player.armor = armors.NURSECL;
		if(player.hasPerk("Slutty Seduction") < 0) player.createPerk("Slutty Seduction",8,0,0,0,"Your fetishy nurse outfit allows you access to an improved form of 'Tease'.");

	}
	if(player.short == "Lucina") {
		//428347355782040	Character Creation	Female,wetness=wet, Looseness=normal,not a virgin, Fertility high i guess i dont really care can be up to you.	for her face normal human, ears i want Elvin, no tails, just normal skin, body thickness i want to be slender, body tone kinda athletic but not too much, hair i want really long i think like a 30 on the codex number i think and her hair color light blonde, i want her to have normal D size breast with you can choose how you want them really though i dont think i really care, nipple size i dont care, her skin color a fair light light color but not too pale, for her starting equipment i want im not sure what i want her to wear but basically i want a Elvin archer with a bow. so maybe you can do something about the clothing. i just want a Elvin character in the game since theres goblins plus another archer besides kelt a female one add to that.	Lucina
		outputText("You're a blond, fair-skinned lass with a well-made bow and the skills to use it.  You have D-cup breasts and a very moist cunt that's seen a little action.  You're fit and trim, but not too thin, nor too well-muscled.  All in all, you're a good fit for championing your village's cause.");
		if(!player.hasVagina()) player.createVagina();
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
		player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
		player.vaginas[0].virgin = false;
		if(player.femininity < 80) player.femininity = 80;
		player.fertility = 40;
		player.earType = EARS_ELFIN;
		player.thickness = 25;
		player.tone = 60;
		player.hairLength = 30;
		player.hairColor = "light blonde";
		player.breastRows[0].breastRating = 4;
		player.skinTone = "light";
		//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
		player.createStatusAffect("Kelt",100,0,0,0);		
		player.createKeyItem("Bow",0,0,0,0);
	}
	if(player.short == "Rann Rayla") {
		//Specific Character	Virgin female.	Max femininity. Thin with a little muscle. Size C breasts. Long red hair. Light colored skin. 5'5" tall. 	Rann Rayla
		outputText("You're a young, fiery redhead who\'s utterly feminine.  You've got C-cup breasts and long red hair.  Being a champion can\'t be that bad, right?");
		player.createVagina();
		player.clitLength = 0.25;
		player.createBreastRow();
		player.breastRows[0].breastRating = 3;
		player.nippleLength = 0.5;
		player.hairLength = 22;
		player.hairColor = "red";
		player.skinTone = "light";
		player.skinDesc = "skin";
		player.skinType = SKIN_TYPE_PLAIN;
		player.femininity = 100;
		player.thickness = 25;
		player.tone = 65;
		player.tallness = 65;
	}
	if(player.short == "Charaun") {
		outputText("As a gifted fox with a juicy, thick knot, a wet cunt, and magical powers, you have no problems with being chosen as champion.");
		//Herm, Fox Cock: (27"l x 1.4"w, knot multiplier 3.6), No Balls, Cum Multiplier: 7,500, Vaginal Wetness: 5, Clit length: 0.5, Virgin, Fertility: 15	9-tailed "enlightened" kitsune( a pure-blooded kitsune with the "Enlightened Nine-tails" perk and magic specials) 
		if(!player.hasCock()) player.createCock();
		if(!player.hasVagina()) player.createVagina();
		player.gender = 3;
		player.cocks[0].cockLength = 27;
		player.cocks[0].cockThickness = 1.4;
		player.cocks[0].knotMultiplier = 3.6;
		player.cocks[0].cockType = CockTypesEnum.DOG;
		player.balls = 0;
		player.ballSize = 2;
		player.cumMultiplier = 7500;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
		player.clitLength = 0.5;
		player.fertility = 15;
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 9;
		player.createPerk("Enlightened Nine-tails",0,0,0,0);
		//if possible with fur, Hair color: "midnight black", Skin/Fur color: "ashen grayish-blue",  Height: 65", Tone: 100, Thickness: 0, Hip rating: 6, Butt rating: 3,Feminimity: 50,  ( 4 rows of breasts (Descending from the top ones: D,C,B,A), nipple length: 0.1", Fuckable, 1 nipple per breast, Tongue type: demon
		player.hairColor = "midnight black";
		player.skinType = SKIN_TYPE_FUR;
		player.skinDesc = "fur";
		player.skinTone = "ashen grayish-blue";
		player.tallness = 65;
		player.tone = 100;
		player.thickness = 0;
		player.hipRating = 6;
		player.buttRating = 3;
		player.femininity = 50;
		player.createBreastRow();
		player.createBreastRow();
		player.createBreastRow();
		player.breastRows[0].breastRating = 4;
		player.breastRows[0].fuckable = true;
		player.breastRows[1].breastRating = 3;
		player.breastRows[1].fuckable = true;
		player.breastRows[2].breastRating = 2;
		player.breastRows[2].fuckable = true;
		player.breastRows[3].breastRating = 1;
		player.breastRows[3].fuckable = true;
		player.tongueType = TONUGE_DEMONIC;
		player.nippleLength = 0.1;
		//Starting with an Inscribed Spellblade and Bondage Straps.	Charaun
		player.armor = armors.BONSTRP;
		if(player.hasPerk("Slutty Seduction") < 0) player.createPerk("Slutty Seduction",10,0,0,0,"Your fetishy bondage outfit allows you access to an improved form of 'Tease'.");
		player.weapon = weapons.S_BLADE;
		if(player.hasPerk("Wizard's Focus") < 0) player.createPerk("Wizard's Focus",.5,0,0,0,"Your wizard's staff grants you additional focus, reducing the use of fatigue for spells.");

	}
	if(player.short == "Navorn") {
		outputText("There's been something special about you since day one, whether it's your numerous sexual endowments or your supernatural abilities.  You're a natural pick for champion.");
		//Character Creation	"Herm same number and types of cocks from email sent earlier. 
		//Special abilities: Fire breath, fox fire?
		player.createPerk("Dragonfire",0,0,0,0,"You're a cheater, cheater.");
		//equipment: Large claymore, and platemail
		//-Chainmail armor
		player.armor = armors.FULLPLT;
		//-Large Claymore (i understand 40 Strength is need so if he could start with that would be great if not hit the gyms)"
		player.weapon = weapons.CLAYMOR;

		player.str = 41;
		//femininity: 95
		player.femininity = 95;
		//(0 lust cum production: 10000)
		player.cumMultiplier += 500;
		//(base fertility 20 if possible?)
		player.fertility = 20;
		//Appearence: 7ft 9in tall covered in thick shining silver fur, has a vulpine head and ears, eight breast all the same size at DD, dragon like wings, tail, and legs. With a large mare like pussy, 6 dicks, two equine, two dragon, two vulpine, all 15in long and 3 in wide, and four nuts 5 in across
		player.tallness = 93;
		player.skinTone = "black";
		player.skinType = SKIN_TYPE_FUR;
		player.skinDesc = "fur";
		player.hairColor = "silver";
		player.faceType = FACE_FOX;
		player.earType = EARS_FOX;
		player.createBreastRow();
		player.createBreastRow();
		player.createBreastRow();
		player.breastRows[0].breastRating = 5;
		player.breastRows[0].nipplesPerBreast = 4;
		player.breastRows[0].fuckable = true;
		player.breastRows[1].breastRating = 5;
		player.breastRows[1].nipplesPerBreast = 4;
		player.breastRows[1].fuckable = true;
		player.breastRows[2].breastRating = 5;
		player.breastRows[2].nipplesPerBreast = 4;
		player.breastRows[2].fuckable = true;
		player.breastRows[3].breastRating = 5;
		player.breastRows[3].nipplesPerBreast = 4;
		player.breastRows[3].fuckable = true;
		if(!player.hasCock()) player.createCock();
		player.createCock();
		player.createCock();
		player.createCock();
		player.createCock();
		player.createCock();
		player.cocks[0].cockType = CockTypesEnum.HORSE;
		player.cocks[0].cockLength = 15;
		player.cocks[0].cockThickness = 3;
		player.cocks[1].cockType = CockTypesEnum.HORSE;
		player.cocks[1].cockLength = 15;
		player.cocks[1].cockThickness = 3;
		player.cocks[2].cockType = CockTypesEnum.DOG;
		player.cocks[2].cockLength = 15;
		player.cocks[2].cockThickness = 3;
		player.cocks[2].knotMultiplier = 2;
		player.cocks[3].cockType = CockTypesEnum.DOG;
		player.cocks[3].cockLength = 15;
		player.cocks[3].cockThickness = 3;
		player.cocks[3].knotMultiplier = 2;
		player.cocks[4].cockType = CockTypesEnum.DRAGON;
		player.cocks[4].cockLength = 15;
		player.cocks[4].cockThickness = 3;
		player.cocks[5].cockType = CockTypesEnum.DRAGON;
		player.cocks[5].cockLength = 15;
		player.cocks[5].cockThickness = 3;
		player.balls = 4;
		player.ballSize = 5;
		//hair length: 15 in
		player.hairLength = 15;
		//hip size: 15/20
		player.hipRating = 15;
		//butt size: 15/20
		player.buttRating = 15;
		//body thickness: 50/100
		player.thickness = 50;
		//Muscle: 75/100"
		player.tone = 75;
		//for wetness a squirter, looseness a 2 and capacity at 140.
		if(!player.hasVagina()) player.createVagina();
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
		player.createStatusAffect("Bonus vCapacity",132,0,0,0);
		//Virgin, high fertility like in the email I sent before.  dragon wings, nine fox tails,  dragon legs, eight DD breasts with four fuckable nipples each, dragon tongue, waist length hair, large dragon wings.
		player.wingType = WING_TYPE_DRACONIC_LARGE;
		player.wingDesc = "large, draconic";
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 9;
		player.lowerBody = LOWER_BODY_TYPE_DRAGON;
		player.tongueType = TONUGE_DRACONIC;
		player.hairLength = 45;
		player.createPerk("Enlightened Nine-tails",0,0,0,0);
		player.gender = 3;
	}
	if(player.short == "Hikari") {
		//Character Creation	If possible I would like a herm with a cat cock that is 10 inches by 4 inches. Anything else is up to you.	I would like a herm catmorph with two large d breasts and shoulder length hair. Also if possible I would like to start with some gel armor. Everything else is fair game.	Hikari
		outputText("As a herm with a super-thick cat-cock, D-cup breasts, and out-of-this-world armor, you're a natural pick for champion.");
		if(!player.hasCock()) player.createCock();
		player.cocks[0].cockType = CockTypesEnum.CAT;
		player.cocks[0].cockLength = 10;
		player.cocks[0].cockThickness = 4;
		if(!player.hasVagina()) player.createVagina();
		player.breastRows[0].breastRating = 4;
		player.hairLength = 10;
		player.armor = armors.GELARMR;
		player.gender = 3;
	}
	if(player.short == "Isaac") {
		outputText("Born of a disgraced priestess, Isaac was raised alone until she was taken by illness.  He worked a number of odd jobs until he was eventually chosen as champion.");
		//- gift: fast
		player.spe += 5;
		player.tone += 10;
		player.createPerk("Fast", 0.25, 0, 0, 0,"Gain speed 25% faster.");
		//- history: religion 
		player.createPerk("History: Religious",0,0,0,0,"Rar, I'm religious.");
		//(and if possible)
		//- history: fighter
		player.createPerk("History: Fighter",0,0,0,0,"Rar, I'm a fighter.");
		//- history: smith
		player.createPerk("History: Smith",0,0,0,0,"Rar, I'm a smith");
		//in my ar, Issac was born to a disgraced priestess (she was raped by marauders) and raised by her alone until she died from an illness and was pretty much left to fend for and earn a living for himself (hence the fighter and smith background's too) until, years later he was chosen as 'champion'~
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//sex - male
		player.gender = 1;
		player.balls = 2;
		//- a pair of apple sized balls each measuring three inches across
		player.ballSize = 3;
		//anatomy - twin dicks
		//the first, a vulpine dick (12 in. long, 2.8 in. thick with a knot roughly 4.5 in. at full size) with a Fertite jacob's ladder piercing
		//and the second, a barbed feline dick (10 in. long and 2.5 in thick) with an Emerald jacob's ladder
		//heh, ribbed for their pleasure ;d lol
		player.createCock();
		player.createCock();
		player.cocks[0].cockLength = 12;
		player.cocks[0].cockThickness = 2.8;
		player.cocks[0].cockType = CockTypesEnum.DOG;
		player.cocks[0].knotMultiplier = 1.8;
		player.cocks[1].cockLength = 10;
		player.cocks[1].cockThickness = 2.5;
		player.cocks[1].cockType = CockTypesEnum.TENTACLE;
		player.cocks[0].pierced = 3;
		player.cocks[0].pShortDesc = "fertite cock-jacob's ladder";
		player.cocks[0].pLongDesc = "Fertite cock-jacob's ladder";
		player.createPerk("Pierced: Fertite",5,0,0,0,"You've been pierced with Fertite and any male or female organs have become more fertile.");
		//- and one tight asshole
		player.ass.analLooseness = 0;
		//- kitsune
		//- moderately long white hair (9 inches)
		player.hairLength = 9;
		player.hairColor = "silver-white";
		//- human face
		//- fox ears 
		player.earType = EARS_FOX;
		//- olive complexion
		player.skinTone = "olive";
		//- demon tongue (oral fetish ;d)
		player.tongueType = TONUGE_DEMONIC;
		//- 5 foot 9 inch tall
		player.tallness = 69;
		//- average build
		player.thickness = 50;
		//- body thickness of  around 50
		player.tone = 70;
		//- 'tone of about 70  
		//- two flat breasts each supporting one 0.2-inch nipple
		player.nippleLength = 0.2;
		player.createBreastRow();
		//- three fox tails
		player.tailType = TAIL_TYPE_FOX;
		player.tailVenom = 3;
		//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		//equipment;
		//- katana (don't suppose you could rename the katana 'Zon'ith' could you? ~.^)
		//Items: Katana, Leather Armor
		player.weapon = weapons.KATANA;
		//- robes
		player.armor = armors.M_ROBES;
	}
	//529315025394020	Character Creation	Neuter (no genitals) "50-50 masculine-feminine ratio. Shark teeth."	Rope
	if(player.short == "Rope") {
		outputText("Despite outward appearances, you're actually something of a neuter, with shark-like teeth, an androgynous face, and a complete lack of genitalia.");
		if(player.hasCock()) player.removeCock(0,1);
		if(player.hasVagina()) player.removeVagina();
		player.gender = 0;
		player.femininity = 50;
		player.faceType = FACE_SHARK_TEETH;
	}
	if(player.short == "Katti") {
		outputText("You have big breasts with big, fuckable nipples on them, and no matter what, your vagina always seems to be there to keep you company.");
		//Gender: Female	
		if(!player.hasVagina()) {
			player.createVagina();
			genderCheck();
		}
		//"Ears: Bunny
		player.earType = EARS_BUNNY;
		//Tail: Bunny
		player.tailType = TAIL_TYPE_RABBIT;
		//Face: Human
		//Breasts: H-cup with 4.5 inch fuckable nipples"
		player.breastRows[0].breastRating = 19;
		player.nippleLength = 4.5;
		player.breastRows[0].fuckable = true;
	}
	if(player.short == "Cody") {
		outputText("Your orange and black tiger stripes make you cut a more imposing visage than normal, and with your great strength, armor, and claymore, you're a natural pick for champion.");
		//well to start off the name would be Cody
		//-Cat with (black and orange tiger fur if possible) if not just Orange fur
		player.hairColor = "black and orange";
		player.skinType = SKIN_TYPE_FUR;
		player.skinDesc = "fur";
		//-Chainmail armor
		player.armor = armors.FULLCHN;
		//-Large Claymore (i understand 40 Strength is need so if he could start with that would be great if not hit the gyms)"
		player.str = 41;
		player.weapon = weapons.CLAYMOR;

	}
	if(player.short == "Annetta") {
		outputText("You're a rather well-endowed hermaphrodite that sports a thick, dog-knotted cock, an unused pussy, and a nice, stretchy butt-hole.  You've also got horns and demonic high-heels on your feet.  It makes you wonder why you would ever get chosen to be champion!");
		//Specific Character	"Gender: Herm
		//Penis: 13 inch long 3 inch wide penis, dog shaped, 6.5 inch knot
		//Balls: Four 5 inch wide
		//Vagina: Tight, virgin, 0.5 inch clitoris
		player.createVagina();
		player.createCock();
		player.createBreastRow();
		player.clitLength = 0.5;
		player.tallness = 67;
		player.femininity = 90;
		player.balls = 2;
		player.ballSize = 5;
		player.cocks[0].cockLength = 13;
		player.cocks[0].cockThickness = 3;
		player.cocks[0].knotMultiplier = 2.2;
		//Butt: Loose"	"Skin: Purple
		player.ass.analLooseness = 3;
		player.skinTone = "purple";
		//Hair: Back length orange
		player.hairLength = 30;
		player.hairColor = "orange";
		//Face: Elf ears, 4x demonic horns
		player.earType = EARS_ELFIN;
		player.horns = 4;
		player.hornType = HORNS_DEMON;
		//Body: Plump, no muscle tone, wide thighs, badonkulous ass, demon tail, demonic high heels
		player.thickness = 75;
		player.tone = 0;
		player.hipRating = 17;
		player.buttRating = 17;
		player.tailType = TAIL_TYPE_DEMONIC;
		player.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
		//Breasts: J-cups with 5 inch fuckable nipples, leaking milk
		player.breastRows[0].breastRating = 28;
		player.nippleLength = 5;
		player.breastRows[0].lactationMultiplier += 20;
		
		//Equipment: Starts with spiked fist
		player.weapon = weapons.S_GAUNT;
		//Perks: Fighter and Lotsa Jizz"	Annetta
		player.createPerk("History: Fighter",0,0,0,0,"");
		player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
		player.cumMultiplier = 20;
		player.gender = 3;
	}
	if(player.short == "Tyriana") {
		outputText("Your many, posh tits, incredible fertility, and well-used cunt made you more popular than the village bicycle.  With your cat-like ears, paws, and tail, you certainly had a feline appeal.  It's time to see how you fare in the next chapter of your life.");
		//"Gender: Female
		player.gender = 2;
		//Vagina: Ridiculously loose, 3 inch clitoris, dripping constantly, fertile like a bunny on steroids and non-virgin
		player.createVagina();
		player.clitLength = 3;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
		player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LEVEL_CLOWN_CAR;
		player.vaginas[0].virgin = false;
		player.fertility = 50;
		//Butt: Just as loose
		player.ass.analLooseness = 5;
		//"Skin: Tanned
		player.skinTone = "tan";
		//Hair: Ridiculously long red
		player.hairLength = 80;
		player.hairColor = "red";
		//Face: Gorgeous Feminine, long demonic tongue, cat ears
		player.femininity = 100;
		player.tongueType = TONUGE_DEMONIC;
		player.earType = EARS_CAT;
		//Body: Very muscular, average weight, plump ass, above average thighs, cat tail and cat paws
		player.tone = 80;
		player.thickness = 50;
		player.buttRating = 12;
		player.hipRating = 10;
		player.tailType = TAIL_TYPE_CAT;
		player.lowerBody = LOWER_BODY_TYPE_CAT;
		//Breasts: 2 E-cups on top, 2 DD-cups mid, 2 D-cups bottom, 3.5 inch nipples
		player.createBreastRow();
		player.createBreastRow();
		player.createBreastRow();
		player.tallness = 67;
		player.breastRows[0].breastRating = 7;
		player.breastRows[1].breastRating = 5;
		player.breastRows[2].breastRating = 4;
		player.nippleLength = 3.5;
		//Perks: Slut and Fertile"	
		
		player.spe+=3;
		player.inte+=2;
	
		player.createPerk("History: Slut",0,0,0,0,"");
		player.createPerk("Fertile", 1.5, 0, 0, 0,"Makes you 15% more likely to become pregnant.");
		player.teaseLevel = 3;
	}
	if(player.short == "Gundam") {
		outputText("You're fabulously rich, thanks to a rather well-placed bet on who would be the champion.  Hopefully you can buy yourself out of any trouble you might get in.");
		player.gems = 1500 + rand(1000);
		//for my custom character profile i want the name to be gundam all i want is to start out with around 1000-2500 gems like as a gift from the elder or something to help me out.
	}
	if(player.short == "Charlie") {
		outputText("You're strong, smart, fast, and tough.  It also helps that you've got four dongs well beyond what others have lurking in their trousers.  With your wings, bow, weapon, and tough armor, you're a natural for protecting the town.");
		player.gender = 1;
		player.tou +=2;
		player.str += 3;
		player.fertility = 5;
		player.hairLength= 26;
		player.hairColor = "blond";
		player.skinTone = "light";
		player.nippleLength = 0.2;
		player.createBreastRow();
		player.breastRows[0].breastRating = 0;
		player.balls = 2;
		player.ballSize = 3;
		player.tallness = 113;
		player.tone = 50;
		player.thickness = 50;
		player.femininity = 50;
		player.hipRating = 5;
		player.buttRating = 5;
		player.teaseLevel = 1;
		//Large feathered wings (Any chance in heck I could get 'angel' as the race descriptor? Just asking. I'm fine if the answer is 'no')
		player.wingType = WING_TYPE_FEATHERED_LARGE;
		player.wingDesc = "large, feathered";
		
		//While we're on the subject, would glowing eyes be possible? I'll take normal eyes if not.
		//Beautiful Sword
		player.weapon = weapons.B_SWORD;
		player.armor = armors.SSARMOR;
		//Beautiful Armor (Or just Spider Silk Armor)
		//Pure Pearl
		//Tallness 84 (8 feet 0 inches)
		player.tallness = 84;
		//Femininity 10
		player.femininity = 10;
		//Thickness 50
		player.thickness = 50;
		//Tone 90
		player.tone = 90;
		//Int 50 (if possible)
		player.inte = 50;
		//Str/Tou/Spd 25 (if possible)
		player.str = 25;
		player.tou = 25;
		player.spe = 25;
		//Bow
		player.createKeyItem("Bow",0,0,0,0);
		//Bow skill 100 (Sorry Kelt, I can't hear your insults over my mad Robin Hood skillz)
		player.createStatusAffect("Kelt",100,0,0,0);
		//Is it possible to get extra starting perks added? If so, I'd like History: Religious added to whatever is selected on creation. If not, please ignore this line.
		//Freckled skinAdj
		player.skinAdj = "freckled";
		//10 Perk Points (if possible, feel free to make it less if you feel it necessary)
		player.perkPoints = 10;
		//Male
		player.gender = 1;
		//Would it be possible to code a cock type that morphs into different cock types? (i.e. it loads a different cock type description each sex scene) If so, I'd like him to have a pair of them, one 24 inches long and 3 inches wide and the second 12-inches long and 2 inches wide. If not, I'll take a dragon and horse cock at 24/3 each as well as a dog and cat cock at 12/2 each.
		player.createCock();
		player.createCock();
		player.createCock();
		player.createCock();
		player.cocks[0].cockLength = 24;
		player.cocks[0].cockThickness = 3;
		player.cocks[0].cockType = CockTypesEnum.HORSE;
		player.cocks[1].cockLength = 24;
		player.cocks[1].cockThickness = 3;
		player.cocks[1].cockType = CockTypesEnum.DRAGON;
		player.cocks[2].cockLength = 12;
		player.cocks[2].cockThickness = 2;
		player.cocks[2].cockType = CockTypesEnum.DOG;
		player.cocks[3].cockLength = 12;
		player.cocks[3].cockThickness = 2;
		player.cocks[3].cockType = CockTypesEnum.CAT;

		//A pair of 8-inch balls
		player.balls = 2;
		player.ballSize = 8;
		//A virility boost would be nice too if possible.
		player.cumMultiplier = 50;
	}
	if(player.short == "Sera") {
		outputText("You're something of a shemale - three rows of C-cup breasts matched with three, plump, juicy cocks.  Some decent sized balls, bat wings, and cat-like ears round out the package.");
		player.gender = 1;
		player.tou +=2;
		player.str += 3;
		player.fertility = 5;
		player.hairLength= 26;
		player.hairColor = "white";
		player.skinTone = "light";
		player.nippleLength = 0.2;
		player.createBreastRow();
		player.createBreastRow();
		player.createBreastRow();
		player.breastRows[0].breastRating = 3;
		player.breastRows[1].breastRating = 3;
		player.breastRows[2].breastRating = 3;
		player.createCock();
		player.createCock();
		player.createCock();
		player.cocks[0].cockLength = 8;
		player.cocks[0].cockThickness = 1.6;
		player.cocks[1].cockLength = 8;
		player.cocks[1].cockThickness = 1.6;
		player.cocks[2].cockLength = 8;
		player.cocks[2].cockThickness = 1.6;
		player.balls = 2;
		player.ballSize = 3;
		player.tallness = 113;
		player.tone = 50;
		player.thickness = 50;
		player.femininity = 50;
		player.hipRating = 5;
		player.buttRating = 5;
		player.teaseLevel = 1;
		//Build: average
		//Complexion: light
		//9 foot 5 inches tall
		//Hair: very long white
		//Gift: Lotz of Jizz
		//History: Schooling
		player.cumMultiplier = 5.5;
		
		player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
		player.createPerk("History: Scholar",0,0,0,0,"");
		//Apperance: Cat Ears, Large Bat Like Wings, 3 Rows of breasts (C cub, 0,2 nipples)
		player.earType = EARS_CAT;
		player.wingType = WING_TYPE_BAT_LIKE_LARGE;
		player.wingDesc = "large, bat-like";
		//Items: Katana, Leather Armor
		player.weapon = weapons.KATANA;
		player.armor = armors.URTALTA;
		//Key Item: Deluxe Dildo
		player.createKeyItem("Deluxe Dildo",0,0,0,0);
	}
	if(player.short == "Mirvanna") {
		//Any equine or dragonny attributes accompanying it a big plus! As I'm a dragon-unicorn furry (Qilin~). Bonus points if you add a horn type for unicorn horn. 
		outputText("You're an equine dragon-herm with a rather well-proportioned body.  Ingnam is certainly going to miss having you whoring yourself out around town.  You don't think they'll miss cleaning up all the messy sex, though.");
		player.gender = 3;
		player.spe+=3;
		player.inte+=2;
		player.str += 3;
		player.clitLength = .5;
		player.fertility = 20;
		player.hairLength= 15;
		player.createBreastRow();
		player.createVagina();
		player.createCock();
		player.tallness = 73;
		player.breastRows[0].breastRating = 5;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
		player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
		player.vaginas[0].virgin = false;
		player.tone = 20;
		player.hipRating = 8;
		player.buttRating = 8;
		player.femininity = 75;
		player.thickness = 33;
		player.hairColor = "platinum blonde";
		player.teaseLevel = 1;
		//Mirvanna;
		//Gender = Herm
		//Ears = Horse
		player.earType = EARS_HORSE;
		//Horns = Dragon
		player.hornType = HORNS_DRACONIC_X4_12_INCH_LONG;
		player.horns = 12;
		//Face = Horse
		player.faceType = FACE_HORSE;
		//Skin type = Black Fur
		player.skinTone = "brown";
		player.skinType = SKIN_TYPE_FUR;
		player.hairColor = "black";
		player.skinDesc = "fur";
		//Legs/Feet = Digigrade hooved 
		player.lowerBody = LOWER_BODY_TYPE_HOOFED;
		//Wing type = Dragon
		player.wingType = WING_TYPE_DRACONIC_LARGE;
		player.wingDesc = "large, draconic";
		//Tail type = Dragon
		player.tailType = TAIL_TYPE_DRACONIC;
		//Cock type = Equine
		player.cocks[0].cockType = CockTypesEnum.HORSE;
		player.cocks[0].cockLength = 14;
		player.cocks[0].cockThickness = 2.5;
		//Vulva Type = Equine
		
		//Beautiful Sword & Wizard Robe
		player.weapon = weapons.B_SWORD;
		if(player.hasPerk("Wizard's Endurance") < 0) player.createPerk("Wizard's Endurance",0,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		player.armor = armors.W_ROBES;
		//Herm, lots of jizz.
		player.femininity -= 2;
		player.cumMultiplier = 5.5;
		player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
		player.createPerk("History: Whore",0,0,0,0,"");
	}
	if(player.short == "Mara") {
		//#226096893686530
		//For the custom PC Profile can you make a Bimbo Bunny girl (no bunny feet) (named Mara) dont really care about clothes i can get what i want pretty quickly and I change from time to time.
		outputText("You're a bunny-girl with bimbo-tier curves, jiggly and soft, a curvy, wet girl with a bit of a flirty past.");
		player.gender = 2;
		player.spe+=3;
		player.inte+=2;
		player.clitLength = .5;
		player.tone = 30;
		player.fertility = 10;
		player.hairLength= 15;
		player.createBreastRow();
		player.createVagina();
		player.tallness = 67;
		player.breastRows[0].breastRating = 7;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
		player.vaginas[0].virgin = false;
		player.tone = 20;
		player.hipRating = 12;
		player.buttRating = 12;
		player.femininity = 100;
		player.thickness = 33;
		player.createPerk("History: Slut",0,0,0,0,"");
		player.createPerk("Bimbo Body",0,0,0,0,"");
		player.createPerk("Bimbo Brains",0,0,0,0,"");
		player.createPerk("Big Tits", 1.5, 0, 0, 0,"Makes your tits grow larger more easily.");
		player.earType = EARS_BUNNY;
		player.tailType = TAIL_TYPE_RABBIT;
		player.skinTone = "tan";
		player.hairColor = "platinum blonde";
		player.teaseLevel = 3;
	}
}

