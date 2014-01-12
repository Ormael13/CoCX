public function doItems(eventNo:Number):void {
	var temp1:* = 0;
	var temp2:* = 0;
	var temp3:* = 0;
	var temp4:* = 0;
	var temp5:* = 0;
	var kath:* = 0;
	var nieve:* = 0;
	var ember:* = 0;
	var fuckPlant:* = 0;
	var plantT:String = "Plant";
	if(eventNo == 1000) {
		itemSwapping = false;
		hideUpDown();
		if(player.hasStatusAffect("Gotta Open Gift") >= 0) {
			clearOutput();
			player.removeStatusAffect("Gotta Open Gift");
			mutations.kitsuneGiftResult();
			return;
		}
		if(player.itemSlot1.quantity > 0) temp1 = 1011;
		if(player.itemSlot2.quantity > 0) temp2 = 1012;
		if(player.itemSlot3.quantity > 0) temp3 = 1013;
		if(player.itemSlot4.unlocked && player.itemSlot4.quantity > 0) temp4 = 1014;
		if(player.itemSlot5.unlocked && player.itemSlot5.quantity > 0) temp5 = 1015;
		outputText("<b><u>Equipment:</u></b>\n", true);
		outputText("<b>Weapon</b>: " + player.weaponName + " (Attack - " + player.weaponAttack + ")\n", false);
		outputText("<b>Armor : </b>" + player.armorName + " (Defense - " + player.armorDef + ")\n", false);
		if(player.keyItems.length > 0) outputText("<b><u>\nKey Items:</u></b>\n", false);
		temp = 0;
		while(temp < player.keyItems.length) {
			outputText(player.keyItems[temp].keyName + "\n", false);
			temp++
		}
		if(!inCombat() && inDungeon == 0) {
			if(player.hasKeyItem("Dragon Egg") >= 0) {
				emberScene.emberCampDesc();
				ember = emberScene.emberEggInteraction;
			}
			if(nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5) {
				if(flags[kFLAGS.NIEVE_STAGE] == 1) outputText("\nThere's some odd snow here that you could do something with...\n");
				else outputText("\nYou have a snow" + nieveMF("man","woman") + " here that seems like it could use a little something...\n");
				nieve = 3964;
			}
			if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && inDungeon == 0) {
				fuckPlant = holliScene.treeMenu;
				if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 3) plantT = "Tree";
				//Blurb in Items Screen
				if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) outputText("\nHolli is in her tree at the edges of your camp.  You could go visit her if you want.\n");
			}
		}
		//If3 no items
		if(temp1 + temp2 + temp3 + temp4 + temp5 + ember + fuckPlant + nieve == 0) {
			outputText("\nYou have no usable items.", false);
			doNext(1);
			return;
		}
		if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv1("Sealed") == 3) {
			outputText("\nYou reach for your items, but you just can't get your pouches open.  <b>Your ability to use items was sealed, and now you've wasted a chance to attack!</b>\n\n");
			enemyAI();
			return;
		}
		outputText("\nWhich item will you use?", false);		
		if(gameState == 1) choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), temp1, (player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), temp2, (player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), temp3, (player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), temp4, (player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 5000);
		else choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), temp1, (player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), temp2, (player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), temp3, (player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), temp4, (player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), temp5, "", 0, "Snow", nieve, plantT, fuckPlant, "Egg", ember, "Back", 1);
		menuLoc = 1;
	}
	if(eventNo == 1001) 
		takeItem();
	//The next five are for overwriting item slots with new items. 
	//Called from takeItem()

	if ((eventNo == 1002) || (eventNo == 1003) || (eventNo == 1004) || (eventNo == 1005) || (eventNo == 1006))
	{

		var slotTmp:ItemSlotClass;
		switch (eventNo)
		{
			case 1002:
				slotTmp = player.itemSlot1;
				break;
			case 1003:
				slotTmp = player.itemSlot2;
				break;
			case 1004:
				slotTmp = player.itemSlot3;
				break;
			case 1005:
				slotTmp = player.itemSlot4;
				break;
			case 1006:
				slotTmp = player.itemSlot5;
				break;
		}

		//If it is the same as what's in the slot...just throw away the new item
		if(slotTmp.shortName == shortName) outputText("You discard " + itemLongName(slotTmp.shortName) + " from the stack to make room for the new one.", true);
		//If they are different...
		else {
			if(slotTmp.quantity == 1) outputText("You throw away " + itemLongName(slotTmp.shortName) + " and replace it with " + itemLongName(shortName) + ".", true);
			else outputText("You throw away " + itemLongName(slotTmp.shortName) + "(x" + slotTmp.quantity + ") and replace it with " + itemLongName(shortName) + ".", true);
			slotTmp.quantity = 1;
			slotTmp.shortName = shortName;
		}
		itemGoNext();
	}

	if ((eventNo == 1011) || (eventNo == 1012) || (eventNo == 1013) || (eventNo == 1014) || (eventNo == 1015))
	{
		switch (eventNo)
		{
			case 1011:
				slotTmp = player.itemSlot1;
				break;
			case 1012:
				slotTmp = player.itemSlot2;
				break;
			case 1013:
				slotTmp = player.itemSlot3;
				break;
			case 1014:
				slotTmp = player.itemSlot4;
				break;
			case 1015:
				slotTmp = player.itemSlot5;
				break;
		}
		var shortName_:String = slotTmp.shortName;
		if(!debug) slotTmp.removeOneItem();

		itemUse(shortName_);
		if(!itemSubMenu && !itemSwapping) 
		{
			if(!inCombat()) 
				doNext(1000);
			else if(menuLoc == 1) 
			{
				menuLoc = 0;
				if(!combatRoundOver()) 
				{
					outputText("\n\n");
					enemyAI();
				}
			}
		}
	}

	//Use looted item
	if(eventNo == 1016) {
		itemUse(shortName);
		if(!itemSwapping && !itemSubMenu) itemGoNext();
		itemSwapping = false;
	}
	//Auburn Dyes
	/*	if(shortName1 == "Red Dye") return "a vial of red hair dye";
	if(shortName1 == "Blond D") return "a vial of blond hair dye";
	if(shortName1 == "Black D") return "a vial of black hair dye";
	if(shortName1 == "Brown D") return "a vial of brown hair dye";
	if(shortName1 == "AuburnD") return "a vial of auburn hair dye";
	if(shortName1 == "GrayDye") return "a vial of gray hair dye";*/
	if(eventNo == 1017) {
		spriteSelect(49);
		outputText("", true);
		shortName = "AuburnD";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	if(eventNo == 1018) {
		spriteSelect(49);
		outputText("", true);
		shortName = "Black D";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	if(eventNo == 1019) {
		spriteSelect(49);
		outputText("", true);
		shortName = "Blond D";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	if(eventNo == 1020) {
		spriteSelect(49);
		outputText("", true);
		shortName = "Brown D";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	if(eventNo == 1021) {
		spriteSelect(49);
		outputText("", true);
		shortName = "Red Dye";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	if(eventNo == 1023) {
		placeInStorage(1);
	}
	if(eventNo == 1024) {
		placeInStorage(2);
	}
	if(eventNo == 1025) {
		placeInStorage(3);
	}
	if(eventNo == 1026) {
		placeInStorage(4);
	}
	if(eventNo == 1027) {
		placeInStorage(5);
	}
	if(eventNo == 1028) {
		pickItemToStorage();
	}
	if(eventNo == 1029) {
		chooseRetrievalSlot();
	}
	if(eventNo == 1030) {
		retrieveFromStorage(0);
	}
	if(eventNo == 1031) {
		retrieveFromStorage(1);
	}
	if(eventNo == 1032) {
		retrieveFromStorage(2);
	}
	if(eventNo == 1033) {
		retrieveFromStorage(3);
	}
	if(eventNo == 1034) {
		retrieveFromStorage(4);
	}
	if(eventNo == 1035) {
		retrieveFromStorage(5);
	}
	if(eventNo == 1036) {
		retrieveFromStorage(6);
	}
	if(eventNo == 1037) {
		retrieveFromStorage(7);
	}

	//Gro+ Cancel
	if(eventNo == 1038) {
		if(debug) {
			outputText("You put the vial away.\n\n", true);
			if(inCombat()) enemyAI();
			else doNext(1000);
		}
		else {
			outputText("", true);
			shortName = "GroPlus";
			takeItem();
			itemSwapping = true;
			if(inCombat()) {
				outputText("\n\n", false);
				enemyAI();
			}
		}
	}
	//Gro+ Ballzzzz
	if(eventNo == 1039) {
		player.slimeFeed();
		outputText("You sink the needle deep into your " + sackDescript() + ".  It hurts like hell, but you push down the plunger and the pain vanishes as the needles contents flow into you.\n\n", true);
		//1 in 4 BIG growth.
		if(rand(4) == 0) {
			outputText("You feel a trembling in your " + ballsDescriptLight() + " as the chemicals start to go to work.  You can tell they're going to be VERY effective.\n", false);
			player.ballSize += 2 + rand(4);
			outputText("They shift, stretching your " + sackDescript() + " tight as they gain inches of size.  You step to steady yourself as your center of balance shifts due to your newly enlarged " + ballsDescriptLight() + ".  ", false);
		}
		else {
			player.ballSize += 1 + rand(2); 
			outputText("You feel your testicles shift, pulling the skin of your " + sackDescript() + " a little bit as they grow to " + ballsDescriptLight() + ".  ", false);
		}
		if(player.ballSize > 10) outputText("Walking gets even tougher with the swollen masses between your legs.  Maybe this was a bad idea.", false);
		dynStats("lus", 10);
		itemGoNext();
	}
	//Gro+ Breasts
	if(eventNo == 1040) {
		player.slimeFeed();
		outputText("You sink the needle into the flesh of your " + allBreastsDescript() + " injecting each with a portion of the needle.\n\n", true);
		if(player.breastRows.length == 1) growTits((1+rand(5)),1,true,1);
		else growTits(1+rand(2),player.breastRows.length,true,1);
		dynStats("lus", 10);
		itemGoNext();
	}
	//Clit
	if(eventNo == 1041) {
		player.slimeFeed();
		outputText("You sink the needle into your clit, nearly crying with how much it hurts.  You push down the plunger and the pain vanishes as your clit starts to grow.\n\n", true);
		player.clitLength++;
		outputText("Your " + clitDescript() + " stops growing after an inch of new flesh surges free of your netherlips.  It twitches, feeling incredibly sensitive.", false);
		dynStats("sen", 2, "lus", 10);
		itemGoNext();
	}
	//COCK!
	if(eventNo == 1042) {
		player.slimeFeed();
		outputText("You sink the needle into the base of your " + multiCockDescriptLight() + ".  It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n", true);
		if(player.cocks.length == 1) {
			outputText("Your " + cockDescript(0) + " twitches and thickens, pouring more than an inch of thick new length from your ", false);
			if(player.hasSheath()) outputText("sheath.", false);
			else outputText("crotch.", false);
			player.cocks[0].growCock(4);
			player.cocks[0].cockLength += 1;
			player.cocks[0].cockThickness += .5;
		}
		//MULTI
		else {
			outputText("Your " + multiCockDescriptLight() + " twitch and thicken, each member pouring out more than an inch of new length from your ", false);
			if(player.hasSheath()) outputText("sheath.", false);
			else outputText("crotch.", false);
			for(var i:Number =0;i<player.cocks.length;i++) {
				player.cocks[i].growCock(2);
				player.cocks[i].cockLength += 1;
				player.cocks[i].cockThickness += .5;
			}
		}
		dynStats("sen", 2, "lus", 10);
		itemGoNext();
	}
	//NURPLES
	if(eventNo == 1043) {
		player.slimeFeed();
		outputText("You sink the needle into each of your " + nippleDescript(0) + "s in turn, dividing the fluid evenly between them.  Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n", true);
		//Grow nipples
		outputText("Your nipples engorge, prodding hard against the inside of your " + player.armorName + ".  Abruptly you realize they've grown more than an additional quarter-inch.\n\n", false); 
		player.nippleLength += (rand(2) + 3)/10;
		dynStats("lus", 15);
		//NIPPLECUNTZZZ
		if(!player.hasFuckableNipples() && rand(4) == 0) {
			temp = player.breastRows.length;
			//Set nipplecunts on every row.
			while(temp > 0) {
				temp--;
				if(!player.breastRows[temp].fuckable && player.nippleLength >= 2) {
					player.breastRows[temp].fuckable = true;
					//Keep track of changes.
					temp2++;
				}
			}
			//Talk about if anything was changed.
			if(temp2 > 0) outputText("Your " + allBreastsDescript() + " tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>\n\n", false);
		}
		itemGoNext();
	}
	//White dye
	if(eventNo == 1044) {
		outputText("", true);
		shortName = "WhiteDy";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	/*EGG COLOR SHIFTING HAPPENS HERE
	EGG TYPES-
	0 - brown - ass expansion
	1 - purple - hip expansion
	2 - blue - vaginal removal and/or growth of existing maleness
	3 - pink - dick removal and/or fertility increase.
	4 - white - breast growth.  If lactating increases lactation.
	5 - rubbery black*/
	if(eventNo == 1045) {
		outputText("You reach out and touch the blue light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(2);
		doNext(13);
		return;
	}
	//PINK
	if(eventNo == 1046) {
		outputText("You reach out and touch the pink light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(3);
		doNext(13);
		return;
	}
	//BLACK
	if(eventNo == 1047) {
		outputText("You reach out and touch the black light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(5);
		doNext(13);
		return;
	}
	//PURPLE
	if(eventNo == 1048) {
		outputText("You reach out and touch the purple light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(1);
		doNext(13);
		return;
	}
	//BROWN
	if(eventNo == 1049) {
		outputText("You reach out and touch the brown light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(0);
		doNext(13);
		return;
	}
	//RUN FROM EGG-SHIFTER
	if(eventNo == 1050) {
		outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.", true);
		doNext(13);
		return;
	}
	//BROWN
	if(eventNo == 1051) {
		outputText("You reach out and touch the white light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(4);
		doNext(13);
		return;
	}
	//Leave rathazul
	if(eventNo == 1052) {
		outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n(<b>+50 Gems</b>)", true);
		player.gems += 50;
		statScreenRefresh();
		doNext(2070);
		return;
	}
	//Reducto+ Cancel
	if(eventNo == 1053) {
		clearOutput();
		if(debug) eventParser(1000);
		else {
			shortName = "Reducto";
			takeItem();
			itemSwapping = true;
		}
	}
	//Reducto Ballzzzz
	if(eventNo == 1054) {
		outputText("You smear the foul-smelling paste onto your " + sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n", true);
		player.ballSize -= (2 + rand(4)); 
		if(player.ballSize < 1) player.ballSize = 1;
		outputText("You feel your scrotum shift, shrinking down along with your " + ballsDescriptLight() + ".  ", false);
		outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.", false);
		dynStats("lib", -2, "lus", -10);
		itemGoNext();
	}
	//Reducto Breasts
	if(eventNo == 1055) {
		outputText("You smear the foul-smelling ointment all over your " + allBreastsDescript() + ", covering them entirely as the paste begins to get absorbed into your " + player.skinDesc + ".\n", true);
		shrinkTits();
		if(rand(2) == 0 && player.biggestTitSize() >= 1) {
			outputText("\nThe effects of the paste continue to manifest themselves, and your body begins to change again...", false);
			shrinkTits();
		}
		outputText("\nThe last of it wicks away into your skin, completing the changes.", false);
		dynStats("sen", -2, "lus", -5);
		itemGoNext();
	}
	//Clit
	if(eventNo == 1056) {
		outputText("You carefully apply the paste to your " + clitDescript() + ", being very careful to avoid getting it on your " + vaginaDescript(0) + ".  It burns with heat as it begins to make its effects known...\n\n", true);
		player.clitLength /= 1.7;
		//Set clitlength down to 2 digits in length
		player.clitLength = int(player.clitLength * 100)/100;
		outputText("Your " + clitDescript() + " shrinks rapidly, dwindling down to almost half its old size before it finishes absorbing the paste.", false);
		dynStats("sen", 2, "lus", 10);
		itemGoNext();
	}
	//COCK!
	if(eventNo == 1057) {
		outputText("You smear the repulsive smelling paste over your " + multiCockDescriptLight() + ".  It immediately begins to grow warm, almost uncomfortably so, as your " + multiCockDescriptLight() + " begins to shrink.\n\n", true);
		if(player.cocks.length == 1) {
			outputText("Your " + cockDescript(0) + " twitches as it shrinks, disappearing steadily into your ", false);
			if(player.hasSheath()) outputText("sheath", false);
			else outputText("crotch", false);
			outputText(" until it has lost about a third of its old size.", false);
			player.cocks[0].cockLength *= 2/3;
			player.cocks[0].cockThickness *= 2/3;
		}
		//MULTI
		else {
			outputText("Your " + multiCockDescriptLight() + " twitch and shrink, each member steadily disappearing into your ", false);
			if(player.hasSheath()) outputText("sheath", false);
			else outputText("crotch", false);
			outputText(" until they've lost about a third of their old size.", false);
			for(var ii:Number =0;ii<player.cocks.length;ii++) {
				player.cocks[ii].cockLength  *= 2/3;
				player.cocks[ii].cockThickness  *= 2/3;
			}
		}
		dynStats("sen", -2, "lus", -10);
		itemGoNext();
	}
	//Buy reducto
	if(eventNo == 1058) {
		spriteSelect(49);
		outputText("", true);
		if(player.gems >= 100 || (player.gems >= 50 && flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2)) {
			outputText("Rathazul hands you the Reducto with a nod before returning to his work.\n\n", false);
			if(flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2) player.gems -= 50;
			else player.gems -= 100;
			shortName = "Reducto";
			takeItem();
			statScreenRefresh();
			player.addStatusValue("metRathazul",2,1);
		}
		else {
			outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.", false);
			doNext(2070);
		}
		return;
	}
	//Lethicite for thorns offer
	if(eventNo == 1059) {
		spriteSelect(49);
		outputText("Rathazul asks, \"<i>Are you absolutely sure?  Growing this thorn canopy as a defense will use one third of the crystal's power.</i>\"\n\n(Do you have Rathazul use the crystal to grow a defensive canopy?)", true);
		doYesNo(1060,1061);
		return;
	}
	//Grow the defenses!
	if(eventNo == 1060) {
		spriteSelect(49);
		outputText("Rathazul nods and produces a mallet and chisel from his robes.  With surprisingly steady hands for one so old, he holds the chisel against the crystal and taps it, easily cracking off a large shard.  Rathazul gathers it into his hands before slamming it down into the dirt, until only the smallest tip of the crystal is visible.  He produces vials of various substances from his robe, as if by magic, and begins pouring them over the crystal.  In a few seconds, he finishes, and runs back towards his equipment.\n\n\"<i>You may want to take a step back,</i>\" he warns, but before you have a chance to do anything, a thick trunk covered in thorny vines erupts from the ground.  Thousands of vine-like branches split off the main trunk as it reaches thirty feet in the air, radiating away from the trunk and intertwining with their neighbors as they curve back towards the ground.  In the span of a few minutes, your camp gained a thorn tree and a thick mesh of barbed vines preventing access from above.", true);
		player.createStatusAffect("Defense: Canopy",0,0,0,0);
		player.addStatusValue("Marae's Lethicite",2,1);
		doNext(1);
		return;
	}
	//Refuse to use lethicite for thorns
	if(eventNo == 1061) {
		spriteSelect(49);
		outputText("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.", true);
		doNext(2070);
		return;
	}
	//NURPLES
	if(eventNo == 1062) {
		outputText("You rub the paste evenly over your " + nippleDescript(0) + "s, being sure to cover them completely.\n\n", true);
		//Shrink
		if(player.nippleLength/2 < .25) {
			outputText("Your nipples continue to shrink down until they stop at 1/4\" long.", false);
			player.nippleLength = .25;
		}
		else {
			outputText("Your " + nippleDescript(0) + "s get smaller and smaller, stopping when they are roughly half their previous size.", false);
			player.nippleLength /= 2;
		}
		dynStats("sen", -5, "lus", -5);
		itemGoNext();
		return;
	}
	//Slime bad end
	if(eventNo == 1063) {
		slimeBadEnd();
		return;
	}
	//Shop sell menu
	if(eventNo == 1064) {
		spriteSelect(47);
		hideUpDown();
		if(player.itemSlot1.quantity > 0 && itemValue(player.itemSlot1.shortName) > 0) temp1 = 1011;
		if(player.itemSlot2.quantity > 0 && itemValue(player.itemSlot2.shortName) > 0) temp2 = 1012;
		if(player.itemSlot3.quantity > 0 && itemValue(player.itemSlot3.shortName) > 0) temp3 = 1013;
		if(player.itemSlot4.unlocked && player.itemSlot4.quantity > 0 && itemValue(player.itemSlot4.shortName) > 0) temp4 = 1014;
		if(player.itemSlot5.unlocked && player.itemSlot5.quantity > 0 && itemValue(player.itemSlot5.shortName) > 0) temp5 = 1015;
		outputText("Oswald looks at you timidly as you rifle through your inventory, searching for something to sell.  He pipes up, \"<i>I can only afford to give you about 3 gems for each item.  Oh and there's no backsies, so you better not sell me the wrong thing by accident.</i>\"", true);
		temp = 0;
		//If3 no items
		if(temp1==0 && temp2==0 && temp3 == 0 && temp4==0 && temp5==0) {
			outputText("\n\nYou have no sellable items.", false);
			doNext(1065);
			return;
		}
		outputText("\n\nWhich item will you sell?", false);		
		if(gameState == 1) choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), temp1, (player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), temp2, (player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), temp3, (player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), temp4, (player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 5000);
		else choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), temp1, (player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), temp2, (player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), temp3, (player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), temp4, (player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 1);
	}
	//pawn shop main screen
	if(eventNo == 1065) {
		spriteSelect(47);
		outputText("\n\n<b><u>Oswald's Estimates</u></b>", false);
		if(player.itemSlot1.quantity > 0 && itemValue(player.itemSlot1.shortName) > 1) {
			outputText("\n" + int(itemValue(player.itemSlot1.shortName)/2) + " gems for " + itemLongName(player.itemSlot1.shortName) + ".", false);
			temp1 = 1066;
		}
		if(player.itemSlot2.quantity > 0 && itemValue(player.itemSlot2.shortName) > 1) {
			outputText("\n" + int(itemValue(player.itemSlot2.shortName)/2) + " gems for " + itemLongName(player.itemSlot2.shortName) + ".", false);
			temp2 = 1067;
		}
		if(player.itemSlot3.quantity > 0 && itemValue(player.itemSlot3.shortName) > 1) {
			outputText("\n" + int(itemValue(player.itemSlot3.shortName)/2) + " gems for " + itemLongName(player.itemSlot3.shortName) + ".", false);
			temp3 = 1068;
		}
		if(player.itemSlot4.quantity > 0 && itemValue(player.itemSlot4.shortName) > 1) {
			temp4 = 1069;
			outputText("\n" + int(itemValue(player.itemSlot4.shortName)/2) + " gems for " + itemLongName(player.itemSlot4.shortName) + ".", false);
		}
		if(player.itemSlot5.quantity > 0 && itemValue(player.itemSlot5.shortName) > 1) {
			temp5 = 1070;
			outputText("\n" + int(itemValue(player.itemSlot5.shortName)/2) + " gems for " + itemLongName(player.itemSlot5.shortName) + ".", false);
		}
		if(flags[kFLAGS.KATHERINE_UNLOCKED] == 1) 
			kath = telAdre.katherine.visitKatherine;

		choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), temp1,
				(player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), temp2,
				(player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), temp3,
				(player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), temp4,
				(player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), temp5,
				"Kath's Alley", kath, 
				"", 0, 
				"", 0, 
				"", 0, 
				"Back", telAdre.telAdreMenu);
	}
	
	//Sell item from slots
	if ((eventNo == 1066) || (eventNo == 1067) || (eventNo == 1068) || (eventNo == 1069) || (eventNo == 1070))
	//   slot 1               slot 2                slot 3               slot 4               slot 5
	{


		switch (eventNo)
		{
			case 1066:
				slotTmp = player.itemSlot1;
				break;
			case 1067:
				slotTmp = player.itemSlot2;
				break;
			case 1068:
				slotTmp = player.itemSlot3;
				break;
			case 1069:
				slotTmp = player.itemSlot4;
				break;
			case 1070:
				slotTmp = player.itemSlot5;
				break;
		}

		spriteSelect(47);
		var itemValueTemp:int = int(itemValue(slotTmp.shortName)/2);
		if(itemValueTemp == 0) 
			outputText("You hand over " + itemLongName(slotTmp.shortName) + " to Oswald.  He shrugs and says, \"<i>Well ok, it isn't worth anything, but I'll take it.</i>\"", true);
		else 
			outputText("You hand over " + itemLongName(slotTmp.shortName) + " to Oswald.  He nervously pulls out " + num2Text(itemValueTemp) + " gems and drops them into your waiting hand.", true);
		
		slotTmp.removeOneItem();

		doNext(telAdre.oswaldPawn);
		player.gems += itemValueTemp;
		statScreenRefresh();
		return;
	}


	//Reducto butt
	if(eventNo == 1071) {
		outputText("You smear the foul-smelling paste onto your " + buttDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n", true);
		if(player.buttRating >= 15) {
			player.buttRating -= (3 + int(player.buttRating/3));
			outputText("Within seconds you feel noticeably lighter, and a quick glance shows your ass is significantly smaller.", false);
		}
		else if(player.buttRating >= 10) {
			player.buttRating -= 3;
			outputText("You feel much lighter as your " + buttDescript() + " jiggles slightly, adjusting to its smaller size.", false);
		}
		else {
			player.buttRating -= 1 + rand(3);
			if(player.buttRating < 1) player.buttRating = 1;
			outputText("After a few seconds your " + buttDescript() + " has shrunk to a much smaller size!", false);
		}
		dynStats("lib", -2, "lus", -10);
		itemGoNext();
	}
	//Gray dye
	if(eventNo == 1084) {
		outputText("", true);
		shortName = "GrayDye";
		takeItem();
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	/* WEAPON RACK STORAGE */
	if(eventNo == 1085) {
		placeInRacks(1, false);
	}
	if(eventNo == 1086) {
		placeInRacks(2, false);
	}
	if(eventNo == 1087) {
		placeInRacks(3, false);
	}
	if(eventNo == 1088) {
		placeInRacks(4, false);
	}
	if(eventNo == 1089) {
		placeInRacks(5, false);
	}
	if(eventNo == 1090) {
		pickItemToRacks();
	}
	if(eventNo == 1091) {
		chooseRacksSlot();
	}
	if(eventNo == 1092) {
		retrieveFromRacks(0, false);
	}
	if(eventNo == 1093) {
		retrieveFromRacks(1, false);
	}
	if(eventNo == 1094) {
		retrieveFromRacks(2, false);
	}
	if(eventNo == 1095) {
		retrieveFromRacks(3, false);
	}
	if(eventNo == 1096) {
		retrieveFromRacks(4, false);
	}
	if(eventNo == 1097) {
		retrieveFromRacks(5, false);
	}
	if(eventNo == 1098) {
		retrieveFromRacks(6, false);
	}
	if(eventNo == 1099) {
		retrieveFromRacks(7, false);
	}
	if(eventNo == 1100) {
		retrieveFromRacks(8, false);
	}	
	/* Armor RACK STORAGE */
	if(eventNo == 1101) {
		placeInRacks(1, true);
	}
	if(eventNo == 1102) {
		placeInRacks(2, true);
	}
	if(eventNo == 1103) {
		placeInRacks(3, true);
	}
	if(eventNo == 1104) {
		placeInRacks(4, true);
	}
	if(eventNo == 1105) {
		placeInRacks(5, true);
	}
	if(eventNo == 1106) {
		pickItemToRacks(true);
	}
	if(eventNo == 1107) {
		chooseRacksSlot(true);
	}
	if(eventNo == 1108) {
		retrieveFromRacks(0, true);
	}
	if(eventNo == 1109) {
		retrieveFromRacks(1, true);
	}
	if(eventNo == 1110) {
		retrieveFromRacks(2, true);
	}
	if(eventNo == 1111) {
		retrieveFromRacks(3, true);
	}
	if(eventNo == 1112) {
		retrieveFromRacks(4, true);
	}
	if(eventNo == 1113) {
		retrieveFromRacks(5, true);
	}
	if(eventNo == 1114) {
		retrieveFromRacks(6, true);
	}
	if(eventNo == 1115) {
		retrieveFromRacks(7, true);
	}
	if(eventNo == 1116) {
		retrieveFromRacks(8, true);
	}	
	if(eventNo == 1122) {
		outputText("You smear the foul-smelling paste onto your [hips].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n", true);
		if(player.hipRating >= 15) {
			player.hipRating -= (3 + int(player.hipRating/3));
			outputText("Within seconds you feel noticeably lighter, and a quick glance at your hips shows they've gotten significantly narrower.", false);
		}
		else if(player.hipRating >= 10) {
			player.hipRating -= 3;
			outputText("You feel much lighter as your [hips] shift slightly, adjusting to their smaller size.", false);
		}
		else {
			player.hipRating -= 1 + rand(3);
			if(player.hipRating < 1) player.hipRating = 1;
			outputText("After a few seconds your [hips] have shrunk to a much smaller size!", false);
		}
		dynStats("lib", -2, "lus", -10);
		itemGoNext();
	}
}

//\"<i>Chicken Harpy</i>\" by Jay Gatsby and not Savin he didn't do ANYTHING
//Initial Intro
public function chickenHarpy():void {
	clearOutput();
	spriteSelect(90);
	if(flags[kFLAGS.TIMES_MET_CHICKEN_HARPY] == 0) {
		outputText("Taking a stroll along the mountains, you come across a peculiar-looking harpy wandering around with a large wooden cart in tow.  She's far shorter and bustier than any regular harpy you've seen before, reaching barely 4' in height but managing to retain some semblance of their thick feminine asses.  In addition to the fluffy white feathers decorating her body, the bird-woman sports about three more combed back upon her forehead like a quiff, vividly red in colour.");
		outputText("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be a chicken harpy!");
		outputText("\n\nAs you take a look inside of the cart you immediately spot a large hoard of eggs stacked clumsily in a pile.  The curious collection of eggs come in many colours and sizes, protected by a sheet of strong canvas to keep it all together.");
		outputText("\n\nThe chicken harpy - rather unnerved by the unflattering narration of her appearance you've accidentally shouted out loud - decides to break the ice by telling you about the cart currently holding your interest.");
		outputText("\n\n\"<i>Heya traveller, I noticed you were interested in my eggs here - they're not for sale, but perhaps we can come to some sort of agreement?</i>\"");
		outputText("\n\nYou put a hand to your chin and nod.  You are travelling, that's correct. The chicken harpy takes the gesture as a sign to continue.");
		outputText("\n\n\"<i>Well you see, these eggs don't really grow from trees - in fact, I've gotta chug down at least two or three ovi elixirs to get a good haul with my body, y'know?  Since it's tough for a lil' gal like me to find a few, I like to trade an egg over for some elixirs to those willing to part with them.</i>\"");
		outputText("\n\nSounds reasonable enough, you suppose.  Two or three elixirs for an egg? Doable for sure.");
		outputText("\n\n\"<i>So whaddya say, do y'have any elixirs you can fork over?</i>\"");
	}
	else {
		//Repeat Intro
		outputText("Taking a stroll along the mountains, you come across a familiar-looking shorty wandering around with a large wooden cart in tow.");
		outputText("\n\nHaving a long, hard think at the person you're currently making uncomfortable with your observational glare, you've come to a conclusion - she must be the chicken harpy!");
		outputText("\n\nYou run towards her as she waves a 'hello', stopping the cart to allow you to catch up.  Giving out her usual spiel about the eggs, she giggles and thrusts out a hand.");
		outputText("\n\n\"<i>Hey sunshine, do y'have any elixirs you can give me today?</i>\"");
		//[Give Two][Give Three]	[No, I Must Now Return To My People]
	}
	flags[kFLAGS.TIMES_MET_CHICKEN_HARPY]++;
	//[Give Two][Give Three]		[Not Really, No]
	menu();
	if(player.hasItem("OviElix",2)) addButton(0,"Give Two",giveTwoOviElix);
	if(player.hasItem("OviElix",3)) addButton(1,"Give Three",giveThreeOviElix);
	addButton(4,"Leave",leaveChickenx);
}

//If Give Two
public function giveTwoOviElix(player:Player):void {
	clearOutput();
	spriteSelect(90);
	consumeItem("OviElix",1);
	consumeItem("OviElix",1);
	outputText("You hand over two elixirs, the harpy more than happy to take them from you.  In return, she unties a corner of the sheet atop the cart, allowing you to take a look at her collection of eggs.");
	//[Black][Blue][Brown][Pink][Purple]
	menu();
	addButton(0,"Black",getHarpyEgg,0);
	addButton(1,"Blue",getHarpyEgg,1);
	addButton(2,"Brown",getHarpyEgg,2);
	addButton(3,"Pink",getHarpyEgg,3);
	addButton(4,"Purple",getHarpyEgg,4);
	addButton(5,"White",getHarpyEgg,10);
}

//If Give Three
public function giveThreeOviElix():void {
	clearOutput();
	spriteSelect(90);
	player.consumeItem("OviElix",3);
	outputText("You hand over three elixirs, the harpy ecstatic over the fact that you're willing to part with them.  In return, she unties a side of the sheet atop the cart, allowing you to take a look at a large collection of her eggs.");
	//[Black][Blue][Brown][Pink][Purple]
	menu();
	addButton(0,"Black",getHarpyEgg,5);
	addButton(1,"Blue",getHarpyEgg,6);
	addButton(2,"Brown",getHarpyEgg,7);
	addButton(3,"Pink",getHarpyEgg,8);
	addButton(4,"Purple",getHarpyEgg,9);
	addButton(5,"White",getHarpyEgg,11);
}

//All Text
public function getHarpyEgg(type:int = 0):void {
	clearOutput();
	spriteSelect(90);
	if(type == 0) shortName = "BlackEg";
	if(type == 5) shortName = "L.BlkEg";
	if(type == 1) shortName = "BlueEgg";
	if(type == 6) shortName = "L.BluEg";
	if(type == 2) shortName = "BrownEg";
	if(type == 7) shortName = "L.BrnEg";
	if(type == 3) shortName = "PinkEgg";
	if(type == 8) shortName = "L.PnkEg";
	if(type == 4) shortName = "PurplEg";
	if(type == 9) shortName = "L.PrpEg";
	if(type == 10) shortName = "WhiteEg";
	if(type == 11) shortName = "L.WhtEg";
	flags[kFLAGS.EGGS_BOUGHT]++;
	outputText("You take " + itemLongName(shortName) + ", and the harpy nods in regards to your decision.  Prepping her cart back up for the road, she gives you a final wave goodbye before heading back down through the mountains.\n\n");
	menuLoc = 27;
	takeItem();
}

//If No
public function leaveChickenx():void {
	clearOutput();
	spriteSelect(90);
	outputText("At the polite decline of her offer, the chicken harpy gives a warm smile before picking her cart back up and continuing along the path through the mountains.");
	outputText("\n\nYou decide to take your own path, heading back to camp while you can.");
	doNext(13);
}
