/**
 * ...
 * @author Ormael
 * 
 * Simple village for soul cultivators He'xin'dao - River Island
 */

package classes.Scenes.Places {
	
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.Scenes.Areas.Forest.TentacleBeast;
	import classes.Scenes.Places.HeXinDao.*;
	import classes.Scenes.Monsters.*;
	import classes.Scenes.NPCs.Jeniffer;
	//import classes.Scenes.Places.HeXinDao.*;
	//import classes.Items.Armor;
	//import classes.Scenes.Dungeons.DeepCave.ValaScene;

	public class HeXinDao extends BaseContent
{
	
	public var ignisarenaseer:IgnisArenaSeerScene = new IgnisArenaSeerScene();
	//public var vala:ValaScene = new ValaScene();
	//public var TFmerch:MogaHen = new MogaHen();
	
	public function HeXinDao() 
	{
		
	}

public function riverislandVillageStuff():void {
	spriteSelect(-1);
	clearOutput();
	outputText("He'Xin'Dao is large sized village placed on many various sized islands in the middle of large river that flow from east ot west. Aside from bridges connecting each of the island to others, two larger ones connects them as whole to both sides of the river serving as only point of access to it.  Protection formations laid out preventing from entering by swimming throu the river directly to any of the smaller islands, which force anyone to use bridges if their wish to enter.\n");
	//outputText("\n\nNear one of major briges is located merchant area with various smaller or larger places where all visitors can buy or sell various items. Among then two attracts most attention with first been largest stall here and other largest shop. On almsot opposite side of village near other brige is located medium sized shop with sign indicating it govern local exchanges and transformation items market.");
	//outputText("\n\nAt the island located on west end of He'Xin'Dao you see one of biggest buildings here. From sounds of weapon clashing it seems to be some kind of local arena.");
	//outputText("\n.");	//Z czasem jak bede dodawac miejsca opis wioski bedzie rozbudowywany :P
	riverislandMenuShow();
}

public function riverislandMenuShow():void {
	menu();
	addButton(0, "Merchant", golemmerchant);
	addButton(1, "TFspec/Exch", mogahenmerchant);
	addButton(2, "SoulEquip", soulequipmentmerchant);
	addButton(3, "SoulArrow", soularrowmerchant);
	//addButton(5, "", ); siedziba lokalnej grupy zrzeszającej soul cultivators - PC aby potem pojsc dalej bedzie musial dolaczyc tutaj (pomyslec nad wiarygodnym sposobem zmuszenia go do tego - moze jakies ciekawe itemy/inne rzeczy dla czlonkow beda a miejsce sie zwolni jak wywala tak goblinke tworzynie golemow, ktora potem oczywiscie wcisnie sie do obozu PC aby w spokoju rozwijac sie w tworzeniu golemow itp.)
	//addButton(6, "", ); jakies miejsce aby zdobywac gems lub/i EXP - moze jakies zadania tu zlecane czy cos w tym stylu?
	addButton(7, "Arena", soularena);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}
public function golemmerchant():void {
	clearOutput();
	outputText("You enter a shop that got sign over the entrance titled 'Soul Items'.  Inside you see few stalls with similar looking items put on the display.  Actually it not seems this merchant got 'a wide' choice of things but for someone at the beginning of soul cultivator road it's probably enough.  Sensing some movements from the corner of the shop that is pernamently covered in darkness a person appearing without making any sound.  'He' is around five feet tall with outer appearance of some kind of demonic monster. ");
	if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) outputText("But he do looks quite similar to the gargoyle from the cathedral.");
	outputText("\n\n\"<i>Welcome to my master's shop dear customer. Feel free to look around,</i>\" he says. \n\n");
	if (flags[kFLAGS.CODEX_ENTRY_GOLEMS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_GOLEMS] = 1;
		outputText("<b>New codex entry unlocked: Golems!</b>\n\n")
	}
	menu();
	addButton(0, "LGSFRecovPill", LowGradeSoulforceRecoveryPill).hint("Low-grade Soulforce Recovery Pill.");
	addButton(1, "Bag of Cosmos", BagOfCosmos).hint("Bag of Cosmos.");
	if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
		addButton(2, "Triple Thrust", TripleThrustManual).hint("Triple Thrust Manual.");
		addButton(3, "Draco Sweep", DracoSweepManual).hint("Draco Sweep Manual.");
		addButton(4, "Many Birds", ManyBirdsManual).hint("Many Birds Manual.");
	}
	if (player.findPerk(PerkLib.SoulWarrior) >= 0) {
		addButton(5, "MGSFRecovPill", MidGradeSoulforceRecoveryPill).hint("Mid-grade Soulforce Recovery Pill.");
		addButton(6, "Comet", CometManual).hint("Comet Manual.");
		addButton(7, "V P Trans", VioletPupilTransformationManual).hint("Violet Pupil Transformation Manual.");
	}
	if (player.findPerk(PerkLib.SoulOverlord) >= 0) {
		addButton(10, "HGSFRecovPill", HighGradeSoulforceRecoveryPill).hint("High-grade Soulforce Recovery Pill.");
	}
	addButton(13, "IncenOfInsig", IncenseOfInsight).hint("Incense of Insight.");
	addButton(14, "Back", riverislandVillageStuff);
	statScreenRefresh();
}

public function LowGradeSoulforceRecoveryPill():void {
	clearOutput();
	outputText("While you reach toward the one of the pills on the display golem says, \"<i>It's quite useful item for all soul cultivators, this little pill can help you restore some of used up soulforce.  Interested?  It is <b>5 gems</b></i>.\"");
	doYesNo(buyLowGradeSoulforceRecoveryPill, golemmerchant);
}
public function buyLowGradeSoulforceRecoveryPill():void {
	if (player.gems < 5) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(5 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		player.gems -= 5;
		outputText("\n");
		inventory.takeItem(consumables.LG_SFRP, golemmerchant);
		statScreenRefresh();
	}
}

public function MidGradeSoulforceRecoveryPill():void {
	clearOutput();
	outputText("While you reach toward the one of the pills on the display golem says, \"<i>It's quite useful item for all cultivators at Soul Personage or above stage, this small pill can help you restore some of used up soulforce and it would be much more than the low-grade one.  Interested?  It is <b>30 gems</b></i>.\"");
	doYesNo(buyMidGradeSoulforceRecoveryPill, golemmerchant);
}
public function buyMidGradeSoulforceRecoveryPill():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		player.gems -= 30;
		outputText("\n");
		inventory.takeItem(consumables.MG_SFRP, golemmerchant);
		statScreenRefresh();
	}
}

public function HighGradeSoulforceRecoveryPill():void {
	clearOutput();
	outputText("While you reach toward the one of the pills on the display golem says, \"<i>It's quite useful item for all cultivators at Soul Personage or above stage, this small pill can help you restore some of used up soulforce and it would be much more than the low-grade one.  Interested?  It is <b>180 gems</b></i>.\"");
	doYesNo(buyHighGradeSoulforceRecoveryPill, golemmerchant);
}
public function buyHighGradeSoulforceRecoveryPill():void {
	if (player.gems < 180) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(180 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		player.gems -= 180;
		outputText("\n");
		inventory.takeItem(consumables.HG_SFRP, golemmerchant);
		statScreenRefresh();
	}
}

public function IncenseOfInsight():void {
	clearOutput();
	outputText("While you reach toward the one of the pills on the display golem says, \"<i>These incenses are quite special. They will grant you visions if only for a moment while meditating. This should help you find the wisdom and insight you need.  Interested?  It is <b>15 gems</b></i>.\"");
	doYesNo(buyIncenseOfInsight, golemmerchant);
}

public function buyIncenseOfInsight():void {
	if (player.gems < 15) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		player.gems -= 15;
		inventory.takeItem(consumables.INCOINS, golemmerchant);
		statScreenRefresh();
	}
}

public function BagOfCosmos():void {
	clearOutput();
	outputText("While you reach toward the one of the bags on the display golem says, \"<i>It's quintessential item for all soul cultivators, this little bag can hold much more things inside that it own size.  Interested?  It is <b>1200 gems</b></i>.\"");
	doYesNo(buyBagOfCosmos, golemmerchant);
}

public function buyBagOfCosmos():void {
	if (player.gems < 1200) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(1200 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		player.gems -= 1200;
		outputText("\n");
		inventory.takeItem(consumables.BAGOCOS, golemmerchant);
		statScreenRefresh();
	}
}

public function TripleThrustManual():void {
	clearOutput();
	outputText("While you reach toward the one of the manuals on the display golem says, \"<i>It's manual for Triple Thrust, this simple technique allows to unleash three thrusts that will became stronger and stronger as you train your body and soul.  Interested?  It is <b>50 gems</b></i>.\"");
	doYesNo(buyTripleThrustManual, golemmerchant);
}

public function buyTripleThrustManual():void {
	if (player.gems < 50) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		outputText("\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to begin.  Although seems even name of the manual mentioning thrusting seems like it could have been influenced by this realm nature...or it's just a coincidence.  ");
		player.gems -= 50;
		inventory.takeItem(consumables.TRITMAN, golemmerchant);
		statScreenRefresh();
	}
}

public function DracoSweepManual():void {
	clearOutput();
	outputText("While you reach toward the one of the manuals on the display golem says, \"<i>It's manual for Draco Sweep, this simple technique allows to unleash attack that would strike in wide arc before you.  Perfect when you fight group of enemies and it also becoming more powerful as long you would train your body and soul.  Interested?  It is <b>50 gems</b></i>.\"");
	doYesNo(buyDracoSweepManual, golemmerchant);
}

public function buyDracoSweepManual():void {
	if (player.gems < 50) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		outputText("\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to use when figthing group of enemies.  Although you not meet often so far more than singular enemy at once you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  ");
		player.gems -= 50;
		inventory.takeItem(consumables.DRASMAN, golemmerchant);
		statScreenRefresh();
	}
}

public function ManyBirdsManual():void {
	clearOutput();
	outputText("While you reach toward the one of the manuals on the display golem says, \"<i>It's manual for Many Birds, this simple technique allows to project a figment of your soulforce as a crystal traveling at extreme speeds that will became stronger and stronger as you train your body and soul.  Interested?  It is <b>50 gems</b></i>.\"");
	doYesNo(buyManyBirdsManual, golemmerchant);
}

public function buyManyBirdsManual():void {
	if (player.gems < 50) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		outputText("\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to begin.  Although seems name of the manual is odd but it makes you remember something...but what and from where you not certain.  ");
		player.gems -= 50;
		inventory.takeItem(consumables.MABIMAN, golemmerchant);
		statScreenRefresh();
	}
}

public function CometManual():void {
	clearOutput();
	outputText("While you reach toward the one of the manuals on the display golem says, \"<i>It's manual for Comet, this technique allows to project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.  Perfect when you fight group of enemies and it also becoming more powerful as long you would train your body and soul.  Interested?  It is <b>250 gems</b></i>.\"");
	doYesNo(buyCometManual, golemmerchant);
}

public function buyCometManual():void {
	if (player.gems < 250) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(250 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		outputText("\n\nWherever you gonna try to go deeper into all that 'soulforce' stuff or not at least you now got something to use when figthing group of enemies.  Although you not meet often so far more than singular enemy at once you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  ");
		player.gems -= 250;
		inventory.takeItem(consumables.COMETMA, golemmerchant);
		statScreenRefresh();
	}
}

public function VioletPupilTransformationManual():void {
	clearOutput();
	outputText("While you reach toward the one of the manuals on the display golem says, \"<i>It's manual for Violet Pupil Transformation, this advanced technique allows to channel soulforce into regenerative power that would fill whole body allowing recovering even from a brink of a death.  It only flaw is that it constantly drain cultivator soulforce so you could end in a tight situation without enough soulforce to use other skills.  Interested?  It is <b>250 gems</b></i>.\"");
	doYesNo(buyVioletPupilTransformationManual, golemmerchant);
}

public function buyVioletPupilTransformationManual():void {
	if (player.gems < 250) {
		clearOutput();
		outputText("\n\nGolem shakes his head, indicating you need " + String(250 - player.gems) + " more gems to purchase this item.");
		doNext(golemmerchant);
	}
	else {
		outputText("\n\nSeems like it's similar to healing spell soul skill and on top of that the one which isn't one time used one time healed but with enough soulforce could be kept active for very long period of time.  It should give you another edge during your crusade against demons.  Additionaly ability to healing from brink of death could prove to be usefull in future fights.  ");
		player.gems -= 250;
		inventory.takeItem(consumables.VPTRMAN, golemmerchant);
		statScreenRefresh();
	}
}

public function mogahenmerchant():void {
	clearOutput();
	outputText("You enter a shop that got sign over the entrance titled 'Transformative Items and Exchanges'.  Inside you see few stalls with many types of the items put on the display.  Most of them you have already seen somewhere but few seems to been quite rare ones as you not seen many of them so far or at least never seen in such large amounts gathered in one place.");
	outputText("\n\nWhen you're looking over the stalls human owner almost silently approched you but compared to other shop you have seen in this islands Moga Hen by clearing his throat attracts your attention to himself.  After you turned toward him, smiling at you like a cat at the mouse, he first breaks the silence.");
	outputText("\n\n\"<i>Welcome to my humble shop dear and precious customer. What need bring you here today? To repair some damage by using casual picked item or some specific change to attain? Or maybe you need to exchange some gems or spirit stones? I could even give you a fair price on special items that are useless for non-cultivators.</i>\" Each word sounds almost like it was repeated endless times.\n\n");
	menu();
	addButton(0, "1st Stall", Tier1).hint("Check out first of stalls with a cheapest TF items.");
	addButton(1, "2nd Stall", Tier2).hint("Check out second of stalls with a cheapest TF items.");
	addButton(2, "3rd Stall", Tier3).hint("Check out stall with more expensive TF items.");
	addButton(3, "4th Stall", Tier4).hint("Check out stall with most expensive TF items.");
	addButton(5, "5th Stall", Tier5).hint("Check out stall with most exotic TF items.");		//specjalne type TF jak ectoplasm ^^
	//addButton(10, "Talk", TalkWithMogaHen).hint("Talk with shopkeeper.");
	addButton(11, "Sell", sellItemsForSpiritStones).hint("Sell items for spirit stones.");
	addButton(12, "Exchange", exchangeGemsToSpiritStonesorReverse).hint("Exchange gems to spirit stones or spirit stones to gems.");
	addButton(14, "Back", riverislandVillageStuff);
	statScreenRefresh();
}

public function exchangeGemsToSpiritStonesorReverse():void {
	clearOutput();
	outputText("When you ask about this exchange that was mentioned on the sign over the entrance Moga  think for a moment before reaching to the desk near him. After handing you over a piece of paper he adds.");
	outputText("\n\n\"<i>Here are my exchange rates. Pick the one you want and let me know. If you don't like those rates you can go and try to find someone else... not like there is anyone else here that want to deal with those exchanges aside me.</i>\"");
	outputText("\n\n\<b>Spirit Stones: </b>" + flags[kFLAGS.SPIRIT_STONES] + "\n");
	menu();
	if (player.gems >= 20) addButton(0, "20 Gems", gems20).hint("Exchange 20 gems to 1 spirit stone.");
	if (player.gems >= 100) addButton(1, "100 Gems", gems100).hint("Exchange 100 gems to 5 spirit stones.");
	if (player.gems >= 200) addButton(2, "200 Gems", gems200).hint("Exchange 200 gems to 10 spirit stones.");
	if (player.gems >= 1000) addButton(3, "1000 Gems", gems1000).hint("Exchange 1000 gems to 50 spirit stones.");
	if (player.gems >= 2000) addButton(4, "2000 Gems", gems2000).hint("Exchange 2000 gems to 100 spirit stones.");
	if (flags[kFLAGS.SPIRIT_STONES] >= 1) addButton(5, "1 SS", spiritstone1).hint("Exchange 1 spirit stone to 5 gems.");
	if (flags[kFLAGS.SPIRIT_STONES] >= 5) addButton(6, "5 SS", spiritstone5).hint("Exchange 5 spirit stones to 25 gems.");
	if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(7, "10 SS", spiritstone10).hint("Exchange 10 spirit stones to 50 gems.");
	if (flags[kFLAGS.SPIRIT_STONES] >= 50) addButton(8, "50 SS", spiritstone50).hint("Exchange 50 spirit stones to 250 gems.");
	if (flags[kFLAGS.SPIRIT_STONES] >= 100) addButton(9, "100 SS", spiritstone100).hint("Exchange 100 spirit stones to 500 gems.");
	addButton(14, "Back", mogahenmerchant);
}

public function gems20():void {
	clearOutput();
	outputText("After picking the lowers one rate for gems to stones you count gems before giving them to the merchant. With noticable mumbling about customer been stingy he without haste finishing transaction by giving you one spirit stone.");
	player.gems -= 20;
	flags[kFLAGS.SPIRIT_STONES]++;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function gems100():void {
	clearOutput();
	outputText("After picking the low one rate for gems to stones you count gems before giving them to the merchant. With barely noticable mumbling about customer been stingy he without haste finishing transaction by giving you five spirit stones.");
	player.gems -= 100;
	flags[kFLAGS.SPIRIT_STONES] += 5;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function gems200():void {
	clearOutput();
	outputText("After picking the middle one rate for gems to stones you count gems before giving them to merchant. Without haste he finishing transaction by giving you ten spirit stones.");
	player.gems -= 200;
	flags[kFLAGS.SPIRIT_STONES] += 10;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function gems1000():void {
	clearOutput();
	outputText("After picking the high one rate for gems to stones you count gems before giving them to merchant. With slight haste he finishing transaction by giving you fifty spirit stones.");
	player.gems -= 1000;
	flags[kFLAGS.SPIRIT_STONES] += 50;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function gems2000():void {
	clearOutput();
	outputText("After picking the highest one rate for gems to stones you count gems before giving them to merchant. With haste he finishing transaction by giving you hundred spirit stones.");
	player.gems -= 2000;
	flags[kFLAGS.SPIRIT_STONES] += 100;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function spiritstone1():void {
	clearOutput();
	outputText("After picking the lowers one rate for stones to gems you hand over one stone to the merchant. With noticable mumbling about customer been stingy he without haste finishing transaction by giving you gems.");
	player.gems += 5;
	flags[kFLAGS.SPIRIT_STONES]--;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function spiritstone5():void {
	clearOutput();
	outputText("After picking the low one rate for stones to gems you hand over five stones to the merchant. With barely noticable mumbling about customer been stingy he without haste finishing transaction by giving you gems.");
	player.gems += 25;
	flags[kFLAGS.SPIRIT_STONES] -= 5;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function spiritstone10():void {
	clearOutput();
	outputText("After picking the middle one rate for stones to gems you hand over ten stones to the merchant. Without haste he finishing transaction by giving you gems.");
	player.gems += 50;
	flags[kFLAGS.SPIRIT_STONES] -= 10;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function spiritstone50():void {
	clearOutput();
	outputText("After picking the high one rate for stones to gems you hand over fifty stones to the merchant. With slight haste he finishing transaction by giving you gems.");
	player.gems += 250;
	flags[kFLAGS.SPIRIT_STONES] -= 50;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function spiritstone100():void {
	clearOutput();
	outputText("After picking the highest one rate for stones to gems you hand over hundred stones to the merchant. With haste he finishing transaction by giving you gems.");
	player.gems += 500;
	flags[kFLAGS.SPIRIT_STONES] -= 100;
	statScreenRefresh();
	doNext(exchangeGemsToSpiritStonesorReverse);
}

public function sellItemsForSpiritStones():void {
	clearOutput();
	outputText("\"<i>Let me look over what you got for sale. I promise I will give you a 'fair' price for those things,</i>\" Saying this the merchant calmly awaits what you will take out.");
	menu();
	if (player.hasItem(useables.GOLCORE, 1)) addButton(0, "Sell 1", sellOneGolemCore).hint("Sell 1 golem core.");
	if (player.hasItem(useables.GOLCORE, 5)) addButton(1, "Sell 5", sellFiveGolemCores).hint("Sell 5 golem cores.");
	addButton(14, "Back", mogahenmerchant);
}

public function sellOneGolemCore():void {
	clearOutput();
	outputText("\"<i>A single golem core. Still in good shape so that will be single spirit stone,</i>\" he states after examing core. Moment later after he went to put away core Moga gave you a single stone.");
	player.destroyItems(useables.GOLCORE, 1);
	flags[kFLAGS.SPIRIT_STONES]++;
	doNext(sellItemsForSpiritStones);
}

public function sellFiveGolemCores():void {
	clearOutput();
	outputText("\"<i>Golem cores. Let me check...yes the all seems to be in decent shape,</i>\" after examination he walks away to return shortly. \"<i>Here your five stones for them.</i>\"");
	player.destroyItems(useables.GOLCORE, 5);
	flags[kFLAGS.SPIRIT_STONES] += 5;
	doNext(sellItemsForSpiritStones);
}

public function Tier1():void {
	menu();
	addButton(0, "B.Gossr", BGossr).hint("Buy a bundle of black, gossamer webbing.");
	addButton(1, "BeeHony", BeeHony).hint("Buy a small vial filled with giant-bee honey.");
	addButton(2, "BladeGrass", BladeGrass).hint("Buy a blade shaped grass.");
	addButton(3, "CanineP", CanineP).hint("Buy a Canine pepper.");
	addButton(4, "Equinum", Equinum).hint("Buy a vial of Equinum.");
	addButton(5, "Fox Berry", FoxBerry).hint("Buy a fox berry.");
	addButton(6, "FerretFrt", FerretFrt).hint("Buy a ferret fruit.");
	addButton(7, "GoldenRind", GoldenRind).hint("Buy a golden rind.");
	addButton(8, "GoldenSeed", GoldenSeed).hint("Buy a golden seed.");
	addButton(9, "Gob.Ale", GobAle).hint("Buy a flagon of potent goblin ale.");
	addButton(10, "KangaFruit", KangaFruit).hint("Buy a piece of kanga fruit.");
	addButton(11, "La Bova", LaBova).hint("Buy a bottle containing a misty fluid labeled \"LaBova\".");
	addButton(12, "MouseCo", MouseCo).hint("Buy a handful of mouse cocoa.");
	addButton(13, "MinoBlo", MinoBlo).hint("Buy a vial of Minotaur blood.");
	addButton(14, "Back", mogahenmerchant);
	statScreenRefresh();
}

public function Tier2():void {
	menu();
	addButton(0, "PigTruffle", PigTruffle).hint("Buy a pigtail truffle.");
	addButton(1, "Reptilum", Reptilum).hint("Buy a vial of Reptilum.");
	addButton(2, "RingFig", RingFig).hint("Buy a ringtail fig.");
	addButton(3, "S.Gossr", SGossr).hint("Buy a bundle of pink, gossamer webbing.");
	addButton(4, "SalamFW", SalamFW).hint("Buy a hip flask of Salamander Firewater.");
	addButton(5, "Scorpinum", Scorpinum).hint("Buy a vial of Scorpinum.");
	addButton(6, "Shark.T", SharkT).hint("Buy a sharp shark tooth.");
	addButton(7, "SnakeOil", SnakeOil).hint("Buy a vial of snake oil.");
	addButton(8, "TSTooth", TSTooth).hint("Buy a glowing tiger shark tooth.");
	addButton(9, "W.Fruit", WFruit).hint("Buy a piece of whisker-fruit.");
	addButton(10, "WetCloth", WetCloth).hint("Buy a wet cloth dripping with slippery slime.");
	addButton(11, "YetiCum", YetiCum).hint("Buy a bottle of Yeti Cum.");
	addButton(14, "Back", mogahenmerchant);
	statScreenRefresh();
}

public function Tier3():void {
	menu();
	addButton(0, "BlackInk", BlackInk).hint("Buy a vial of black ink.");
	addButton(1, "BlackPp", BlackPp).hint("Buy solid black canine pepper.");
	addButton(2, "BulbyPp", BulbyPp).hint("Buy a bulbous pepper.");
	addButton(3, "DblPepp", DblPepp).hint("Buy a double canine pepper.");
	addButton(4, "KnottyP", KnottyP).hint("Buy a knotty canine pepper.");
	addButton(5, "LargePp", LargePp).hint("Buy an overly large canine pepper.");
	addButton(6, "ChillyP", ChillyPp).hint("Buy a Chilly pepper.");
	addButton(7, "MaraFruit", MaraFru).hint("Buy an apple-shaped fruit.");
	//addButton(8, "B.Gossr", BGossr).hint("Buy .");
	//addButton(9, "B.Gossr", BGossr).hint("Buy .");
	addButton(14, "Back", mogahenmerchant);
	statScreenRefresh();
}

public function Tier4():void {
	menu();
	//addButton(0, "B.Gossr", BGossr).hint("Buy .");
	addButton(0, "SpHoney", SpHoney).hint("Buy a bottle of special bee honey.");
	addButton(1, "SatyrWine", SatyrWine).hint("Buy a bottle of satyr wine.");
	//addButton(1, "B.Gossr", BGossr).hint("Buy .");
	addButton(2, "DrakeHeart", DrakeHeart).hint("Buy a drake's heart's flower.");
	//addButton(2, "B.Gossr", BGossr).hint("Buy .");
	addButton(4, "Hummus", Hummus).hint("Buy a blob of cheesy-looking hummus.");
	addButton(14, "Back", mogahenmerchant);
	statScreenRefresh();
}

public function Tier5():void {
	menu();
	addButton(0, "Coal", Coal1).hint("Buy two pieces of coal.");
	addButton(1, "DryTent", DryTent).hint("Buy a shriveled tentacle.");
	addButton(2, "EctoPls", Ectopls).hint("Buy a bottle of ectoplasm.");
	addButton(3, "TrapOil", TrapOil).hint("Buy a vial of trap oil.");
	addButton(14, "Back", mogahenmerchant);
	statScreenRefresh();
}

//Tier 1 - 6 gems
public function BGossr():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace draider in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyBGossr, mogahenmerchant);
}

public function buyBGossr():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.B_GOSSR, mogahenmerchant);
		statScreenRefresh();
	}
}

public function BeeHony():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace bee in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyBeeHony, mogahenmerchant);
}

public function buyBeeHony():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.BEEHONY, mogahenmerchant);
		statScreenRefresh();
	}
}

public function BladeGrass():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace mantis in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyBladeGrass, mogahenmerchant);
}

public function buyBladeGrass():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.BLADEGR, mogahenmerchant);
		statScreenRefresh();
	}
}

public function CanineP():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyCanineP, mogahenmerchant);
}

public function buyCanineP():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.CANINEP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function Equinum():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace horse in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyEquinum, mogahenmerchant);
}

public function buyEquinum():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.EQUINUM, mogahenmerchant);
		statScreenRefresh();
	}
}

public function FoxBerry():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace fox in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyFoxBerry, mogahenmerchant);
}

public function buyFoxBerry():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.FOXBERY, mogahenmerchant);
		statScreenRefresh();
	}
}

public function FerretFrt():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace horse in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyFerretFrt, mogahenmerchant);
}

public function buyFerretFrt():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.FRRTFRT, mogahenmerchant);
		statScreenRefresh();
	}
}

public function GoldenRind():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace deer in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyGoldenRind, mogahenmerchant);
}

public function buyGoldenRind():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.GLDRIND, mogahenmerchant);
		statScreenRefresh();
	}
}

public function GoldenSeed():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace harpy in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyGoldenSeed, mogahenmerchant);
}

public function buyGoldenSeed():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.GLDSEED, mogahenmerchant);
		statScreenRefresh();
	}
}

public function GobAle():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace goblin in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyGobAle, mogahenmerchant);
}

public function buyGobAle():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.GOB_ALE, mogahenmerchant);
		statScreenRefresh();
	}
}

public function KangaFruit():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace kangaroo in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyKangaFruit, mogahenmerchant);
}

public function buyKangaFruit():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.KANGAFT, mogahenmerchant);
		statScreenRefresh();
	}
}

public function LaBova():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace cow in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyLaBova, mogahenmerchant);
}

public function buyLaBova():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.LABOVA_, mogahenmerchant);
		statScreenRefresh();
	}
}

public function MouseCo():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace mouse in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyMouseCo, mogahenmerchant);
}

public function buyMouseCo():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.MOUSECO, mogahenmerchant);
		statScreenRefresh();
	}
}

public function MinoBlo():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace bull in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyMinoBlo, mogahenmerchant);
}

public function buyMinoBlo():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.MINOBLO, mogahenmerchant);
		statScreenRefresh();
	}
}

public function PigTruffle():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace pig in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyPigTruffle, mogahenmerchant);
}

public function buyPigTruffle():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.PIGTRUF, mogahenmerchant);
		statScreenRefresh();
	}
}

public function Reptilum():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace lizan in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyReptilum, mogahenmerchant);
}

public function buyReptilum():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.REPTLUM, mogahenmerchant);
		statScreenRefresh();
	}
}

public function RingFig():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace raccoon in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyRingFig, mogahenmerchant);
}

public function buyRingFig():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.RINGFIG, mogahenmerchant);
		statScreenRefresh();
	}
}

public function SGossr():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace spider in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buySGossr, mogahenmerchant);
}

public function buySGossr():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.S_GOSSR, mogahenmerchant);
		statScreenRefresh();
	}
}

public function SalamFW():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace salamander in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buySalamFW, mogahenmerchant);
}

public function buySalamFW():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.SALAMFW, mogahenmerchant);
		statScreenRefresh();
	}
}

public function Scorpinum():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace scorpion in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyScorpinum, mogahenmerchant);
}

public function buyScorpinum():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.SCORICO, mogahenmerchant);
		statScreenRefresh();
	}
}

public function SharkT():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace shark in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buySharkT, mogahenmerchant);
}

public function buySharkT():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.SHARK_T, mogahenmerchant);
		statScreenRefresh();
	}
}

public function SnakeOil():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace snake in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buySnakeOil, mogahenmerchant);
}

public function buySnakeOil():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.SNAKOIL, mogahenmerchant);
		statScreenRefresh();
	}
}

public function TSTooth():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace tigershark in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyTSTooth, mogahenmerchant);
}

public function buyTSTooth():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.TSTOOTH, mogahenmerchant);
		statScreenRefresh();
	}
}

public function WFruit():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace cat in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyWFruit, mogahenmerchant);
}

public function buyWFruit():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.W_FRUIT, mogahenmerchant);
		statScreenRefresh();
	}
}

public function WetCloth():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace goo in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyWetCloth, mogahenmerchant);
}

public function buyWetCloth():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.WETCLTH, mogahenmerchant);
		statScreenRefresh();
	}
}

public function YetiCum():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace yeti in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyYetiCum, mogahenmerchant);
}

public function buyYetiCum():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.YETICUM, mogahenmerchant);
		statScreenRefresh();
	}
}

//Tier 2 - 10 gems
public function BlackInk():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace female scylla in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyBlackInk, mogahenmerchant);
}

public function buyBlackInk():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.BLACKIN, mogahenmerchant);
		statScreenRefresh();
	}
}

public function BlackPp():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyBlackPp, mogahenmerchant);
}

public function buyBlackPp():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.BLACKPP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function BulbyPp():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyBulbyPp, mogahenmerchant);
}

public function buyBulbyPp():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.BULBYPP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function DblPepp():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyDblPepp, mogahenmerchant);
}

public function buyDblPepp():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.DBLPEPP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function KnottyP():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyKnottyP, mogahenmerchant);
}

public function buyKnottyP():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.KNOTTYP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function LargePp():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dog in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyLargePp, mogahenmerchant);
}

public function buyLargePp():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.LARGEPP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function ChillyPp():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace winter wolf in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyChillyPp, mogahenmerchant);
}

public function buyChillyPp():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.CHILLYP, mogahenmerchant);
		statScreenRefresh();
	}
}

public function MaraFru():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace plant in you.  Interested?  It is merely <b>30 gems</b></i>.\"");
	doYesNo(buyMaraFru, mogahenmerchant);
}

public function buyMaraFru():void {
	if (player.gems < 30) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 30;
		inventory.takeItem(consumables.MARAFRU, mogahenmerchant);
		statScreenRefresh();
	}
}

//Tier 3 - 20 gems
public function SpHoney():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace bee in you.  Interested?  It is merely <b>60 gems</b></i>.\"");
	doYesNo(buySpHoney, mogahenmerchant);
}

public function buySpHoney():void {
	if (player.gems < 60) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(60 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 60;
		inventory.takeItem(consumables.SPHONEY, mogahenmerchant);
		statScreenRefresh();
	}
}

public function SatyrWine():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace satyr in you.  Interested?  It is merely <b>60 gems</b></i>.\"");
	doYesNo(buySatyrWine, mogahenmerchant);
}

public function buySatyrWine():void {
	if (player.gems < 60) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(60 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 60;
		inventory.takeItem(consumables.SATYR_W, mogahenmerchant);
		statScreenRefresh();
	}
}

//Tier 4 - 50 gems
public function DrakeHeart():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace dragon in you.  Interested?  It is merely <b>150 gems</b></i>.\"");
	doYesNo(buyDrakeHeart, mogahenmerchant);
}

public function buyDrakeHeart():void {
	if (player.gems < 150) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(150 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 150;
		inventory.takeItem(consumables.DRAKHRT, mogahenmerchant);
		statScreenRefresh();
	}
}

//Tier 5 - 100 gems
public function Hummus():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace humanity in you.  Interested?  It is merely <b>300 gems</b></i>.\"");
	doYesNo(buyHummus, mogahenmerchant);
}

public function buyHummus():void {
	if (player.gems < 300) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(300 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 300;
		inventory.takeItem(consumables.HUMMUS_, mogahenmerchant);
		statScreenRefresh();
	}
}

//Exotic TF's - 18 gems
public function Coal1():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace heat or rut in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyCoal, mogahenmerchant);
}

public function buyCoal():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.COAL___, mogahenmerchant);
		statScreenRefresh();
	}
}

public function DryTent():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace anemone in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyDryTent, mogahenmerchant);
}

public function buyDryTent():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.DRYTENT, mogahenmerchant);
		statScreenRefresh();
	}
}

public function Ectopls():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace ghost in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyEctopls, mogahenmerchant);
}

public function buyEctopls():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.ECTOPLS, mogahenmerchant);
		statScreenRefresh();
	}
}

public function TrapOil():void {
	clearOutput();
	outputText("While you point toward the one of the items on the display merchant says, \"<i>It's item to embrace sand trap in you.  Interested?  It is merely <b>18 gems</b></i>.\"");
	doYesNo(buyTrapOil, mogahenmerchant);
}

public function buyTrapOil():void {
	if (player.gems < 18) {
		clearOutput();
		outputText("\n\nMoga shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this item.");
		doNext(mogahenmerchant);
	}
	else {
		outputText("\n\nAfter you give Hen gems he hand over to you purchased transformative item. ");
		player.gems -= 18;
		inventory.takeItem(consumables.TRAPOIL, mogahenmerchant);
		statScreenRefresh();
	}
}

public function soulequipmentmerchant():void {
	clearOutput();//później zamienić soulequipment na imie sprzedawczyni ^^ female siren npc
	outputText("After entering the shop with a sign saying 'Equipment' over the doors you see a few shelves filled with various weapons, shields, armors and even more rare items like rings or necklaces. Behind the desk that looks like a central point of the shop you see a woman that seems to have mixed races traits. A shark face and a tail that sometimes show up on either side of the desk which is contrasting to its feather covered arms that are not looking at all like shark ones and more similar to bird wings.");
	outputText("\n\n\"<i>Greeting dear customer.  Look around and if something catch your eyes let me know,</i>\" she say all that almost on one breath after noticing your near.");
	outputText("\n\n\<b>Spirit Stones: </b>" + flags[kFLAGS.SPIRIT_STONES] + "\n");
	menu();
	addButton(1, "Shelf 1", soulequipmentshelf1);
	addButton(2, "Shelf 2", soulequipmentshelf2);
//	addButton(3, "Shelf 3", soulequipmentshelf3);//armors
	//addButton(9, weapons.ERIBBON.shortName, weaponBuy, weapons.ERIBBON);//czy bedzie tu jako do sprzedaży czy jako nagroda za quest lub drop z mobka/bossa?
	//addButton(7, weapons.MACE.shortName, weaponBuy, weapons.MACE);//awl - wymagać bedzie możliwość lewitacji czy coś od PC aby to używać
	//addButton(8, weapons.MACE.shortName, weaponBuy, weapons.MACE);//bow made for soul cultivator xD
	//addButton(12, "Talk", ).hint("Tak with .");
	addButton(9, jewelries.SOULRNG.shortName, weaponBuy, jewelries.SOULRNG);
	addButton(14, "Back", riverislandVillageStuff);
	statScreenRefresh();
}
public function soulequipmentshelf1():void {
	menu();
	addButton(0, consumables.W_STICK.shortName, weaponBuy, consumables.W_STICK);
	addButton(1, consumables.BANGB_M.shortName, weaponBuy, consumables.BANGB_M);
	addButton(5, weapons.TRASAXE.shortName, weaponBuy, weapons.TRASAXE);
	addButton(6, weaponsrange.TRSXBOW.shortName, weaponBuy, weaponsrange.TRSXBOW);
	addButton(7, shields.TRASBUC.shortName, weaponBuy, shields.TRASBUC);
	addButton(8, armors.TRASARM.shortName, weaponBuy, armors.TRASARM);
	addButton(10, weapons.W_STAFF.shortName, weaponBuy, weapons.W_STAFF);
	addButton(11, shields.MABRACE.shortName, weaponBuy, shields.MABRACE);
	addButton(14, "Back", soulequipmentmerchant);
}
public function soulequipmentshelf2():void {
	menu();
	addButton(0, weapons.KATANA.shortName, weaponBuy, weapons.KATANA);
	addButton(1, weapons.NODACHI.shortName, weaponBuy, weapons.NODACHI);
	addButton(2, weapons.OTETSU.shortName, weaponBuy, weapons.OTETSU);
	addButton(3, weapons.RCLAYMO.shortName, weaponBuy, weapons.RCLAYMO);
	addButton(4, weapons.SCLAYMO.shortName, weaponBuy, weapons.SCLAYMO);
	addButton(5, weapons.RIBBON.shortName, weaponBuy, weapons.RIBBON);
	addButton(6, weapons.S_GAUNT.shortName, weaponBuy, weapons.S_GAUNT);
	addButton(10, weapons.WHIP.shortName, weaponBuy, weapons.WHIP);
	addButton(11, weapons.PWHIP.shortName, weaponBuy, weapons.PWHIP);
	addButton(14, "Back", soulequipmentmerchant);
}
public function soulequipmentshelf3():void {
	menu();
	//if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(3, armors.LAYOARM.shortName, weaponBuy, armors.LAYOARM);
	//addButton(2, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic light armor made of soulmetal
	//addButton(0, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic heavy armor made of soulmetal
	//addButton(1, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic armor made of soulmetal that works with unhindered perk xD czyli coś ala bikini lub ogólnie tylko underwear z fragmentami zbroi lewitującymi wokół postaci i tylko w wypadku ataku wroga przesuwające sie aby przyjąć atak
	addButton(14, "Back", soulequipmentmerchant);
}

private function weaponBuy(itype:ItemType):void {
	clearOutput();
	outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
	//outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"");
	if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
		outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
		//Goto shop main menu
		doNext(soulequipmentmerchant);
		return;
	}
	else outputText("\n\nDo you buy it?\n\n");
	//Go to debit/update function or back to shop window
	doYesNo(curry(debitWeapon,itype), soulequipmentmerchant);
}
private function debitWeapon(itype:ItemType):void {
	flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
	statScreenRefresh();
	inventory.takeItem(itype, soulequipmentmerchant);
}

public function soularrowmerchant():void {
	clearOutput();//później zamienić soulequipment na imie sprzedawczyni ^^ female centaur npc
	outputText("After entering the shop with a sign saying 'Soul Arrow' over the doors you see a few shelves filled with various range weapons of all sorts from bows, throu crossbows to some more exotic ones tat you not even sure how to name them. ");
	outputText("Behind the desk that looks like a central point of the shop you see a centauress. She have no fancy or provocative clothes, average body with which she moves quite gracesfully around stalls with items for sale despite her naturaly larger body than most of people living here have.");
	outputText("\n\n\"<i>Greeting dear customer.  Look around and if something catch your eyes let me know,</i>\" she say all that almost on one breath after noticing your near.");
	menu();
	addButton(0, weaponsrange.BOWLIGH.shortName, weaponrangeBuy, weaponsrange.BOWLIGH);
	addButton(1, weaponsrange.BOWHUNT.shortName, weaponrangeBuy, weaponsrange.BOWHUNT);
	addButton(2, weaponsrange.BOWLONG.shortName, weaponrangeBuy, weaponsrange.BOWLONG);
	addButton(3, weaponsrange.BOWKELT.shortName, weaponrangeBuy, weaponsrange.BOWKELT);
	addButton(5, weaponsrange.LCROSBW.shortName, weaponrangeBuy, weaponsrange.LCROSBW);
	addButton(6, weaponsrange.HUXBOW_.shortName, weaponrangeBuy, weaponsrange.HUXBOW_);
	addButton(7, weaponsrange.HEXBOW_.shortName, weaponrangeBuy, weaponsrange.HEXBOW_);
	addButton(10, weaponsrange.FLINTLK.shortName, weaponrangeBuy, weaponsrange.FLINTLK);
	addButton(11, weaponsrange.BLUNDER.shortName, weaponrangeBuy, weaponsrange.BLUNDER);
	//addButton(7, weapons.MACE.shortName, weaponBuy, weapons.MACE);//awl - wymagać bedzie możliwość lewitacji czy coś od PC aby to używać
	//addButton(8, weapons.MACE.shortName, weaponBuy, weapons.MACE);//bow made for soul cultivator xD
	//addButton(12, "Talk", ).hint("Tak with .");
	addButton(14, "Back", riverislandVillageStuff);
	statScreenRefresh();
}

private function weaponrangeBuy(itype:ItemType):void {
	clearOutput();
	outputText("\"<i>That'll be " + itype.value + " gems.</i>\"");
	//outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"");
	if(player.gems < itype.value) {
		outputText("\n\nYou count out your gems and realize it's beyond your price range.");
		//Goto shop main menu
		doNext(soularrowmerchant);
		return;
	}
	else outputText("\n\nDo you buy it?\n\n");
	//Go to debit/update function or back to shop window
	doYesNo(curry(debitWeaponRange,itype), soularrowmerchant);
}
private function debitWeaponRange(itype:ItemType):void {
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, soularrowmerchant);
}

public function soularena():void {
	clearOutput();//arena do walk z przeciwnikami na exp tylko - zadnych sex scenes tylko walk do wygranej niewazne czy przez hp czy lust - przeciwnicy: dummy golem, grupa dummy golems, true golem, ?group of true golems, weak deviant golem?, niskopoziomowi przeciwnicy uzywajacy soul skills (moze po prostu wesje zwyklych przeciwnikow ale z dodanymi soul attakami?)
	outputText("Coming closer to the arena you see two muscular tigersharks standing on each side of the entrance, which only briefly glance at you the moment you pass by them. Inside after few a moment a tall slightly muscular male cat-morph approaches you. Most of its body is covered by armor yet two long tails waves behind him from time to time.");//osoba zarządzająca areną bedzie male nekomanta npc
	outputText("\n\n\"<i>Greeting to the Soul Arena. Don't pick up fights outside of the proper place or you will be thrown out. If you break any rule here you will be kicked out. Knowing this go pick the area where you want to train or maybe go to the challenges area,</i>\" without wasting time the nekomata overseer of this place explains you all that is needed and walk away.");
	outputText("\n\nSo which one of the three possible sub areas you gonna visit this time?");
	if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) ("\n\nYou notice Ignis sitting in the stands, a notebook in his paws. The kitsune seems to be watching the fights and taking notes as he does so.");
	menu();//statuseffect(soulArena) dodać na początku walk co pozwoli dać inne dropy itp. w stosuku do spotkania podobnego wroga w innym miejscu a nawet łatwo pozwoli zrobić wersje soulforce niektórych ras bez tworzenia nowych opisów monsterów - zrobić to dla trybu challenge, w który walka z wrogie da określony drop a nawet można na niej grać aby uzyskać nagro...np. nowego camp member ^^
	addButton(0, "Solo", soularenaSolo).hint("Go to the section of soul arena for 1 on 1 fights.");
	addButton(1, "Group", soularenaGroup).hint("Go to the section of soul arena for group fights.");
	addButton(2, "Challenge", soularenaChallenge).hint("Go to the section of soul arena for challenges. (Who knows what reward you may get after winning any of the challenges there...)");
	if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) addButton(10, "Ignis", ignisarenaseer.mainIgnisMenu);
	addButton(14, "Back", riverislandVillageStuff);
	statScreenRefresh();
}

public function soularenaSolo():void {
	clearOutput();
	outputText("Picking the one on the left prepared for solo fight you enter there and looking around checking who is currently avialable for sparring session.");
	menu();
	//addButton(0, "Goblin", );//Goblinka
	addButton(5, "D.Golem", dummygolem);
	addButton(6, "I.D.Golem", improveddummygolem);
	addButton(7, "A.D.Golem", advanceddummygolem);
	addButton(8, "S.D.Golem", superiordummygolem);
	addButton(10, "B.T.Golem", basictruegolem);
	addButton(11, "I.T.Golem", improvedtruegolem);
	addButton(12, "A.T.Golem", advancedtruegolem);
	addButton(14, "Back", soularena);
}

public function soularenaGroup():void {
	clearOutput();
	outputText("Picking the one on the right prepared for group fight you enter there and looking around checking who is currently avialable for sparring session.");
	menu();
	//addButton(0, "Goblins", );//Córki goblinki z solo areny ^^
	addButton(5, "D.Golems", dummygolems);
	addButton(6, "I.D.Golems", improveddummygolems);
	addButton(7, "A.D.Golems", advanceddummygolems);
	addButton(8, "S.D.Golems", superiordummygolems);
	addButton(10, "B.T.Golems", basictruegolems);
	addButton(11, "I.T.Golems", improvedtruegolems);
	addButton(12, "A.T.Golems", advancedtruegolems);
	addButton(14, "Back", soularena);
}

public function soularenaChallenge():void {
	clearOutput();
	outputText("Picking the one in the middle prepared for challanges you enter there and looking around checking who if there is currently anyone up for a challange.");
	menu();
	addButton(0, "Gaunlet 1", gaunletchallange1fight1).hint("Fight 3 diff enemies one after another.");
	//if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] == 1) addButton(1, "Gaunlet 2", gaunletchallange2).hint("Fight 3 diff enemies one after another.");
	//addButton(2, "Gaunlet 3", gaunletchallange3).hint("Fight 3 diff enemies one after another.");
	//addButton(3, "Gaunlet 4", gaunletchallange4).hint("Fight 3 diff enemies one after another.");
	//addButton(4, "Gaunlet 5", gaunletchallange5).hint("Fight 3 diff enemies one after another.");
	//addButton(5, "Golemancer", golemancer);
	addButton(10, "LvL 33 Golems", basicgolems);
	addButton(11, "LvL 42 Golems", improvedgolems);
	addButton(12, "LvL 51 Golems", advancedgolems);
	addButton(14, "Back", soularena);
}

public function dummygolem():void {
	startCombat(new GolemDummy());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function improveddummygolem():void {
	startCombat(new GolemDummyImproved());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function advanceddummygolem():void {
	startCombat(new GolemDummyAdvanced());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function superiordummygolem():void {
	startCombat(new GolemDummySuperior());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function basictruegolem():void {
	startCombat(new GolemTrueBasic());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function improvedtruegolem():void {
	startCombat(new GolemTrueImproved());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function advancedtruegolem():void {
	startCombat(new GolemTrueAdvanced());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function dummygolems():void {
	startCombat(new GolemsDummy());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function improveddummygolems():void {
	startCombat(new GolemsDummyImproved());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function advanceddummygolems():void {
	startCombat(new GolemsDummyAdvanced());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function superiordummygolems():void {
	startCombat(new GolemsDummySuperior());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function basictruegolems():void {
	startCombat(new GolemsTrueBasic());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function improvedtruegolems():void {
	startCombat(new GolemsTrueImproved());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function advancedtruegolems():void {
	startCombat(new GolemsTrueAdvanced());
	monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	monster.XP = Math.round(monster.XP / 2);
}

public function gaunletchallange1fight1():void {
	clearOutput();
	outputText("Soon will be some more or less fancy text here.");
	player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
	startCombat(new GolemsDummy());
}
public function gaunletchallange1fight2():void {
	clearOutput();
	outputText("WIP TEXT. ");
	startCombat(new TentacleBeast());
}
public function gaunletchallange1fight3():void {
	clearOutput();
	outputText("WIP TEXT. ");
	startCombat(new DarkElfScout());
}
public function gaunletchallange1postfight():void {
	clearOutput();
	outputText("WIP TEXT. ");
	if (flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] >= 1) {
		flags[kFLAGS.SPIRIT_STONES] += 20;
		cleanupAfterCombat();
	}
	else {
		flags[kFLAGS.SOUL_ARENA_FINISHED_GAUNLETS] = 1;
		inventory.takeItem(weaponsrange.BOWGUID, cleanupAfterCombat);
	}
}

public function golemancer():void {
	outputText("Not yet finished fight with sometimes showing up blank screen bug I will later on squish. But I don't want to disable whole fight for now from tests due to this.");
	startCombat(new Jeniffer());
}

public function basicgolems():void {
	startCombat(new GolemsBasic());
}

public function improvedgolems():void {
	startCombat(new GolemsImproved());
}

public function advancedgolems():void {
	startCombat(new GolemsAdvanced());
}



}
}