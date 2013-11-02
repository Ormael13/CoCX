function lumiEncounter():void {
	outputText("", true);
	//1st time lumi meeting
	if(flags[UNKNOWN_FLAG_NUMBER_00053] == 0) {
		//placeholder text for outside the cathedral
		outputText("You spot an anomaly in the barren wastes; a door that seems to be standing out in the middle of nowhere. Somehow, you figure that it must lead to some other part of the world, and the only reason it's here is because you can't get to where the door should be right now.\n\n", false);
		outputText("Do you open it?", false);
		doYesNo(lumiLabChoices,13);
	}
	else {
		//placeholder text for outside the cathedral
		outputText("You spot the door standing in the middle of nowhere again, and you guess that it will lead you back to Lumi's laboratory.  It swings open easily...", false);
		doNext(lumiLabChoices);
	}
//end of placeholder text
}

function lumiLabChoices():void {
	spriteSelect(37);
	outputText("", true);
	//First time meeting
	if(flags[UNKNOWN_FLAG_NUMBER_00053] == 0) {
		//Set Lumi met flag 
		flags[UNKNOWN_FLAG_NUMBER_00053]++;
		outputText("You open the door and carefully check inside for any enemies that may be trying to ambush you. The room seems to be some kind of alchemical lab, with shelves full of apparatuses all along the walls, a desk on one side of the room, and a long table across the room from you that is full of alchemical experiments in progress, many give off lots of smoke, and others are bottles of bubbling fluids.  A goblin wearing an apron and some kind of headband is sitting on a tall, wheeled stool; she is otherwise nude and seems to be watching at least 3 experiments right now. She suddenly turns around and looks straight in your direction.  It's hard to tell thanks to the dark goggles that hide her eyes from view, but you're fairly certain she's watching you.  After a few seconds she yells \"<i>Cuths-tohmer!</i>\" in a thick lisp. She looks harmless enough, so you step inside while she fiddles with her experiments, reducing the bubbling smoke.  She jumps down from her stool, tears off her apron, bounds over to the desk, and scrambles on top of it.\n\n", false);

		outputText("She's about 3 feet tall, with yellow-green skin, and wears her orange hair in a long ponytail that reaches to her knees.  Her breasts are about B cup, with average nipples that have been colored orange. All of her nails have been painted orange to match. She doesn't seem to ever stop moving, and while the majority of her face looks cute, it's a little hard to be sure while she's wearing those thick goggles.  The solid black lenses of her goggles make her look quite unsettling, stifling any appeal her form could inspire in you.\n\n", false);

		outputText("\"<i>Stho, what can Lumi, Gobin Aochomist Extwaordinaire, do fo you today?</i>\" asks the unusual goblin.\n\n", false);
		
		outputText("You explain that it's a little hard to understand her.  She sticks her tongue out at you, showing a VERY large stud in the middle of it, instantly explaining her lisp.  Rather than pushing the point, you ask her what she can do for you.  She pulls open a hatch on the top of the desk and pulls out a bottle of something and shakes it, \"<i>Lumi can sell you some of her finely cwafted poetions fo a good pwice, ore, if you've alweady got some nice poetions or reagents, Lumi can make them even bettar. But tha cost a whole lot. If you were one of dee Followers, den maybe Lumi could make a special deal wit you; but the boss don't want me playin wit outsiders. Wat will it be?</i>\"\n\n", false);
	}
	//Repeat Meetings
	else {
		outputText("Once more, you step into Lumi's lab.  She's still working on her experiments. Before you even have a chance to call out to her, she has already pivoted to watch you.  In a flash her apron hits the floor and she is standing on her desk, asking, \"<i>Stho, what can Lumi the Aochomist Extwaordinaire do fo you today?</i>\"", false);
	}
	var enhance = 0;
	if(lumiEnhance(true)) 
		enhance = lumiEnhance;
	simpleChoices("Shop",lumiShop,"Enhance",enhance,"",0,"",0,"Leave",13);
}

function lumiShop():void {
	spriteSelect(37);
	//Set item handling to lumi shop
	menuLoc = 12;
	outputText("", true);
	outputText("You ask Lumi if you can see her potions.  She smiles at you and pulls out several bottles from her desk and shows them to you.\n\n\"<i>Gawantied qwality, made by Lumi herself,</i>\" she says proudly.\n\n", false);
	outputText("Lust Draft - 15 gems\nGoblin Ale - 20 gems\nOviposition Elixir - 45 gems\n", false);
	
	//The player is given a list of choices, clicking on one gives the description and the price, like Giacomo.
	simpleChoices("LustDraft",lumiLustDraftPitch,"GoblinAle",lumiPitchGobboAle,"OviElixir",lumiPitchOviElixer,"",0,"Leave",lumiLabChoices);
}

//Lust Draft
function lumiLustDraftPitch():void {
	spriteSelect(37);
	outputText("", true);
	outputText("You point at the bottle filled with bubble-gum pink fluid.\n\n\"<i>De lust dwaft? Always a favowite, with it you nevar have to worwy about not bein weady for sexy time; one of my fiwst creations. 15 gems each.</i>\"\n\n", false);
	shortName = "L.Draft";
	outputText("Will you buy the lust draft?", false);
	doYesNo(lumiPurchase,lumiShop);
}
//Goblin Ale
function lumiPitchGobboAle():void {
	spriteSelect(37);
	outputText("", true);
	outputText("You point at the flagon. \"<i>Oh? Oh thats Lumi's... actually no, dat tispsy stuff for 20 gems. You'll like if you want to be like Lumi. Do you like it?</i>\"\n\n", false);
	shortName = "Gob.Ale";
	outputText("Will you buy the goblin ale?", false);
	doYesNo(lumiPurchase,lumiShop);
}
//Ovi Elixir
function lumiPitchOviElixer():void {
	spriteSelect(37);
	outputText("", true);
	outputText("You point at the curious hexagonal bottle. \"<i>De Oviposar Elixir? Made baithsed on da giant bee's special stuff dey give deir queen. It will help make de burfing go faster, an if you dwink it while you awen pweggy, iw will give you some eggs to burf later. More dwinks, eqwals more and biggar eggs. Lumi charges 45 gems for each dose.</i>\"\n\n", false);
	shortName = "OviElix";
	outputText("Will you buy the Ovi Elixir?", false);
	doYesNo(lumiPurchase,lumiShop);
}


function lumiPurchase():void {
	spriteSelect(37);
	outputText("", true);
	//After choosing, and PC has enough gems
	var cost:Number = 0;
	var itemName:String = shortName;
	if(shortName == "OviElix") 
		cost = 45;
	if(shortName == "Gob.Ale") 
		cost = 20;
	if(shortName == "L.Draft") 
		cost = 15;
	if(player.gems >= cost) {
		outputText("You pay Lumi the gems, and she hands you " + itemLongName(itemName) + " saying, \"<i>Here ya go!</i>\"\n\n", false);
		player.gems -= cost;
		statScreenRefresh();
		shortName = itemName;
		takeItem();
		return;
	}
	//After choosing, and PC doesn't have enough gems
	else {
		outputText("You go to pay Lumi the gems, but then you realize that you don't have enough. Lumi seems to know what happened and tells you \"<i>Ok, is dere somefing you want to buy that you can affowd?</i>\"\n\n", false);
		//Return to main Lumi menu
		doNext(lumiShop);
	}
}

function lumiEnhance(justCheck:Boolean = false):Boolean {
	spriteSelect(37);
	var fox = 0;
	if(hasItem("FoxBery",1)) 
		fox = lumiEnhanceFox;
	var laBova = 0;
	if(hasItem("LaBova ",1)) 
		laBova = lumiEnhanceLaBova;
	var succuDelight = 0;
	if(hasItem("SDelite",1)) 
		succuDelight = lumiEnhanceSDelight;
	var oviElix = 0;
	//if(hasItem("OviElix",1)) 
	//	oviElix = lumiEnhanceOviElix;
	var lustDraft = 0;
	if(hasItem("L.Draft",1)) 
		lustDraft = lumiEnhanceDraft;
	var seed = 0;
	if(hasItem("GldSeed",1)) 
		seed = lumiEnhanceGoldenSeed;
	var kanga = 0;
	if(hasItem("KangaFt",1)) 
		kanga = lumiEnhanceKanga;
	var kitsune = 0;
	if(hasItem("FoxJewl",1)) 
		kitsune = lumiEnhanceFoxJewel;
	if(justCheck) {
		if(fox || kanga || seed || laBova || succuDelight || oviElix || lustDraft || kitsune)
			return true;
		else 
			return false;
	}
	outputText("", true);
	outputText("\"<i>Do you have 100 gems for de enhancement?</i>\" asks Lumi.\n\n", false); 
	//If (player has less than 100 gems)
	if(player.gems < 100) {
		outputText("You shake your head no, and Lumi gives you a disappointed look and says, \"<i>Den Lumi can do no enhancement for you. Anyfing else?</i>\"\n\n", false);
		//Return to main Lumi menu
		doNext(lumiLabChoices);
		return false;
	}
	else {
		outputText("You nod and Lumi gives an excited yell, \"<i>Yay! Lumi loves to do enhancement, what you want to be bettar?</i>\"\n\n", false);
		//The player chooses an item that can be enhanced from a list, regardless of which is chosen, the text for the next part is the same.
		choices("FoxBery",fox,"Fox Jewel",kitsune,"GoldenSeed",seed,"KangaFruit",kanga,"L.Draft",lustDraft,"LaBova",laBova,"OviElix",oviElix,"SDelite",succuDelight,"",0,"Back",2435);
		return true;
	}
	return false;
}
function lumiEnhanceLaBova():void {
	shortName = "LaBova ";
	lumiEnhanceGo();
}
function lumiEnhanceSDelight():void {
	shortName = "SDelite";
	lumiEnhanceGo();
}
function lumiEnhanceOviElix():void {
	shortName = "OviElix";
	lumiEnhanceGo();
}
function lumiEnhanceDraft():void {
	shortName = "L.Draft";
	lumiEnhanceGo();
}
function lumiEnhanceGoldenSeed():void {
	shortName = "GldSeed";
	lumiEnhanceGo();
}
function lumiEnhanceKanga():void {
	shortName = "KangaFt";
	lumiEnhanceGo();
}
function lumiEnhanceFox():void {
	shortName = "FoxBery";
	lumiEnhanceGo();
}
function lumiEnhanceFoxJewel():void {
	shortName = "FoxJewl";
	lumiEnhanceGo();
}

function lumiEnhanceGo():void {
	spriteSelect(37);
	trace("LUMI ENHANCE");
	var nextItem:String = "";
	if(shortName == "LaBova ") {
		nextItem = "ProBova";
	}
	else if(shortName == "KangaFt") {
		nextItem = "MghtyVg";
	}
	else if(shortName == "SDelite") {
		nextItem = "S.Dream";
	}
	else if(shortName == "OviElix") {
		nextItem = "OviMax ";
	}
	else if(shortName == "L.Draft") {
		nextItem = "F.Draft";
	}
	else if(shortName == "GldSeed") {
		nextItem = "MagSeed";
	}
	else if(shortName == "FoxBery") {
		nextItem = "VixVigr";
	}
	else if(shortName == "FoxJewl") {
		nextItem = "MystJwl";
	}
	player.gems -= 100;
	statScreenRefresh();
	consumeItem(shortName,1);
	outputText("", true);
	outputText("Lumi grabs the item from you and runs over to her table, stopping for only a second to put her apron on.  ", false);
	//start list of possible enhancement texts
	temp = rand(3);
	if(shortName == "GldSeed") outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing seed with a gloved hand.\n\n", false);
	else if(shortName == "FoxJewl") outputText("Lumi stares wide-eyed into the fathoms of its depths.  She remains like that for several moments before you clear your throat, and then hurries off to work.  Flitting back and forth between the various beakers and test tubes that litter the workshop, she mixes chemicals seemingly at random, many of which bubble or explode rather violently.\n\nAfter several minutes of this, she pours all of the reagents into a large beaker over an open flame.  The contents boil up through the neck of the flask and drip slowly down the condenser.  A ponderously large drop of black liquid builds up at the tip of the condenser, wobbling precipitously for a moment before finally falling onto the jewel with a splash.\n\nThe jewel soaks up the black fluid like a sponge, veins of sickening purple spreading across the surface like a spider's web.  A few moments later, the jewel is entirely purple, the mystic flames inside glowing a bright violet.\n\nYou reach out hesitantly and place the mystically enhanced teardrop-shaped jewel into your pouch.\n\n");
	else if(shortName == "KangaFt") outputText("She fiddles with it, coating it in exotic powders before she tosses the whole mess onto a hotplate.  It explodes, knocking the goblin flat on her ass.  She sits bolt upright and snatches up the now-glowing fruit with a gloved hand.\n\n", false);
	else if(temp == 0) outputText("She starts grabbing things from around the table, seemingly at random, and adds them to " + itemLongName(shortName) + ".  To your alarm, there is soon a large cloud of smoke coming off it! There is a strong smell to the smoke and it makes it hard to breathe.  Lumi grabs a mask out of a drawer and puts it on, continuing with her work unperturbed.  She suddenly stops and you wonder if she is done, but she takes off her mask and inhales deeply of the smoke, then keels over!  As you go over to help her she suddenly stands up, waves away some of the smoke, and says, \"<i>All dun!</i>\"\n\n", false);
	else if(temp == 1) outputText("Taking hold of one of the bottles that were sitting where she put the tray, she seems to think for a moment before tossing the bottle into one of the corners of the room.  It shatters just behind the table, and a small puff of smoke goes up into the air.  You're a little nervous about that bottle, but before you have a chance to say anything, two more bottles fly off and join it; this time causing a small explosion. You ask her what she is thinking tossing those aside, and she simply responds, \"<i>Dey were in my way.</i>\"\n\n\"<i>What?!  So you just toss things that explode to the side?</i>\"\n\n<i>\"Don worry, I'll put counter agents in dere at de end of de day.  An I never throw stuff da'll do any damage.  Done!</i>\"\n\n", false);
	else if(temp == 2) outputText("She adds a few things to the tray before moving down the table.  She adds some reagents to a bubbling chemical reaction, and then adds some more ingredients to that.  You wonder why she just left " + itemLongName(shortName) + " there to work on something else.  Then Lumi moves back across the table, past where " + itemLongName(shortName) + " sits, to start adding things to something else.  Before you have a chance to complain, she moves back to " + itemLongName(shortName) + " and continues.  You decide that it's probably best not to ask about her work ethic and just let her do her thing; she has more experience than you, after all.\n\nPOP! You look over in surprise as the first thing she worked on makes a small explosion.  POW! Now the second experiment has blown up!  You start to move in alarm, wondering if Lumi really knows what she's doing; just before " + itemLongName(shortName) + " seems to explode with an incredible BOOM.  Lumi stops moving for a moment, looking straight ahead before saying, \"<i>Dat was a gud one, Lumi dun!</i>\"\n\n", false);
	shortName = nextItem;
	menuLoc = 13;
	takeItem();
}
