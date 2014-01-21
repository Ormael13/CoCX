/**
 * Created by aimozg on 12.01.14.
 */
package classes.Scenes
{
	import classes.BaseContent;
	import classes.CoC_Settings;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.ItemSlotClass;
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Items.Useable;
	import classes.Items.Weapon;

	use namespace kGAMECLASS;

	public class Inventory extends BaseContent
	{
		public function Inventory()
		{
		}
		private function get itemSlot1():ItemSlotClass{
			return player.itemSlot1;
		}
		private function get itemSlot2():ItemSlotClass{
			return player.itemSlot2;
		}
		private function get itemSlot3():ItemSlotClass{
			return player.itemSlot3;
		}
		private function get itemSlot4():ItemSlotClass{
			return player.itemSlot4;
		}
		private function get itemSlot5():ItemSlotClass{
			return player.itemSlot5;
		}
		private function itemSlot(idx:int):ItemSlotClass{
			return player.itemSlots[idx];
		}
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
			kGAMECLASS.mutations.kitsuneGiftResult();
			return;
		}
		if(itemSlot1.quantity > 0) temp1 = createCallBackFunction(useItemInInventory,itemSlot1);
		if(itemSlot2.quantity > 0) temp2 = createCallBackFunction(useItemInInventory,itemSlot2);
		if(itemSlot3.quantity > 0) temp3 = createCallBackFunction(useItemInInventory,itemSlot3);
		if(itemSlot4.quantity > 0 && itemSlot4.unlocked) temp4 = createCallBackFunction(useItemInInventory,itemSlot4);
		if(itemSlot5.quantity > 0 && itemSlot5.unlocked) temp5 = createCallBackFunction(useItemInInventory,itemSlot5);
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
				kGAMECLASS.emberScene.emberCampDesc();
				ember = kGAMECLASS.emberScene.emberEggInteraction;
			}
			if(kGAMECLASS.nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5) {
				if(flags[kFLAGS.NIEVE_STAGE] == 1) outputText("\nThere's some odd snow here that you could do something with...\n");
				else outputText("\nYou have a snow" + kGAMECLASS.nieveMF("man","woman") + " here that seems like it could use a little something...\n");
				nieve = 3964;
			}
			if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && inDungeon == 0) {
				fuckPlant = kGAMECLASS.holliScene.treeMenu;
				if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 3) plantT = "Tree";
				//Blurb in Items Screen
				if(flags[kFLAGS.FUCK_FLOWER_LEVEL] == 4) outputText("\nHolli is in her tree at the edges of your camp.  You could go visit her if you want.\n");
			}
		}
		//If3 no items
		if(temp1 == null && temp2 == null && temp3 == null && temp4 == null && temp5 == null && ember == null && fuckPlant == null && nieve == 0) {
			outputText("\nYou have no usable items.", false);
			doNext(1);
			return;
		}
		if(inCombat() && player.hasStatusAffect("Sealed") >= 0 && player.statusAffectv1("Sealed") == 3) {
			outputText("\nYou reach for your items, but you just can't get your pouches open.  <b>Your ability to use items was sealed, and now you've wasted a chance to attack!</b>\n\n");
			kGAMECLASS.enemyAI();
			return;
		}
		outputText("\nWhich item will you use?", false);		
		if(gameState == 1) choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), temp1, (itemSlot2.itype.shortName + " x" + itemSlot2.quantity), temp2, (itemSlot3.itype.shortName + " x" + itemSlot3.quantity), temp3, (itemSlot4.itype.shortName + " x" + itemSlot4.quantity), temp4, (itemSlot5.itype.shortName + " x" + itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 5000);
		else choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), temp1, (itemSlot2.itype.shortName + " x" + itemSlot2.quantity), temp2, (itemSlot3.itype.shortName + " x" + itemSlot3.quantity), temp3, (itemSlot4.itype.shortName + " x" + itemSlot4.quantity), temp4, (itemSlot5.itype.shortName + " x" + itemSlot5.quantity), temp5, "", 0, "Snow", nieve, plantT, fuckPlant, "Egg", ember, "Back", 1);
		menuLoc = 1;
	}
	//Auburn Dyes
	else if(eventNo == 1017) {
		spriteSelect(49);
		outputText("", true);
		inventory.takeItem(consumables.AUBURND);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	else if(eventNo == 1018) {
		spriteSelect(49);
		outputText("", true);
		inventory.takeItem(consumables.BROWN_D);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	else if(eventNo == 1019) {
		spriteSelect(49);
		outputText("", true);
		inventory.takeItem(consumables.BROWN_D);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	else if(eventNo == 1020) {
		spriteSelect(49);
		outputText("", true);
		inventory.takeItem(consumables.BROWN_D);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	else if(eventNo == 1021) {
		spriteSelect(49);
		outputText("", true);
		inventory.takeItem(consumables.RED_DYE);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	else if(eventNo == 1023) {
		placeInStorage(1);
	}
	else if(eventNo == 1024) {
		placeInStorage(2);
	}
	else if(eventNo == 1025) {
		placeInStorage(3);
	}
	else if(eventNo == 1026) {
		placeInStorage(4);
	}
	else if(eventNo == 1027) {
		placeInStorage(5);
	}
	else if(eventNo == 1028) {
		pickItemToStorage();
	}
	else if(eventNo == 1030) {
		retrieveFromStorage(0);
	}
	else if(eventNo == 1031) {
		retrieveFromStorage(1);
	}
	else if(eventNo == 1032) {
		retrieveFromStorage(2);
	}
	else if(eventNo == 1033) {
		retrieveFromStorage(3);
	}
	else if(eventNo == 1034) {
		retrieveFromStorage(4);
	}
	else if(eventNo == 1035) {
		retrieveFromStorage(5);
	}
	else if(eventNo == 1036) {
		retrieveFromStorage(6);
	}
	else if(eventNo == 1037) {
		retrieveFromStorage(7);
	}
	//Gro+ Cancel
	else if(eventNo == 1038) {
		if(debug) {
			outputText("You put the vial away.\n\n", true);
			if(inCombat()) enemyAI();
			else doNext(1000);
		}
		else {
			outputText("", true);
			inventory.takeItem(consumables.GROPLUS);
			itemSwapping = true;
			if(inCombat()) {
				outputText("\n\n", false);
				enemyAI();
			}
		}
	}
	//Gro+ Ballzzzz
	else if(eventNo == 1039) {
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
	else if(eventNo == 1040) {
		player.slimeFeed();
		outputText("You sink the needle into the flesh of your " + allBreastsDescript() + " injecting each with a portion of the needle.\n\n", true);
		if(player.breastRows.length == 1) player.growTits((1+rand(5)),1,true,1);
		else player.growTits(1+rand(2),player.breastRows.length,true,1);
		dynStats("lus", 10);
		itemGoNext();
	}
	//Clit
	else if(eventNo == 1041) {
		player.slimeFeed();
		outputText("You sink the needle into your clit, nearly crying with how much it hurts.  You push down the plunger and the pain vanishes as your clit starts to grow.\n\n", true);
		player.clitLength++;
		outputText("Your " + clitDescript() + " stops growing after an inch of new flesh surges free of your netherlips.  It twitches, feeling incredibly sensitive.", false);
		dynStats("sen", 2, "lus", 10);
		itemGoNext();
	}
	//COCK!
	else if(eventNo == 1042) {
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
	else if(eventNo == 1043) {
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
	else if(eventNo == 1044) {
		outputText("", true);
		inventory.takeItem(consumables.WHITEDY);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	/*EGG COLOR SHIFTING HAPPENS HERE
	EGG TYPES-
	0 - brown - ass expansion
	1 - purple - hip expansion
	2 - blue - vaginal removal and/or growth of existing maleness
	3 - pink - dick removal and/or fertility increase.
	4 - white - breast growth.  If lactating increases lactation.
	5 - rubbery black*/
	else if(eventNo == 1045) {
		outputText("You reach out and touch the blue light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(2);
		doNext(13);
	}
	//PINK
	else if(eventNo == 1046) {
		outputText("You reach out and touch the pink light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(3);
		doNext(13);
	}
	//BLACK
	else if(eventNo == 1047) {
		outputText("You reach out and touch the black light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(5);
		doNext(13);
	}
	//PURPLE
	else if(eventNo == 1048) {
		outputText("You reach out and touch the purple light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(1);
		doNext(13);
	}
	//BROWN
	else if(eventNo == 1049) {
		outputText("You reach out and touch the brown light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(0);
		doNext(13);
	}
	//RUN FROM EGG-SHIFTER
	else if(eventNo == 1050) {
		outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.", true);
		doNext(13);
	}
	//BROWN
	else if(eventNo == 1051) {
		outputText("You reach out and touch the white light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.", true);
		eggShifter(4);
		doNext(13);
	}
	//Leave rathazul
	else if(eventNo == 1052) {
		outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n(<b>+50 Gems</b>)", true);
		player.gems += 50;
		statScreenRefresh();
		doNext(2070);
	}
	//Reducto+ Cancel
	else if(eventNo == 1053) {
		clearOutput();
		if(debug) eventParser(1000);
		else {
			inventory.takeItem(consumables.REDUCTO);
			itemSwapping = true;
		}
	}
	//Reducto Ballzzzz
	else if(eventNo == 1054) {
		outputText("You smear the foul-smelling paste onto your " + sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n", true);
		player.ballSize -= (2 + rand(4)); 
		if(player.ballSize < 1) player.ballSize = 1;
		outputText("You feel your scrotum shift, shrinking down along with your " + ballsDescriptLight() + ".  ", false);
		outputText("Within a few seconds the paste has been totally absorbed and the shrinking stops.", false);
		dynStats("lib", -2, "lus", -10);
		itemGoNext();
	}
	//Reducto Breasts
	else if(eventNo == 1055) {
		outputText("You smear the foul-smelling ointment all over your " + allBreastsDescript() + ", covering them entirely as the paste begins to get absorbed into your " + player.skinDesc + ".\n", true);
		player.shrinkTits();
		if(rand(2) == 0 && player.biggestTitSize() >= 1) {
			outputText("\nThe effects of the paste continue to manifest themselves, and your body begins to change again...", false);
			player.shrinkTits();
		}
		outputText("\nThe last of it wicks away into your skin, completing the changes.", false);
		dynStats("sen", -2, "lus", -5);
		itemGoNext();
	}
	//Clit
	else if(eventNo == 1056) {
		outputText("You carefully apply the paste to your " + clitDescript() + ", being very careful to avoid getting it on your " + vaginaDescript(0) + ".  It burns with heat as it begins to make its effects known...\n\n", true);
		player.clitLength /= 1.7;
		//Set clitlength down to 2 digits in length
		player.clitLength = int(player.clitLength * 100)/100;
		outputText("Your " + clitDescript() + " shrinks rapidly, dwindling down to almost half its old size before it finishes absorbing the paste.", false);
		dynStats("sen", 2, "lus", 10);
		itemGoNext();
	}
	//COCK!
	else if(eventNo == 1057) {
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
	else if(eventNo == 1058) {
		spriteSelect(49);
		outputText("", true);
		if(player.gems >= 100 || (player.gems >= 50 && flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2)) {
			outputText("Rathazul hands you the Reducto with a nod before returning to his work.\n\n", false);
			if(flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2) player.gems -= 50;
			else player.gems -= 100;
			inventory.takeItem(consumables.REDUCTO);
			statScreenRefresh();
			player.addStatusValue("metRathazul",2,1);
		}
		else {
			outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.", false);
			doNext(2070);
		}
	}
	//Lethicite for thorns offer
	else if(eventNo == 1059) {
		spriteSelect(49);
		outputText("Rathazul asks, \"<i>Are you absolutely sure?  Growing this thorn canopy as a defense will use one third of the crystal's power.</i>\"\n\n(Do you have Rathazul use the crystal to grow a defensive canopy?)", true);
		doYesNo(1060,1061);
	}
	//Grow the defenses!
	else if(eventNo == 1060) {
		spriteSelect(49);
		outputText("Rathazul nods and produces a mallet and chisel from his robes.  With surprisingly steady hands for one so old, he holds the chisel against the crystal and taps it, easily cracking off a large shard.  Rathazul gathers it into his hands before slamming it down into the dirt, until only the smallest tip of the crystal is visible.  He produces vials of various substances from his robe, as if by magic, and begins pouring them over the crystal.  In a few seconds, he finishes, and runs back towards his equipment.\n\n\"<i>You may want to take a step back,</i>\" he warns, but before you have a chance to do anything, a thick trunk covered in thorny vines erupts from the ground.  Thousands of vine-like branches split off the main trunk as it reaches thirty feet in the air, radiating away from the trunk and intertwining with their neighbors as they curve back towards the ground.  In the span of a few minutes, your camp gained a thorn tree and a thick mesh of barbed vines preventing access from above.", true);
		player.createStatusAffect("Defense: Canopy",0,0,0,0);
		player.addStatusValue("Marae's Lethicite",2,1);
		doNext(1);
	}
	//Refuse to use lethicite for thorns
	else if(eventNo == 1061) {
		spriteSelect(49);
		outputText("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.", true);
		doNext(2070);
	}
	//NURPLES
	else if(eventNo == 1062) {
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
	}
	//Slime bad end
	else if(eventNo == 1063) {
		slimeBadEnd();
	}
	//pawn shop main screen
	else if(eventNo == 1065) {
		spriteSelect(47);
		outputText("\n\n<b><u>Oswald's Estimates</u></b>", false);
		if(itemSlot1.quantity > 0 && itemSlot1.itype.value > 1) {
			outputText("\n" + int(itemSlot1.itype.value/2) + " gems for " + itemSlot1.itype.longName + ".", false);
			temp1 = 1066;
		}
		if(itemSlot2.quantity > 0 && itemSlot2.itype.value > 1) {
			outputText("\n" + int(itemSlot2.itype.value/2) + " gems for " + itemSlot2.itype.longName + ".", false);
			temp2 = 1067;
		}
		if(itemSlot3.quantity > 0 && itemSlot3.itype.value > 1) {
			outputText("\n" + int(itemSlot3.itype.value/2) + " gems for " + itemSlot3.itype.longName + ".", false);
			temp3 = 1068;
		}
		if(itemSlot4.quantity > 0 && itemSlot4.itype.value > 1) {
			temp4 = 1069;
			outputText("\n" + int(itemSlot4.itype.value/2) + " gems for " + itemSlot4.itype.longName + ".", false);
		}
		if(itemSlot5.quantity > 0 && itemSlot5.itype.value > 1) {
			temp5 = 1070;
			outputText("\n" + int(itemSlot5.itype.value/2) + " gems for " + itemSlot5.itype.longName + ".", false);
		}
		if(flags[kFLAGS.KATHERINE_UNLOCKED] == 1) 
			kath = kGAMECLASS.telAdre.katherine.visitKatherine;

		choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), temp1,
				(itemSlot2.itype.shortName + " x" + itemSlot2.quantity), temp2,
				(itemSlot3.itype.shortName + " x" + itemSlot3.quantity), temp3,
				(itemSlot4.itype.shortName + " x" + itemSlot4.quantity), temp4,
				(itemSlot5.itype.shortName + " x" + itemSlot5.quantity), temp5,
				"Kath's Alley", kath, 
				"", 0, 
				"", 0, 
				"", 0, 
				"Back", kGAMECLASS.telAdre.telAdreMenu);
	}
	
	//Sell item from slots
	else if ((eventNo == 1066) || (eventNo == 1067) || (eventNo == 1068) || (eventNo == 1069) || (eventNo == 1070))
	//   slot 1               slot 2                slot 3               slot 4               slot 5
	{

		var slotTmp:ItemSlotClass;
		switch (eventNo)
		{
			case 1066:
				slotTmp = itemSlot1;
				break;
			case 1067:
				slotTmp = itemSlot2;
				break;
			case 1068:
				slotTmp = itemSlot3;
				break;
			case 1069:
				slotTmp = itemSlot4;
				break;
			case 1070:
				slotTmp = itemSlot5;
				break;
		}

		spriteSelect(47);
		var itemValueTemp:int = int(slotTmp.itype.value/2);
		if(itemValueTemp == 0) 
			outputText("You hand over " + slotTmp.itype.longName + " to Oswald.  He shrugs and says, \"<i>Well ok, it isn't worth anything, but I'll take it.</i>\"", true);
		else 
			outputText("You hand over " + slotTmp.itype.longName + " to Oswald.  He nervously pulls out " + num2Text(itemValueTemp) + " gems and drops them into your waiting hand.", true);
		
		slotTmp.removeOneItem();

		doNext(kGAMECLASS.telAdre.oswaldPawn);
		player.gems += itemValueTemp;
		statScreenRefresh();
	}
	//Reducto butt
	else if(eventNo == 1071) {
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
	else if(eventNo == 1084) {
		outputText("", true);
		inventory.takeItem(consumables.GRAYDYE);
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
	}
	/* WEAPON RACK STORAGE */
	else if(eventNo == 1085) {
		placeInRacks(1, false);
	}
	else if(eventNo == 1086) {
		placeInRacks(2, false);
	}
	else if(eventNo == 1087) {
		placeInRacks(3, false);
	}
	else if(eventNo == 1088) {
		placeInRacks(4, false);
	}
	else if(eventNo == 1089) {
		placeInRacks(5, false);
	}
	else if(eventNo == 1090) {
		pickItemToRacks();
	}
	else if(eventNo == 1092) {
		retrieveFromRacks(0, false);
	}
	else if(eventNo == 1093) {
		retrieveFromRacks(1, false);
	}
	else if(eventNo == 1094) {
		retrieveFromRacks(2, false);
	}
	else if(eventNo == 1095) {
		retrieveFromRacks(3, false);
	}
	else if(eventNo == 1096) {
		retrieveFromRacks(4, false);
	}
	else if(eventNo == 1097) {
		retrieveFromRacks(5, false);
	}
	else if(eventNo == 1098) {
		retrieveFromRacks(6, false);
	}
	else if(eventNo == 1099) {
		retrieveFromRacks(7, false);
	}
	else if(eventNo == 1100) {
		retrieveFromRacks(8, false);
	}	
	/* Armor RACK STORAGE */
	else if(eventNo == 1101) {
		placeInRacks(1, true);
	}
	else if(eventNo == 1102) {
		placeInRacks(2, true);
	}
	else if(eventNo == 1103) {
		placeInRacks(3, true);
	}
	else if(eventNo == 1104) {
		placeInRacks(4, true);
	}
	else if(eventNo == 1105) {
		placeInRacks(5, true);
	}
	else if(eventNo == 1106) {
		pickItemToRacks(true);
	}
	else if(eventNo == 1107) {
		chooseRacksSlot(true);
	}
	else if(eventNo == 1108) {
		retrieveFromRacks(0, true);
	}
	else if(eventNo == 1109) {
		retrieveFromRacks(1, true);
	}
	else if(eventNo == 1110) {
		retrieveFromRacks(2, true);
	}
	else if(eventNo == 1111) {
		retrieveFromRacks(3, true);
	}
	else if(eventNo == 1112) {
		retrieveFromRacks(4, true);
	}
	else if(eventNo == 1113) {
		retrieveFromRacks(5, true);
	}
	else if(eventNo == 1114) {
		retrieveFromRacks(6, true);
	}
	else if(eventNo == 1115) {
		retrieveFromRacks(7, true);
	}
	else if(eventNo == 1116) {
		retrieveFromRacks(8, true);
	}	
	else if(eventNo == 1122) {
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

		private function useItem(itype:ItemType,external:Boolean):void
		{
			(itype as Useable).useItem(player,true,external);
			if (!itemSwapping && !itemSubMenu) itemGoNext();
			itemSwapping = false;
		}

		private function useItemInInventory(slotTmp:ItemSlotClass):void
		{
			if (slotTmp.itype is Useable) {
				(slotTmp.itype as Useable).useItem(player,true,false);
			} else {
				outputText("You cannot use " + slotTmp.itype.longName + "!\n\n", true);
			}
			if (!itemSubMenu && !itemSwapping) {
				if (!inCombat())
					doNext(1000);
				else if (menuLoc == 1) {
					menuLoc = 0;
					if (!combatRoundOver()) {
						outputText("\n\n");
						enemyAI();
					}
				}
			}
		}
		//Determine how to continue after using items or running from the items menu.
		public function itemGoNext():void {
			itemSubMenu = false;//hope it will work
			trace("ITEM GO NEXT HAPPENZ BITCHES" + String(itemSwapping));
			if(gameState == 4) {
				//If at giacomo go back to him afterwards
				doNext(2015);
				return;
			}
			if(gameState == 6) {
				//If at alchemist go back to him afterwards
				doNext(2070);
				return;
			}
			if(menuLoc == 7) {
				//Go back to item storage screen if there
				doNext(chooseRetrievalSlot);
				return;
			}
			if(gameState == 8) {
				//If finding a pepper at the farm, pass 2 hours
				doNext(14);
				return;
			}
			if(menuLoc == 10) {
				//Tailor shop
				doNext(kGAMECLASS.telAdre.tailorShoppe);
				return;
			}
			if(menuLoc == 9) {
				//Armor shop
				doNext(kGAMECLASS.telAdre.armorShop);
				return;
			}
			if(menuLoc == 11) {
				doNext(41);
				return;
			}
			if(menuLoc == 12) {
				//Lumi's potion shop
				doNext(kGAMECLASS.lumi.lumiShop);
				return;
			}
			if(menuLoc == 13) {
				//Lumi's enhancement shop
				doNext(kGAMECLASS.lumi.lumiEnhance);
				return;
			}
			if(menuLoc == 14) {
				//Late night looting
				doNext(1);
				return;
			}
			if(menuLoc == 15) {
				//Weapon shop
				doNext(kGAMECLASS.telAdre.weaponShop);
				return;
			}
			if(menuLoc == 16) {
				doNext(2642);
				return;
			}
			if(menuLoc == 17) {
				doNext(15);
				return;
			}
			if(menuLoc == 18) {
				doNext(16);
				return;
			}
			if(menuLoc == 19) {
				doNext(kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu);
				return;
			}
			if(menuLoc == 20) {
				doNext(1090);
				return;
			}
			if(menuLoc == 21) {
				doNext(chooseRacksSlot);
				return;
			}
			if(menuLoc == 22) {
				doNext(1106);
				return;
			}
			if(menuLoc == 23) {
				doNext(1107);
				return;
			}
			if(menuLoc == 24) {
				doNext(kGAMECLASS.telAdre.barTelAdre);
				return;
			}
			if(menuLoc == 25) {
				doNext(kGAMECLASS.owca.owcaTavern);
				return;
			}
			if(menuLoc == 26) {
				doNext(kGAMECLASS.bazaar.benoit.benoitsBuyMenu);
				return;
			}
			if(menuLoc == 27) {
				doNext(kGAMECLASS.highMountains.chickenHarpy);
				return;
			}
			if(menuLoc == 28) {
				doNext(1000);
				return;
			}
			if(menuLoc == 29) {
				doNext(kGAMECLASS.telAdre.bakeryScene.ingredientsMenu);
				return;
			}
			if(menuLoc == 2) doNext(13);
			else doNext(1);
		}

		public function takeItem(itype:ItemType):Boolean{
			itemSubMenu = false;
			if (itype == null){
				CoC_Settings.error("takeItem(null)");
				return true;
			}
			if (itype == ItemType.NOTHING) return true;
			var done:Boolean = false;
			//Check for an existing stack with room in the inventory and return the value for it.
			var temp:int = player.roomInExistingStack(itype);
			if(temp >= 0) {
				//First slot go!
				itemSlot(temp).quantity++;
				outputText("You place " + itype.longName + " in your "+
						["first","second","third","fourth","fifth"][temp]+
						" pouch, giving you " + itemSlot(temp).quantity + " of them.", false);
				done = true;
			}
			//If not done, then put it in an empty spot!
			//Throw in slot 1 if there is room
			if(!done) {
				temp = player.emptySlot();
				if (temp >= 0){
					itemSlot(temp).setItemAndQty(itype, 1);
					outputText("You place " + itype.longName + " in your "+
							["first","second","third","fourth","fifth"][temp]+
							" pouch.", false);
					done = true;
				}
			}
			if(done) {
				itemGoNext();
				return true;
			}
			//OH NOES! No room! Call replacer functions!
			outputText("There is no room for " + itype.longName + " in your inventory.  You may replace the contents of a pouch with " + itype.longName + " or abandon it.", false);
			var slot4:Function = null;
			var slot5:Function = null;
			if(itemSlot4.unlocked) slot4 = createCallBackFunction2(replaceItem,itype,itemSlot4);
			if(itemSlot5.unlocked) slot5 = createCallBackFunction2(replaceItem,itype,itemSlot5);
			var abandon:* = 13;
			//If at giacomo abandon goes differently...
			if (gameState == 4)
			{
				abandon = 2015;
			}
			else if (gameState == 6)
			{
				abandon = 2070;
			}
			else if (menuLoc == 7)
			{
				abandon = chooseRetrievalSlot;
			}
			//Tailor
			else if (menuLoc == 10)
			{
				abandon = getGame().telAdre.tailorShoppe;
			}
			//Armor
			else if (menuLoc == 9)
			{
				abandon =  kGAMECLASS.telAdre.armorShop;
			}
			else if (menuLoc == 11)
			{
				abandon = 41;
			}
			else if (menuLoc == 12 || menuLoc == 13)
			{
				abandon = kGAMECLASS.lumi.lumiLabChoices;
			}
			else if (menuLoc == 14)
			{
				abandon =  1;
			}
			else if (menuLoc == 15)
			{
				abandon = kGAMECLASS.telAdre.weaponShop;
			}
			else if (menuLoc == 16)
			{
				abandon =  2642;
			}
			else if (menuLoc == 17)
			{
				abandon = 15;
			}
			else if (menuLoc == 18)
			{
				abandon = 16;
			}
			else if (menuLoc == 19)
			{
				abandon =  kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu;
			}
			else if (menuLoc == 20)
			{
				abandon = 1090;
			}
			else if (menuLoc == 21)
			{
				abandon = chooseRacksSlot;
			}
			else if (menuLoc == 22)
			{
				abandon = 1106;
			}
			else if (menuLoc == 23)
			{
				abandon = 1107;
			}
			else if (menuLoc == 24)
			{
				abandon = kGAMECLASS.telAdre.barTelAdre;
			}
			else if (menuLoc == 25)
			{
				abandon = kGAMECLASS.owca.owcaTavern;
			}
			else if (menuLoc == 26)
			{
				abandon = kGAMECLASS.bazaar.benoit.benoitsBuyMenu;
			}
			else if (menuLoc == 27)
			{
				abandon = 3968;
			}
			else if (menuLoc == 28)
			{
				abandon = 1000;
			}
			else if (menuLoc == 29)
			{
				abandon = kGAMECLASS.telAdre.bakeryScene.ingredientsMenu;
			}
			choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), createCallBackFunction2(replaceItem,itype,itemSlot1),
					(itemSlot2.itype.shortName + " x" + itemSlot2.quantity), createCallBackFunction2(replaceItem,itype,itemSlot2),
					(itemSlot3.itype.shortName + " x" + itemSlot3.quantity), createCallBackFunction2(replaceItem,itype,itemSlot3),
					(itemSlot4.itype.shortName + " x" + itemSlot4.quantity), slot4,
					(itemSlot5.itype.shortName + " x" + itemSlot5.quantity), slot5,
					"", 0,
					"", 0,
					"", 0,
					"Use Now", curry(useItem,itype,true),
					"Abandon", abandon);
			trace("TakeItem Menuloc: " + menuLoc);
			return false;
		}
		private function replaceItem(itype:ItemType,slotTmp:ItemSlotClass):void{
			//If it is the same as what's in the slot...just throw away the new item
			if(slotTmp.itype == itype) outputText("You discard " + itype.longName + " from the stack to make room for the new one.", true);
			//If they are different...
			else {
				if(slotTmp.quantity == 1) outputText("You throw away " + slotTmp.itype.longName + " and replace it with " + itype.longName + ".", true);
				else outputText("You throw away " + slotTmp.itype.longName + "(x" + slotTmp.quantity + ") and replace it with " + itype.longName + ".", true);
				slotTmp.setItemAndQty(itype,1);
			}
			itemGoNext();
		}
		//Store - let you select an item slot, then a storage slot.
		public function pickItemToStorage():void {
			var temp1:Number = 0;
			var temp2:Number;
			var temp3:Number = 0;
			var temp4:Number = 0;
			var temp5:Number = 0;
			//Reset temp2;
			temp2 = 0;
			hideUpDown();
			if(itemSlot1.quantity > 0) temp1 = 1023;
			if(itemSlot2.quantity > 0) temp2 = 1024;
			if(itemSlot3.quantity > 0) temp3 = 1025;
			if(itemSlot4.unlocked && itemSlot4.quantity > 0) temp4 = 1026;
			if(itemSlot5.unlocked && itemSlot5.quantity > 0) temp5 = 1027;
			outputText("What item slot do you wish to empty into your storage containers?", true);
			choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), temp1, (itemSlot2.itype.shortName + " x" + itemSlot2.quantity), temp2, (itemSlot3.itype.shortName + " x" + itemSlot3.quantity), temp3, (itemSlot4.itype.shortName + " x" + itemSlot4.quantity), temp4, (itemSlot5.itype.shortName + " x" + itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 2951);
			menuLoc = 7;
		}
		//Retrieval List - lets you select the correct slot
		public function chooseRetrievalSlot():void {
			if(!hasItemsInStorage()) {
				eventParser(1);
				return;
			}
			var temp2:Number = 0;
			var temp1:Number = 0;
			var temp3:Number = 0;
			var temp4:Number = 0;
			var temp5:Number = 0;
			var temp6:Number = 0;
			var temp7:Number = 0;
			var temp8:Number = 0;
			var slotDescs:Array = ["","","","","","","","","","","","","","","",""];
			temp = itemStorage.length;
			while(temp > 0) {
				temp--;
				if(itemStorage[temp].quantity > 0) {
					if(temp == 0) temp1 = 1030;
					if(temp == 1) temp2 = 1031;
					if(temp == 2) temp3 = 1032;
					if(temp == 3) temp4 = 1033;
					if(temp == 4) temp5 = 1034;
					if(temp == 5) temp6 = 1035;
					if(temp == 6) temp7 = 1036;
					if(temp == 7) temp8 = 1037;
					slotDescs[temp] = (itemStorage[temp].itype.shortName + " x" + itemStorage[temp].quantity);
				}
			}
			hideUpDown();
			outputText("What storage slot do you wish to take an item from?", true);
			choices(slotDescs[0], temp1, slotDescs[1], temp2, slotDescs[2], temp3, slotDescs[3], temp4, "", 0, slotDescs[4], temp5, slotDescs[5], temp6, slotDescs[6], temp7, slotDescs[7], temp8, "Back", 2951);
			menuLoc = 7;
		}
		//Grab an item from the selected slot.
		public function retrieveFromStorage(slotNum:Number):void {
			if(itemStorage[slotNum].quantity == 0) {
				outputText("That slot is empty.", true);
				return;
			}
			var itype:ItemType = itemStorage[slotNum].itype;
			itemStorage[slotNum].quantity--;
			outputText("", true);
			menuLoc = 7;
			if (inventory.takeItem(itype)){
				doNext(chooseRetrievalSlot);
			}
		}
		//Check to see if anything is stored
		public function hasItemsInStorage():Boolean {
			temp = itemStorage.length;
			while(temp > 0) {
				temp--;
				if(itemStorage[temp].quantity > 0) return true;
			}
			return false;
		}
		public function hasItemInStorage(itype:ItemType):Boolean {
			temp = itemStorage.length;
			while(temp > 0) {
				temp--;
				if(itemStorage[temp].itype == itype && itemStorage[temp].quantity > 0) return true;
			}
			return false;
		}
		public function consumeItemInStorage(itype:ItemType):Boolean {
			temp = itemStorage.length;
			while(temp > 0) {
				temp--;
				if(itemStorage[temp].itype == itype && itemStorage[temp].quantity > 0) {
					itemStorage[temp].quantity--;
					return true;
				}
			}
			return false;
		}
		//Place item slot into the first dump spot.
		public function placeInStorage(slotNum:Number):void {
			outputText("", true);
			var itype:ItemType = null;
			var qty:Number = 0;
			var currentStorageSlotIndex:Number;
			//Load the item stats from the slot that's being emptied, and empty the slot.
			if(slotNum == 1)
			{
				qty = itemSlot1.quantity;
				itype = itemSlot1.itype;
				itemSlot1.emptySlot();
			}
			else if(slotNum == 2)
			{
				qty = itemSlot2.quantity;
				itype = itemSlot2.itype;
				itemSlot2.emptySlot();
			}
			else if(slotNum == 3)
			{
				qty = itemSlot3.quantity;
				itype = itemSlot3.itype;
				itemSlot3.emptySlot();
			}
			else if(slotNum == 4)
			{
				qty = itemSlot4.quantity;
				itype = itemSlot4.itype;
				itemSlot4.emptySlot();
			}
			else if(slotNum == 5)
			{
				qty = itemSlot5.quantity;
				itype = itemSlot5.itype;
				itemSlot5.emptySlot();
			}
			//Place in the first free slot
			currentStorageSlotIndex = 0;
			var storedItems:Number = 0;

			//Check for slots with free space for the item.  If so fill them and move on
			//until out of items to place
			while(currentStorageSlotIndex < itemStorage.length && qty > 0)
			{
				//If there is a slot with the item and room
				if(itemStorage[currentStorageSlotIndex].itype == itype && itemStorage[currentStorageSlotIndex].quantity < 5)
				{
					//storedItems is used for counting items placed in a slot.
					storedItems = 0;
					//Place items in 1 at a time until out of room or items
					while(itemStorage[currentStorageSlotIndex].quantity < 5 && qty > 0)
					{
						qty--;
						itemStorage[currentStorageSlotIndex].quantity++;
						storedItems++;
					}
					if(storedItems > 0) outputText("You add " + storedItems + "x " + itype.shortName + " into storage slot number " + num2Text(currentStorageSlotIndex+1) + ".\n", false);
				}
				currentStorageSlotIndex++;
			}
			//Talk about items if they're all gone.
			currentStorageSlotIndex = 0;
			//check if a suitable slot is found.  If so, load in, and quit out.
			while(currentStorageSlotIndex < itemStorage.length && qty > 0)
			{
				if(itemStorage[currentStorageSlotIndex].isEmpty())
				{
					itemStorage[currentStorageSlotIndex].setItemAndQty(itype,qty);
					outputText("You place " + qty + "x " + itype.shortName + " into storage slot " + num2Text(currentStorageSlotIndex+1) + ".\n", false);
					currentStorageSlotIndex = 17;
					qty = 0;
				}
				currentStorageSlotIndex++;
			}
			if(qty > 0)
			{
				outputText("There is no room for the remaining " + qty + "x " + itype.shortName + ".  You leave it in your inventory.\n", false);
				//Put remaining back in slot.
				if(slotNum == 1) {
					itemSlot1.setItemAndQty(itype, qty);
				}
				if(slotNum == 2) {
					itemSlot2.setItemAndQty(itype, qty);
				}
				if(slotNum == 3) {
					itemSlot3.setItemAndQty(itype, qty);
				}
				if(slotNum == 4) {
					itemSlot4.setItemAndQty(itype, qty);
				}
				if(slotNum == 5) {
					itemSlot5.setItemAndQty(itype, qty);
				}
			}
			doNext(1028);
		}

		//Place item slot into the first dump spot.
		public function placeInRacks(slotNum:Number, armor:Boolean = false):void {
			outputText("", true);
			var itype:ItemType = null;
			var qty:Number = 0;
			var temp2:Number = 0;
			//Load the item stats from the slot that's being emptied, and empty the slot.
			if(slotNum == 1) {
				qty = itemSlot1.quantity;
				itype = itemSlot1.itype;
				itemSlot1.emptySlot()
			}
			if(slotNum == 2) {
				qty = itemSlot2.quantity;
				itype = itemSlot2.itype;
				itemSlot2.emptySlot()
			}
			if(slotNum == 3) {
				qty = itemSlot3.quantity;
				itype = itemSlot3.itype;
				itemSlot3.emptySlot()
			}
			if(slotNum == 4) {
				qty = itemSlot4.quantity;
				itype = itemSlot4.itype;
				itemSlot4.emptySlot()
			}
			if(slotNum == 5) {
				qty = itemSlot5.quantity;
				itype = itemSlot5.itype;
				itemSlot5.emptySlot()
			}
			//Place in the first free slot
			temp = 0;
			var goal:Number = 9;
			if(armor) {
				temp = 9;
				goal = 18;
			}
			//Check for slots with free space for the item.  If so fill them and move on
			//until out of items to place
			while(temp < goal && qty > 0) {
				//If there is a slot with the item and room
				if(gearStorage[temp].itype == itype && gearStorage[temp].quantity < 5) {
					//temp2 is used for counting items placed in a slot.
					temp2 = 0;
					//Place items in 1 at a time until out of room or items
					while(gearStorage[temp].quantity < 5 && qty > 0) {
						qty--;
						gearStorage[temp].quantity++;
						temp2++;
					}
					if(temp2 > 0) outputText("You add " + temp2 + "x " + itype.shortName + " into storage slot number ", false);
					if(!armor) outputText(num2Text(temp+1) + ".\n", false);
					else outputText(num2Text(temp - 8) + ".\n", false);
				}
				temp++;
			}
			//Talk about items if they're all gone.
			temp = 0;
			goal = 9;
			if(armor) {
				temp = 9;
				goal = 18;
			}
			//check if a suitable slot is found.  If so, load in, and quit out.
			while(temp < goal && qty > 0) {
				if(gearStorage[temp].quantity == 0) {
					(gearStorage[temp] as ItemSlotClass).setItemAndQty(itype,qty);
					outputText("You place " + qty + "x " + itype.shortName + " into storage slot ", false);
					if(!armor) outputText(num2Text(temp+1) + ".\n", false);
					else outputText(num2Text(temp - 8) + ".\n", false);
					temp = 25;
					qty = 0;
				}
				temp++;
			}
			if(qty > 0) {
				outputText("There is no room for the remaining " + qty + "x " + itype.shortName + ".  You leave it in your inventory.\n", false);
				//Put remaining back in slot.
				if(slotNum == 1) {
					itemSlot1.setItemAndQty(itype, qty);
				}
				if(slotNum == 2) {
					itemSlot2.setItemAndQty(itype, qty);
				}
				if(slotNum == 3) {
					itemSlot3.setItemAndQty(itype, qty);
				}
				if(slotNum == 4) {
					itemSlot4.setItemAndQty(itype, qty);
				}
				if(slotNum == 5) {
					itemSlot5.setItemAndQty(itype, qty);
				}
			}
			if(!armor) doNext(1090);//1028);
			else doNext(1106);
		}

		//Check to see if anything is stored in racks
		public function hasItemsInRacks(armor:Boolean = false):Boolean {
			var goal:Number = 0;
			if(armor) goal = 9;
			temp = gearStorage.length;
			if(!armor) temp = 9;
			while(temp > goal) {
				temp--;
				if(gearStorage[temp].quantity > 0) return true;
			}
			return false;
		}
		//Grab an item from the selected weapon slot.
		public function retrieveFromRacks(slotNum:Number,armor:Boolean = false):void {
			if(armor) slotNum += 9;
			if(gearStorage[slotNum].quantity == 0) {
				outputText("That slot is empty.", true);
				return;
			}
			var itype:ItemType = gearStorage[slotNum].itype;
			gearStorage[slotNum].quantity--;
			outputText("", true);
			if(!armor) {
				doNext(chooseRacksSlot);
				menuLoc = 21;
			}
			else {
				doNext(1107);
				menuLoc = 23;
			}
			inventory.takeItem(itype);
		}

		//Retrieval List - lets you select the correct gear slot
		public function chooseRacksSlot(armor:Boolean = false):void {
			/*if(!hasItemsInGearStorage()) {
				eventParser(1);
				return;
			}*/
			var temp2:Number = 0;
			var temp1:Number = 0;
			var temp3:Number = 0;
			var temp4:Number = 0;
			var temp5:Number = 0;
			var temp6:Number = 0;
			var temp7:Number = 0;
			var temp8:Number = 0;
			var temp9:Number = 0;
			var slotDescs:Array = ["","","","","","","","","","","","","","","",""];
			//Set goals
			var goal:Number = 0;
			if(armor) goal = 9;
			//This modifies the event numbers for armor rack.
			var bonus:Number = 0;
			if(armor) bonus = 16;
			//Set loop starting place
			if(armor) temp = 18;
			else temp = 9;
			while(temp > goal) {
				temp--;
				trace("TEMP: " + temp);
				if(gearStorage[temp].quantity > 0) {
					if(temp == 0 || temp == 9) temp1 = 1092 + bonus;
					if(temp == 1 || temp == 10) temp2 = 1093 + bonus;//1031;
					if(temp == 2 || temp == 11) temp3 = 1094 + bonus;
					if(temp == 3 || temp == 12) temp4 = 1095 + bonus;
					if(temp == 4 || temp == 13) temp5 = 1096 + bonus;
					if(temp == 5 || temp == 14) temp6 = 1097 + bonus;
					if(temp == 6 || temp == 15) temp7 = 1098 + bonus;
					if(temp == 7 || temp == 16) temp8 = 1099 + bonus;
					if(temp == 8 || temp == 17) temp9 = 1100 + bonus;
					if(!armor) slotDescs[temp] = (gearStorage[temp].itype.shortName + " x" + gearStorage[temp].quantity);
					else slotDescs[(temp-9)] = (gearStorage[temp].itype.shortName + " x" + gearStorage[temp].quantity);
				}
			}
			hideUpDown();
			outputText("What rack slot do you wish to take an item from?", true);
			if(temp1 + temp2 + temp3 + temp4 + temp5 + temp6 + temp7 + temp8 == 0) {
				outputText("\n<b>You have no items stored in this ", false);
				if(!armor) outputText("weapon ", false);
				else outputText("armor ", false);
				outputText("rack.</b>", false);
			}
			choices(slotDescs[0], temp1, slotDescs[1], temp2, slotDescs[2], temp3, slotDescs[3], temp4, slotDescs[4], temp5, slotDescs[5], temp6, slotDescs[6], temp7, slotDescs[7], temp8, slotDescs[8], temp9, "Back", 2951);
			if(!armor) menuLoc = 21;
			else menuLoc = 23;
		}
		//Store - let you select an item slot, then a weapon slot.
		public function pickItemToRacks(armor:Boolean = false):void {
			var temp2:Number = 0;
			var temp1:Number = 0;
			var temp3:Number = 0;
			var temp4:Number = 0;
			var temp5:Number = 0;
			var bonus:Number = 0;
			if(armor) bonus = 16;
			hideUpDown();
			if(!armor) {
				if(itemSlot1.quantity > 0 && itemSlot1.itype is Weapon) temp1 = 1085 + bonus;
				if(itemSlot2.quantity > 0 && itemSlot2.itype is Weapon) temp2 = 1086 + bonus;
				if(itemSlot3.quantity > 0 && itemSlot3.itype is Weapon) temp3 = 1087 + bonus;
				if(itemSlot4.quantity > 0 && itemSlot4.itype is Weapon && itemSlot4.unlocked) temp4 = 1088 + bonus;
				if(itemSlot5.quantity > 0 && itemSlot5.itype is Weapon && itemSlot5.unlocked) temp5 = 1089 + bonus;
			}
			else {
				if(itemSlot1.quantity > 0 && itemSlot1.itype is Armor) temp1 = 1085 + bonus;
				if(itemSlot2.quantity > 0 && itemSlot2.itype is Armor) temp2 = 1086 + bonus;
				if(itemSlot3.quantity > 0 && itemSlot3.itype is Armor) temp3 = 1087 + bonus;
				if(itemSlot4.quantity > 0 && itemSlot4.itype is Armor && itemSlot4.unlocked) temp4 = 1088 + bonus;
				if(itemSlot5.quantity > 0 && itemSlot5.itype is Armor && itemSlot5.unlocked) temp5 = 1089 + bonus;
			}
			outputText("What item slot do you wish to empty into your ", true);
			if(!armor) outputText("weapon rack", false);
			else outputText("armor rack", false);
			outputText("?", false);
			if(temp1 + temp2 + temp3 + temp4 + temp5 == 0) outputText("\n<b>You have no appropriate items to put in this rack.</b>", false);
			choices((itemSlot1.itype.shortName + " x" + itemSlot1.quantity), temp1, (itemSlot2.itype.shortName + " x" + itemSlot2.quantity), temp2, (itemSlot3.itype.shortName + " x" + itemSlot3.quantity), temp3, (itemSlot4.itype.shortName + " x" + itemSlot4.quantity), temp4, (itemSlot5.itype.shortName + " x" + itemSlot5.quantity), temp5, "", 0, "", 0, "", 0, "", 0, "Back", 2951);
			if(!armor) menuLoc = 20;
			else menuLoc = 22;
		}

		/*
		 v1 = egg type.
		 v2 = size - 0 for normal, 1 for large
		 v3 = quantity
		 EGG TYPES-
		 0 - brown - ass expansion
		 1 - purple - hip expansion
		 2 - blue - vaginal removal and/or growth of existing maleness
		 3 - pink - dick removal and/or fertility increase.
		 4 - white - breast growth.  If lactating increases lactation.
		 5 - rubbery black*/
		private function eggShifter(eggCode:Number):void
		{
			if (player.hasStatusAffect("eggs") >= 0) player.statusAffects[player.hasStatusAffect("eggs")].value1 = eggCode;
		}
		private function slimeBadEnd():void {
			outputText("One year later...", true);
			outputText("\n\nThe new champion has managed to escape imprisonment in the demons' sick plots, but the monsters and trials of this land have taken their toll on him.  He undresses and slips into the water, hesitant around his newly enlarged member, but once he slips beneath the soothing waters he forgets all about it all and just relaxes.", false);
			outputText("\n\nHis reprieve is rudely interrupted as something thick and viscous wraps around his legs, gripping them with vicelike tightness.  He kicks futilely, accomplishing nothing but making the once-champion's goopey body jiggle as it slowly envelops more and more of the young man.  Suspended so that his head barely breaks the surface of the water, his entire body is wrapped up in more and more of the slime.  It curls around his member, slick and moist, gently massaging away his desire to resist.  The new champion relaxes and accepts it, twitching as the slime manages to caress a particularly tender spot.", false);
			outputText("\n\nThough the situation is incredibly pleasurable to both parties, the slime is merely following its instincts and seeking to fulfill its never ending craving.  For his part, the champion resisted admirably, though perhaps he simply had a high sexual endurance.  Whatever the case, this male doesn't last too long.  His altered sexuality easily accommodates the creature's desires, filling it with spurt after spurt of creamy whiteness, making it stronger for the first time in a long time.  It does not release him once his orgasm concludes.  It milks him again, and again, and again until the champion is unconscious, cradled in the slime's sloppy embrace.", false);
			outputText("\n\nFilled with new-found vigor, the slime travels up the beach, still holding its captive trapped inside it.  Its body shifts as a half-remembered humanoid form grows out from the blob's surface.  The new body is a parody of its former self, with sexually distorted features and jiggling, globe-like breasts.  It presses the captive's lips against a nipple, allowing him to suckle down a bit of her essence.  He does so instinctively – his parched body seeking relief from the orgasm-induced dehydration afflicting him.", false);
			outputText("\n\nIn a few hours he awakens, still entirely trapped by the wet-dream of a slime-girl.  His belly is full of her nutritious and corruptive slime, and his cock feels bigger and more sensitive than ever inside her tight embrace.  She squeezes and milks it, gurgling happily.  He cums for her.  Again and again he cums for her.  He can't stop or resist the feeling she gives him as he helplessly orgasms over and over.  She milks him forever, growing stronger, feeding him slime, and gathering incubi drafts and succubi's delight to satiate her ever-growing needs.", false);
			outputText("\n\nEvery year thereafter the new champion is greeted with a slippery prison.  Forced to orgasm and feed the slime-queen for the rest of their natural life.  Most of them stop minding by the second day, too drunk on her breast-milk and all the drugs she's mixed into it.", false);
			eventParser(5035);
		}
		public function giveHumanizer():void {
			if(flags[kFLAGS.TIMES_CHEATED_COUNTER] > 0) {
				outputText("<b>I was a cheater until I took an arrow to the knee...</b>", true);
				eventParser(5035);
				return;
			}
			outputText("I AM NOT A CROOK.  BUT YOU ARE!  <b>CHEATER</b>!\n\n", true);
			inventory.takeItem(consumables.HUMMUS_);
			flags[kFLAGS.TIMES_CHEATED_COUNTER]++;
		}
//Create a storage slot
public function createStorage():Boolean {
	if(itemStorage.length >= 16) return false;
	var newSlot:* = new ItemSlotClass();
	itemStorage.push(newSlot);
	return true;
}
//Clear storage slots
public function clearStorage():void {
	//Various Errors preventing action
	if(itemStorage == null) trace("ERROR: Cannot clear storage because storage does not exist.");
	else {
		trace("Attempted to remove " + itemStorage.length + " storage slots.");
		itemStorage.splice(0, itemStorage.length);
	}
}
public function clearGearStorage():void {
	//Various Errors preventing action
	if(gearStorage == null) trace("ERROR: Cannot clear storage because storage does not exist.");
	else {
		trace("Attempted to remove " + gearStorage.length + " storage slots.");
		gearStorage.splice(0, gearStorage.length);
	}
}

public function initializeGearStorage():void {
	//Completely empty storage array
	if(gearStorage == null) trace("ERROR: Cannot clear gearStorage because storage does not exist.");
	else {
		trace("Attempted to remove " + gearStorage.length + " gearStorage slots.");
		gearStorage.splice(0, gearStorage.length);
	}
	//Rebuild a new one!
	var newSlot:*;
	while(gearStorage.length < 18) {
		newSlot = new ItemSlotClass();
		gearStorage.push(newSlot);
	}
}
	}
}