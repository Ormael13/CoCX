/**
 * ...
 * @author Ormael
 *
 * Simple village for soul cultivators He'Xin'Dao - River Island
 */

package classes.Scenes.Places {

import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.HellHound;
import classes.Scenes.Areas.Swamp.CorruptedDrider;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.Crafting;
import classes.Scenes.Dungeons.D3.MinotaurKing;
import classes.Scenes.Dungeons.HiddenCave.BossGolems;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.Jinx;
import classes.Scenes.Places.HeXinDao.*;
import classes.Scenes.SceneLib;
import classes.Scenes.API.MultiBuy;

public class HeXinDao extends BaseContent
{
    public var ignisarenaseer:IgnisArenaSeerScene = new IgnisArenaSeerScene();
    public var riverdungeon:RiverDungeon = new RiverDungeon();
	public var eraendirorsbulg:EraendirAndOrsbulg = new EraendirAndOrsbulg();

    public function HeXinDao() {}

	public function riverislandVillageStuff0():void {
		spriteSelect(null);
        clearOutput();
		if (isLunarNewYear()) {
			outputText("As you enter the town you notice that the streets are covered with decorations. Bright red drapes hang off almost every building, yellow paper lanterns dangle from lines tossed between the buildings, and simple stalls have been set up, selling festively colored trinkets. A parade winds through the streets, with a giant snake-like Muppet at the center of it. He’Xin’Dao is in the middle of a massive festival. Would you like to join in?");
			menu();
			addButton(1, "Maybe later", riverislandVillageStuff1);
			addButton(3, "Sure!", riverislandVillageStuffLunar);
		}
		else riverislandVillageStuff();
	}
	public function riverislandVillageStuff1():void {
		outputText("\n\nYou aren’t here today for a festival. Maybe you will attend tomorrow.\n\n");
		doNext(riverislandVillageStuff);
	}
	public function riverislandVillageStuffLunar():void {
		clearOutput();
        var zodiacName:Array = ["monkey", "rooster", "dog", "pig", "rat", "ox", "tiger", "rabbit", "dragon", "snake", "horse", "goat"];
		flags[kFLAGS.LUNAR_NEW_YEAR] = date.fullYear%12;
        flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] = zodiacName[int(flags[kFLAGS.LUNAR_NEW_YEAR])];
        outputText("You go deeper in, and the crimson banners never seem to end. The entire town is decked out for the festival. What should you check out first?");
		awardAchievement("Year of the Goat", kACHIEVEMENTS.HOLIDAY_YEAR_OF_THE_GOAT);
		menu();
		if (!player.hasStatusEffect(StatusEffects.CanGetLunarGift)) addButton(0, "Gifts", riverislandVillageStuffLunarGifts);
		addButton(1, "Food", riverislandVillageStuffLunarFood);
		addButton(2, "Clothing", riverislandVillageStuffLunarClothing);
		if (model.time.hours > 19) addButton(3, "Fireworks", riverislandVillageStuffLunarFireworks);
		else addButtonDisabled(3, "Fireworks", "You need to wait till 8 PM for that.");
		if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 20 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 2 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && !SceneLib.chichiScene.ChiChiKickedOut && model.time.hours > 17) addButton(4, "Chi Chi", riverislandVillageStuffLunarChiChi);
		else addButtonDisabled(4, "Chi Chi", "You need to wait until it's 6 PM or later for that.");
		addButton(14, "Back", riverislandVillageStuff1).hint("Leave the festival.");
	}
	public function riverislandVillageStuffLunarGifts():void {
		clearOutput();
		outputText("There seems to be a gift exchange going around. Some people are handing over red envelopes, something about luck for the coming year. A wizened old " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + "-morph hands you one, giving you a smile before vanishing into the crowd. You open the envelope and... ");
		var SpiritStones:Number = 50;
		SpiritStones += rand(100);
		outputText("Wow! You were lucky! There was " + SpiritStones + " spirit stones inside! Good fortune for you!");
		player.createStatusEffect(StatusEffects.CanGetLunarGift,0,0,0,0);
		flags[kFLAGS.SPIRIT_STONES] += SpiritStones;
		statScreenRefresh();
		doNext(riverislandVillageStuffLunar);
	}
	public function riverislandVillageStuffLunarFood():void {
		clearOutput();
		outputText("The local restaurant seems to be offering some local specialties, and best of all; it's free! Some " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + "-morphs are serving the meal. You proceed to grab a plate of these strange ravioli the people calls jiǎozi, taking the rice dessert they call niángāo right after. The meal is comforting. For a moment, you could believe everything in Mareth was going fine... Until you look up, into the red sky, clouds roiling above the festival.");
		player.refillHunger(50);
		advanceMinutes(30);
		doNext(riverislandVillageStuffLunar);
	}
	public function riverislandVillageStuffLunarClothing():void {
		clearOutput();
		outputText("As you take a corner you spot a " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + " girl working at what appears to be a festive clothing store.");
		outputText("\n\n\"<i>Come over people! Look the part! Buy a dress for the festivities only for 10 spirit stones! There's only a few left, so buy now!</i>\"");
		outputText("\n\nDo you buy one from the " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + " girl?");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(1, "Yes", riverislandVillageStuffLunarClothing2);
		else addButtonDisabled(1, "Yes", "You don't have enough spirit stones to buy anything here");
		addButton(3, "No", riverislandVillageStuffLunar);
	}
	public function riverislandVillageStuffLunarClothing2():void {
		outputText("\n\n\"<i>Which color would you want your dress to be?</i>\"");
		menu();
		addButton(0, armors.R_CHANG.shortName, dressBuy, armors.R_CHANG);
		addButton(1, armors.G_CHANG.shortName, dressBuy, armors.G_CHANG);
		addButton(2, armors.B_CHANG.shortName, dressBuy, armors.B_CHANG);
		addButton(3, armors.P_CHANG.shortName, dressBuy, armors.P_CHANG);
		addButton(5, armors.R_QIPAO.shortName, dressBuy, armors.R_QIPAO);
		addButton(6, armors.G_QIPAO.shortName, dressBuy, armors.G_QIPAO);
		addButton(7, armors.B_QIPAO.shortName, dressBuy, armors.B_QIPAO);
		addButton(8, armors.P_QIPAO.shortName, dressBuy, armors.P_QIPAO);
		addButton(14, "Back", riverislandVillageStuff);
	}
	private function dressBuy(itype:ItemType):void {
        clearOutput();
        outputText("She hands you the dress after taking your gems.");
		outputText("\n\n\"<i>Happy year of the " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + ", I wish you great luck!</i>\"");
		outputText("\n\nYou put the dress in your bag for now. Now to put it on.");
		outputText("\n\n<b>You got a Lunar new year dress.</b>\n\n");
		flags[kFLAGS.SPIRIT_STONES] -= 10;
		cheatTime(1/3);
        inventory.takeItem(itype, riverislandVillageStuffLunar);
    }
	public function riverislandVillageStuffLunarFireworks():void {
		clearOutput();
		outputText("There are some extravagantly beautiful fireworks exploding in the sky above town. Red rockets are regularly shot up, exploding in bright flashes. You chuckle inside pondering what would happen if some harpy were to fly into one of those fireworks… would it become roasted chicken? Speaking of chickens, a few imps drop dead from the sky. They must've got a little too close to the explosion and got caught in the blast. A few citizens groan, picking up the bodies and tossing them out of town.");
		doNext(camp.returnToCampUseFourHours);
	}
	public function riverislandVillageStuffLunarChiChi():void {
		clearOutput();
		outputText("To your surprise, you see Chi Chi in the crowd wearing a traditional kimono. The hinezumi notices you right away, waving you over.");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 3) {
			outputText("\n\n\"<i>Come over people! Look the part! Buy a dress for the festivities only for 50 gems! C'mon and buy while there's some left!</i>\"");
			outputText("\n\nYou put the dress in your bag for now. Now to put it on.");
		}
		else if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && !SceneLib.chichiScene.ChiChiKickedOut) {
			outputText("\n\n\"<i>Hey, Baka! I thought you'd never join in. I waited for you here all day, you know! Sit next to me and hold my hand, I want the folks out there to know we're together.</i>\"");
			outputText("\n\nTogether as in a couple? Is she opening up or something? Your comment makes her light red cheeks even redder.");
			outputText("\n\n\"<i>N..no! Nothing of the sort! I don't care if all the other girls look at you right now. I’m just preventing you from flirting with half of the women in town!</i>\"");
			outputText("\n\nYou spend several hours watching the fireworks. Eventually Chi Chi asks you something.");
			outputText("\n\n\"<i>Say [name] if.. if the two of us were a couple... would you kiss me right now?</i>\"");
			outputText("\n\nYou sure would, why?");
			outputText("\n\n\"<i>Well w..would you please kiss me, then? I..it's not like I'm really desperate for one but...</i>\"");
			outputText("\n\nYou proceed to shut the blushing fire-mouse up, taking hold of her mouth and pulling her in for a deep kiss. Her eyes opens wide in surprise before she gives herself up to you fully, her arms wrapping around you in a tight embrace.");
			outputText("\n\nYou both break the kiss a few seconds later, Chi Chi redder than a canine pepper.");
			outputText("\n\n\"<i>T..That was nice. Don’t you dare tell anyone in camp we did that though.</i>\"");
			outputText("\n\nYeah, sure, whatever she says. You spend a little more time with her before returning to camp.");
		}
		else {
			outputText("\n\n\"<i>Oh it's you? Did you come to train? Sorry, but I'm taking a break today. It's the Lunar festival and this event only happens once a year. How about we share a cup of tea and watch the fireworks? You could use a break too, ya know?</i>\""); //WTF? Sake? What is this, Japan? Yes
			outputText("\n\nYou share tea, food and jokes all night long while watching the fireworks. It's only when it gets very late that you bid her farewell and head back to camp.");
		}
		doNext(camp.returnToCampUseSixHours);
	}

    public function riverislandVillageStuff():void {
        spriteSelect(null);
        clearOutput();
        outputText("He'Xin'Dao is a large village connected and assembled between many smaller islands in the middle of large river that flows from the east to the west. In addition to the bridges connecting each of the islands together, two larger bridges connects them as a whole to both sides of the river, serving as the only points of access to the village.  The village is strategically laid out, preventing anyone from entering by swimming directly from the river to any of the islands, forcing anyone who can't fly to use the bridges if they wish to enter.\n\n");
        outputText("Near one of major bridges is a wide variety of shops, ranging from a few shops with vicious-looking weapons, to one shop with a goblin out front, hawking what appears to be golem-making materials. On the opposite side of village, near other bridge is a medium-sized shop with a large \"Currency Transfer\" sign. A market chock-full of seemingly random items is in the same building, and as you get closer, you recognize several transformative items from your travels in this realm.");
        outputText("\n\nAt the West end of He'Xin'Dao you see one of the biggest buildings here. The roar of a crowd rises up from it occasionally, and when you listen close, you can hear the rasping of blades, and various other sounds of combat. You assume it's a local arena.");	//Side question, why can't the ones with wings fly in? Answered: Because flying cultivators would kick their asses.
        outputText("You notice several towers, positioned at central points on some of the larger islands. These hardy-looking wood and stone constructions have open, flat roofs, and several people perch on each.\n\n");
		outputText("At first glance these people seem random. Some wield bows, others daggers, a few with no weapons at all... But as you focus on them, you can <i> feel </i> their soulforce, almost reacting to your attention.\n\n");
		outputText("As you look even closer into the sky, you see a few glints of light, something metal in the sky reflecting the sun's rays. Are those...people riding on flying swords?\n\n");
		//outputText("\n.");	//Z czasem jak bede dodawac miejsca opis wioski bedzie rozbudowywany :P
        riverislandMenuShow();
    }

    public function riverislandMenuShow():void {
        menu();
        addButton(0, "Merchant", golemmerchant);
        addButton(1, "TFspec/Exch", mogahenmerchant);
        addButton(2, "SoulEquip", serenamerchant);
        addButton(3, "SoulArrow", ermaswiftarrowmerchant);
		addButton(4, "FSAAWY", qimerchant).hint("Flying Swords are always with you!");
		//addButton(5, "", ); siedziba lokalnej grupy zrzeszającej soul cultivators - PC aby potem pojsc dalej bedzie musial dolaczyc tutaj (pomyslec nad wiarygodnym sposobem zmuszenia go do tego - moze jakies ciekawe itemy/inne rzeczy dla czlonkow beda a miejsce sie zwolni jak wywala tak goblinke tworzynie golemow, ktora potem oczywiscie wcisnie sie do obozu PC aby w spokoju rozwijac sie w tworzeniu golemow itp.)
        addButton(6, "JourTTEast", SceneLib.journeyToTheEast.enteringInn);
        addButton(7, "Arena", soularena);
        addButton(8, "Restaurant", restaurantShiraOfTheEast);
		if (flags[kFLAGS.NEISA_FOLLOWER] == 0) addButton(9, "Dungeon", entranceToRiverDungeon);
		else {
			if (player.companionsInPCParty()) addButton(9, "Dungeon", entranceToRiverDungeon);
			else addButtonDisabled(9, "Dungeon", "You need to find some backup if you wish to enter!");
		}
        addButton(10, "Eraendir", eraendirorsbulg.EraendirMainMenu);
		addButton(11, "Orsbulg", eraendirorsbulg.OrsbulgMainMenu);
		addButton(12, "Golemancer", golemancershop);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 20 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 2 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && !SceneLib.chichiScene.ChiChiKickedOut) addButton(13, "Chi Chi", SceneLib.chichiScene.MeetingChiChiInHeXinDao);
        addButton(14, "Leave", camp.returnToCampUseOneHour);
    }
    public function golemmerchant():void {
        clearOutput();
        outputText("You enter a shop titled 'Soul Items' from the sign on its entrance. Inside you see a few shelves with many different items on display.  It doesn't seem like this merchant has a wide choice of things to sell, but for someone at the beginning of their soul cultivation path, it's probably enough.  Sensing motion from a corner of the shop permanently covered in darkness, a person appears without making a sound.  'He' is around five feet tall, and looks like some kind of demonic monster.");
        if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) outputText(" But he does look quite similar to the gargoyle from the cathedral.");
        outputText("\n\n\"<i>Welcome to my master's shop, dear customer. Feel free to look around,</i>\" he says.\n\n");
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOBLINS);
        menu();
        var buyItem1:Function = curry(confirmBuy1,golemmerchant,"Golem",1);
        var buyItem2:Function = curry(confirmBuy2,golemmerchant,"Golem",0.2);
        var introText:String = "\"When you reach towards one of the items on the display, the golem says, \"<i>";
        var costText:String = " Interested?</i>";
        var endText1:String = " gems</b></i>.\"";
        var endText2:String = " spirit stones</b></i>.\"";
        function sayLine1(itype:ItemType,desc:String):String{
            return introText+desc+costText;
        }
        function sayLine2(itype:ItemType,desc:String):String{
            return introText+desc+costText;
        }
		addButton(0, "1st Stall", Tier0).hint("Check out the first stall. This shop sells recovery items, for beginning soul cultivators.");
		addButton(1, "2nd Stall", TierI).hint("Check out the second stall. This shop sells common items, for beginning soul cultivators.");
        if (player.hasPerk(PerkLib.SoulApprentice)) addButton(2, "3rd Stall", TierII).hint("Check out the third stall. This sells items for Soul Apprentices, Soul Personage and Soul Warrior stage cultivators.");
		else addButtonDisabled(2, "3rd Stall", "You need to be at least a Soul Apprentice to check those items.");
        if (player.hasPerk(PerkLib.SoulSprite)) addButton(3, "4th Stall", TierIII).hint("Check out the fourth stall. This stall sells items for Soul Sprites, Soul Scholars and Soul Elder stage cultivators.");
		else addButtonDisabled(3, "4th Stall", "You need to be at least a Soul Sprite to check those items.");

        var hasSoulCultivator:Boolean = player.hasPerk(PerkLib.JobSoulCultivator);
        var hasSoulPersonage:Boolean = player.hasPerk(PerkLib.SoulPersonage);
        var hasSoulSprite:Boolean = player.hasPerk(PerkLib.SoulSprite);
        var hasSoulExalt:Boolean = player.hasPerk(PerkLib.SoulExalt);
        var hasSoulKing:Boolean = player.hasPerk(PerkLib.SoulKing);

        function Tier0():void{
            buyItem1 = curry(MultiBuy.confirmBuyMulti,Tier0,"Golem",1);
            buyItem2 = curry(MultiBuy.confirmBuyMulti,Tier0,"Golem",5);
            menu();
            addButton(0, "LowSFRPill", curry(buyItem2,consumables.LG_SFRP), sayLine2(consumables.LG_SFRP,"It's a useful item for any soul cultivator, this little pill can help you restore some of your soulforce. Unless you don't have a soul."),"\n", true).hint("Low-grade Soulforce Recovery Pill.");
            addButton(1, "MidSFRPill", curry(buyItem2,consumables.MG_SFRP), sayLine2(consumables.MG_SFRP,"It's a rather useful item for all cultivators at Soul Sprite stage or higher, this small pill can help you restore some of your soulforce and would provide much more than the low-grade one."),"\n", true).hint("Mid-grade Soulforce Recovery Pill.").disableIf(!hasSoulPersonage);
            addButton(2, "HighSFRPil", curry(buyItem2,consumables.HG_SFRP), sayLine2(consumables.HG_SFRP,"It's a rather useful item. I sell this to all cultivators at Soul Exalt stage or higher, this small pill can help you restore some of your soulforce and would provide much more than the mid-grade one."),"\n", true).hint("High-grade Soulforce Recovery Pill.").disableIf(!hasSoulExalt);
            addButton(3, "SupSFRPill", curry(buyItem2,consumables.SG_SFRP), sayLine2(consumables.SG_SFRP,"It's a rather useful item. I sell this to all cultivators at Soul King stage or higher, this small pill can help you restore some of your soulforce and would provide much more than the high-grade one."),"\n", true).hint("Superior-grade Soulforce Recovery Pill.").disableIf(!hasSoulKing);
            addButton(5, "LowSFRBotl", curry(buyItem2,consumables.LGSFRPB), sayLine2(consumables.LGSFRPB,"It's a useful item for any soul cultivator, the pills in this bottle can help you restore some of your soulforce. Unless you don't have a soul."),"\n", true).hint("Bottle of Low-grade Soulforce Recovery Pills.")
            addButton(6, "MidSFRBotl", curry(buyItem2,consumables.MGSFRPB), sayLine2(consumables.MGSFRPB,"It's a rather useful item for all cultivators at Soul Sprite stage or higher, this bottle of pills can help you restore some of your soulforce and would provide much more than the low-grade one."),"\n", true).hint("Bottle of Mid-grade Soulforce Recovery Pills.").disableIf(!hasSoulPersonage);
            addButton(7, "HighSFRBot", curry(buyItem2,consumables.HGSFRPB), sayLine2(consumables.HGSFRPB,"It's a rather useful item. I sell this to all cultivators at Soul Exalt stage or higher, this bottle of pills can help you restore some of your soulforce and would provide much more than the mid-grade one."),"\n", true).hint("Bottle of High-grade Soulforce Recovery Pill.").disableIf(!hasSoulExalt);
            addButton(8, "SupSFRBotl", curry(buyItem2,consumables.SGSFRPB), sayLine2(consumables.SGSFRPB,"It's a rather useful item. I sell this to all cultivators at Soul King stage or higher, this bottle of pills can help you restore some of your soulforce and would provide much more than the high-grade one."),"\n", true).hint("Bottle of Superior-grade Soulforce Recovery Pill.").disableIf(!hasSoulKing);
            addButton(10, "E.P.Bottle", curry(buyItem2,useables.E_P_BOT), sayLine2(useables.E_P_BOT,"These bottles can be used to organize SoulForce pills. Due to the nature of the pills, they must be consumed shortly after opening the bottle, or it won't work. Some cultivators have theorized on the properties of the pills for a long time, but no definitive answer has been reached."),"\n", true).hint("Empty Pill Bottle.");
            addButton(14, "Back", golemmerchant);
            statScreenRefresh();
        }
        function TierI():void {
            buyItem1 = curry(MultiBuy.confirmBuyMulti,TierI,"Golem",1);
            buyItem2 = curry(MultiBuy.confirmBuyMulti,TierI,"Golem",5);
			menu();
            addButton(2, "Bag of Cosmos", curry(buyItem2,consumables.BAGOCOS), sayLine2(consumables.BAGOCOS,"A quintessential item for all soul cultivators, this little bag is dimensionally transcendental, that is, it's bigger on the inside. "),"\n", true).hint("Bag of Cosmos.");
			addButton(3, "BT.Solution", curry(buyItem2,useables.BTSOLUTION), sayLine2(useables.BTSOLUTION,"This vial contain solution commonly used by body cultivators. In case of anyone else trying to ingest this fluid it raged from sever ingestion to death."),"\n", true).hint("Vial of Body Tempering Solution.");
			addButton(4, "Fasting Pill", curry(buyItem2,consumables.FATPILL), sayLine2(consumables.FATPILL,"It's a rather useful item for soul cultivators, this little pill can help you stave off hunger for a few days."),"\n", true).hint("Fasting Pill.").disableIf(flags[kFLAGS.HUNGER_ENABLED] == 0);
            addButton(5, "Triple Thrust", curry(buyItem2,consumables.TRITMAN), sayLine2(consumables.TRITMAN,"It's a manual for Triple Thrust. This very simple technique allows you to unleash three thrusts that will become stronger and stronger as you train your body and soul."), "\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  It seems like even the name of the manual could have been influenced by this realm's nature... either that or it's just a coincidence.",true).hint("Triple Thrust Manual.").disableIf(!hasSoulCultivator);
            addButton(6, "Draco Sweep", curry(buyItem2,consumables.DRASMAN), sayLine2(consumables.DRASMAN,"It's a manual for Draco Sweep. This simple technique allows you to unleash an attack that would strike in wide arc before you, perfect for when you are fighting a group of enemies. It also becomes more powerful as long you train your body and soul."), "\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to use when fighting a group of enemies.  You don't often meet more than one enemy at a time, but you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  ", true).hint("Draco Sweep Manual.").disableIf(!hasSoulCultivator);
            addButton(7, "Many Birds", curry(buyItem2,consumables.MABIMAN), sayLine2(consumables.MABIMAN,"It's a manual for Many Birds. This simple technique allows you to project a figment of your soulforce as a crystal, firing it at extreme speeds. As you train your body and soul, this skill will become stronger."), "\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you are not certain.  ", true).hint("Many Birds Manual.").disableIf(!hasSoulCultivator);
            addButton(8, "Hail of Blades", curry(buyItem2,consumables.HOB1MAN), sayLine2(consumables.HOB1MAN,"It's a manual for Hail of Blades. This simple technique allows you to form several etheral weapons, then launch them at extreme speeds. As you train your body and soul, this skill will become stronger."), "\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you are not certain.  ", true).hint("Hail of Blades Manual.").disableIf(!hasSoulCultivator);
			addButton(9, "Create E (B)", curry(buyItem2,consumables.CEB_MAN), sayLine2(consumables.CEB_MAN,"It's a manual for Create Element (Basic). This very simple technique allows you to unleash ball of basic element (fire, water, air, earth)."), "\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  It seems like the name of the manual wasn't influenced by this realm's nature... either that or it's just a coincidence.", true).hint("Create Element (Basic).").disableIf(!hasSoulCultivator);
            addButton(10, "FlamesOfLove", curry(buyItem1,consumables.FOLBMAN), sayLine1(consumables.FOLBMAN,"It's a manual for Flames of Love (Rankless), this simple technique allows you to convert excess lust into flames."), "\n\nIt seems like some sort of art to deal with needless lust by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  ").hint("Flames of Love (Rankless) Manual.");
			addButton(11, "IciclesOfLove", curry(buyItem1,consumables.IOLBMAN), sayLine1(consumables.IOLBMAN,"It's a manual for Icicles of Love (Rankless), this simple technique allows you to covert excess lust into icicles."), "\n\nIt seems like some sort of art to deal with needless lust by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  ").hint("Icicles of Love (Rankless) Manual.");
			addButton(12, "SoSisterhood", curry(buyItem1,consumables.SOSBMAN), sayLine1(consumables.SOSBMAN,"It's a manual for Storm of Sisterhood (Rankless), this simple technique allows you to convert excess wrath into lightning."), "\n\nIt seems like some sort of art to deal with needless wrath by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  ").hint("Storm of Sisterhood (Rankless) Manual.");
			addButton(13, "NoBrotherhood", curry(buyItem1,consumables.NOBBMAN), sayLine1(consumables.NOBBMAN,"It's a manual for Night of Brotherhood (Rankless), this simple technique allows you to covert excess wrath into darkness."), "\n\nIt seems like some sort of art to deal with needless wrath by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  ").hint("Night of Brotherhood (Rankless) Manual.");
			addButton(14, "Back", golemmerchant);
            statScreenRefresh();
		}
		function TierII():void {
            buyItem1 = curry(MultiBuy.confirmBuyMulti,TierII,"Golem",1);
            buyItem2 = curry(MultiBuy.confirmBuyMulti,TierII,"Golem",5);
			menu();
            addButton(5, "Comet", curry(buyItem2,consumables.COMETMA),sayLine2(consumables.COMETMA,"It's a manual for Comet, this technique allows you to project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.  Perfect for when you are fighting groups of enemies, it also becomes more powerful as long as you keep training your body and soul."),"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to use when fighting groups of enemies.  You don't often meet more than one enemy at at a time, but you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once. Best to be prepared.\n", true).hint("Comet Manual.");
			addButton(6, "V P Trans", curry(buyItem2,consumables.VPTRMAN),sayLine2(consumables.VPTRMAN,"It's a manual for Violet Pupil Transformation, this advanced technique allows you to channel soulforce into regenerative power, allowing you to recover even from the brink of death.  Its only flaw is that it constantly drains the cultivator's soulforce. "),"\n\nIt seems like it's similar to a healing spell soul skill, but instead of being used immediately, with enough soulforce it could be kept active for a very long period of time.  It could give you an edge against the demons.  Additionally, the ability to heal from the brink of death could prove to be useful in future fights.\n", true).hint("Violet Pupil Transformation Manual.");
            addButton(7, "Sextuple Thrust", curry(buyItem2,consumables.SEXTMAN), sayLine2(consumables.SEXTMAN,"It's a manual for Sextuple Thrust, this simple technique allows you to unleash six thrusts. As you train your body and soul, this skill will become stronger."), "\n\nWhether you are going to go deeper into all that 'soulforce' stuff or not, at least you now have something to train with. The name of the manual seems like it could have been influenced by this realm...or it's just a coincidence.\n", true).hint("Sextuple Thrust Manual.").disableIf(!hasSoulPersonage);
            addButton(8, "Grandiose HoB", curry(buyItem2,consumables.HOB2MAN), sayLine2(consumables.HOB2MAN,"It's a manual for Grandiose Hail of Blades, this technique allows you to form many etheral weapons traveling at extreme speeds. As you train your body and soul, this skill will become stronger."), "\n\nWhether you are going to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you not certain.\n", true).hint("Grandiose Hail of Blades Manual.").disableIf(!hasSoulSprite);
			addButton(9, "Create E (A)", curry(buyItem2,consumables.CEA_MAN),sayLine2(consumables.CEA_MAN,"It's a manual for Create Element (Advanced), this technique allows you to unleash ball of advanced element (ice, lightning, darkness), it also becomes more powerful as long as you keep training your body and soul."),"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to use when enemies resistant to more basic elements. Best to be prepared.\n", true).hint("Create Element (Advanced).");
			addButton(14, "Back", golemmerchant);
            statScreenRefresh();
		}
		function TierIII():void {
            buyItem1 = curry(MultiBuy.confirmBuyMulti,TierIII,"Golem",1);
            buyItem2 = curry(MultiBuy.confirmBuyMulti,TierIII,"Golem",5);
			menu();
			addButton(0, "Nonuple Thrust", curry(buyItem2,consumables.NONTMAN), sayLine2(consumables.NONTMAN,"It's a manual for Nonuple Thrust, this technique allows you to unleash nine thrusts. As you train your body and soul. "), "\n\nSince you are going deeper into soulforce, you got something more advanced to train with.  The name of the manual seems like it could have been influenced by this realm...or it's just a coincidence.  ", true).hint("Nonuple Thrust Manual.").disableIf(!hasSoulSprite);
			addButton(1, "GHoMB", curry(buyItem2,consumables.HOB3MAN), sayLine2(consumables.HOB3MAN,"It's a manual for Grandiose Hail of Moon Blades, this technique allows you to form a huge amount of etheral weapons traveling at extreme speeds. As you train your body and soul, this skill will become stronger."), "\n\nSince you are going deeper into soulforce, you got something more advanced to train with.  The name of the manual is strange, but it makes you remember something...but what and from where you not certain.  ", true).hint("Grandiose Hail of Moon Blades Manual.").disableIf(!hasSoulSprite);
			/*addButton(2, "Yin Yang Blast", buyItem2,consumables.YYB_MAN,
					sayLine2(consumables.YYB_MAN,"It's a manual for Yin Yang Blast, this technique allows you to combine Yin Palm and Yang Fist into a single attack."),
					"\n\nSince you going deeper into all that 'soulforce' stuff, now you .  Maybe there is some more of those 'combined' soulskills somewhere?  "
			).hint("Yin Yang Blast Manual.").disableIf(!hasSoulPersonage);*/
			addButton(14, "Back", golemmerchant);
            statScreenRefresh();
      }/*
      if (player.hasPerk(PerkLib.SoulExalt)) { lub soul overlord - each soul stage above starting allow to extend channeling time by 1 round
        addButton(1, "GHoMB", buyItem2,consumables.HOB4MAN,
            sayLine2(consumables.HOB4MAN,"It's a manual for Grandiose Hail of Moon Blades, this technique allows you to form a simply massive amount of etheral weapons, sending them at your foe with extreme speed. As you train your body and soul, this skill will become stronger. "),
            "\n\nYou've already gone this far into Soulforce, so why not? A 'few' more weapons formed will not hurt at this point, right?  "
        ).hint("Grandiose Heavenly Hail of Yin-Yang Blades: Endless Tide Manual.");
      }*/
		addButton(10, "Alch.Tools", alchemyTools).hint("Check out alchemy equipment.");
		addButton(13, "IncenOfInsig", buyItem1,consumables.INCOINS, sayLine1(consumables.INCOINS,"These incenses are useful. They will grant you visions for a short moment while meditating. This should help you find the wisdom and insight you need.")).hint("Incense of Insight.");
		addButton(14, "Back", riverislandVillageStuff);

        statScreenRefresh();
    }
	private function alchemyTools():void {
		clearOutput();
		outputText("You check out the stall with the alchemic equipment. It seems that only most basic tools are present - if you need higher quality devies, you need to look somewhere else.");
		outputText("\n\n");
		outputText("<b>You have ")
		if (Crafting.alembicLevel == 0 && Crafting.furnaceLevel == 0) {
			outputText("no alchemical equipment in your camp.</b>")
		} else {
			if (Crafting.alembicLevel > 0) {
				outputText(SceneLib.crafting.alchemyExtraction.alembicName());
				if (Crafting.furnaceLevel > 0) outputText(" and ");
			}
			if (Crafting.furnaceLevel > 0) {
				outputText(SceneLib.crafting.mutagenPillCrafting.furnaceName());
			}
			outputText(" in your camp.</b>")
		}

		function buyAlembic(tier:int, priceGems:int):void {
			Crafting.alembicLevel = tier;
			player.gems -= priceGems;
			outputText("\n\n<b>"+capitalizeFirstLetter(Crafting.ALEMBIC_LEVELS[tier].name)+" purchased!</b>");
			statScreenRefresh();
			doNext(alchemyTools);
		}
		function buyFurnace(tier:int, priceGems:int):void {
			Crafting.furnaceLevel = tier;
			player.gems -= priceGems;
			outputText("\n\n<b>"+capitalizeFirstLetter(Crafting.FURNACE_LEVELS[tier].name)+" purchased!</b>");
			statScreenRefresh();
			doNext(alchemyTools);
		}

		menu();
		button(0).show("Alembic I", curry(buyAlembic, Crafting.ALEMBIC_LEVEL_SIMPLE, Crafting.ALEMBIC_LEVELS[Crafting.ALEMBIC_LEVEL_SIMPLE].value))
				 .hint("Buy a simple alembic to refine substances from ingredients.\n\nCost: "+Crafting.ALEMBIC_LEVELS[Crafting.ALEMBIC_LEVEL_SIMPLE].value+" gems.")
				.disableIf(player.gems < Crafting.ALEMBIC_LEVELS[Crafting.ALEMBIC_LEVEL_SIMPLE].value, "++\n\n<b>Not enough gems!</b>")
				.disableIf(Crafting.alembicLevel >= Crafting.ALEMBIC_LEVEL_SIMPLE, "++\n\n<b>You don't need that!</b>")
		;
		button(1).show("Furnace I", curry(buyFurnace, Crafting.FURNACE_LEVEL_SIMPLE, Crafting.FURNACE_LEVELS[Crafting.FURNACE_LEVEL_SIMPLE].value))
				 .hint("Buy a simple alchemic furnace to combine substances into pills.\n\nCost: "+Crafting.FURNACE_LEVELS[Crafting.FURNACE_LEVEL_SIMPLE].value+" gems.")
				.disableIf(player.gems < Crafting.FURNACE_LEVELS[Crafting.FURNACE_LEVEL_SIMPLE].value)
				 .disableIf(Crafting.furnaceLevel >= Crafting.FURNACE_LEVEL_SIMPLE, "++\n\n<b>You don't need that!</b>");
		button(14).show("Back", golemmerchant);
	}
    private function debitItem1(returnFunc:Function,shopKeep:String,priceRate:int,itype:ItemType,onBuy:String):void{
        var value:int = itype.value * priceRate;
        if (player.gems < value) {
            clearOutput();
            outputText("\n\n"+shopKeep+" shakes his head, indicating you need " + String(value - player.gems) + " more gems to purchase this item.");
            doNext(returnFunc);
        }
        else {
            player.gems -= value;
            outputText(onBuy);
            inventory.takeItem(itype, returnFunc);
            statScreenRefresh();
        }
    }
    private function debitItem2(returnFunc:Function,shopKeep:String,priceRate:int,itype:ItemType,onBuy:String):void{
        if (flags[kFLAGS.SPIRIT_STONES] < itype.value / 5) {
            clearOutput();
            outputText("\n\n"+shopKeep+" shakes his head, indicating you need " + String(itype.value / 5 - flags[kFLAGS.SPIRIT_STONES]) + " more spirit stones to purchase this item.");
            doNext(returnFunc);
        }
        else {
            flags[kFLAGS.SPIRIT_STONES] -= itype.value / 5;
            outputText(onBuy);
            inventory.takeItem(itype, returnFunc);
            statScreenRefresh();
        }
    }


    private function confirmBuy1(returnFunc:Function,shopKeep:String,priceRate:int,itype:ItemType,descString:String,onBuyString:String="\n"):void{
        clearOutput();
        outputText(descString);
        doYesNo(curry(debitItem1,returnFunc,shopKeep,priceRate,itype,onBuyString),returnFunc);
    }
    private function confirmBuy2(returnFunc:Function,shopKeep:String,priceRate:int,itype:ItemType,descString:String,onBuyString:String="\n"):void{
        clearOutput();
        outputText(descString);
        doYesNo(curry(debitItem2,returnFunc,shopKeep,priceRate,itype,onBuyString),returnFunc);
    }

    public function mogahenmerchant():void {
        function addItemButton(btn:int, item:ItemType, desc:String, useStones:Boolean = false):void {
            var introText:String = "When you point towards one of the items on display the merchant says, \"<i>This item is used to embrace the ";
            var endText:String = " in you.  Interested?</i>\""//  It is merely <b>";
            var buyF:Function, line:String, onBuyString:String, cost:String;
            if (useStones) {
                cost = String(item.value / 5) + " spirit stones";
                buyF = curry(MultiBuy.confirmBuyMulti, mogahenmerchant, "Moga", 5, item);
            } else {
                cost = String(item.value * 3) + " gems";
                buyF = curry(MultiBuy.confirmBuyMulti, mogahenmerchant, "Moga", 3, item);
            }
            line = introText + desc + endText;// + cost + "</b></i>.\"";
            onBuyString = "\n\nAfter you give Hen a few " + (useStones ? "spirit stones" : "gems") + ", he hands you the transformative. ";
            addButton(btn, item.shortName, buyF, line, onBuyString, useStones).hint("Buy " + item.longName + ".\nCost: " + cost);
        }

        function makeItemList(items:Array, useStones:Boolean = false):void {
            menu();
            var btn:int = 0;
            for each (var slot:Array in items) addItemButton(btn++, slot[0], slot[1], useStones);
            addButton(14, "Back", mogahenmerchant);
            statScreenRefresh();
        }

        var tier1:Array = [
            [consumables.BLACKPP, "dog"],
            [consumables.BULBYPP, "dog"],
            [consumables.DBLPEPP, "dog"],
            [consumables.KNOTTYP, "dog"],
            [consumables.LARGEPP, "dog"],
            [consumables.CANINEP, "dog"],
            [consumables.ELFEARS, "elf"],
            [consumables.REPTLUM, "lizan"],
        ];
        var tier2:Array = [
            [consumables.SHARK_T, "shark"],
            [consumables.GLDRIND, "deer"],
            [consumables.KANGAFT, "kangaroo"],
            [consumables.BLADEGR, "mantis"],
            [consumables.SCORICO, "scorpion"],
            [consumables.YETICUM, "yeti"],
            [consumables.BAYRLEA, "bear"],
            [consumables.SMRTNUT, "squirrel"],
        ];
        var tier3:Array = [
            [consumables.COAL___, "horny"],
            [consumables.DRYTENT, "anemone"],
            [consumables.ECTOPLS, "ghost"],
            [consumables.TRAPOIL, "sand trap"],
            [consumables.ICICLE_, "ice shard"],
            [consumables.SDELITE, "cum hose"],
            [consumables.SSPONGE, "dryness"],
        ];
        if (sceneHunter.other) tier3.push([consumables.LBSPRAY, "wetness"]);
        var tier4:Array = [
            [consumables.SATYR_W, "satyr"],
            [consumables.DRAKHRT, "dragon"],
            [consumables.C_VEMOM, "centipede"],
            [consumables.HUMMUS_, "humanity"],
            [consumables.CHILLYP, "winter wolf"],
            [consumables.MARAFRU, "plant"],
            [consumables.SKYSEED, "avian"],
            [consumables.W_EMRLD, "kamaitachi"],
        ];
        //===================================================================

        clearOutput();
        outputText("You enter a shop titled 'Transformative Items and Exchanges'. Inside you see a few shelves with many different items on display.  Most items seem rather generic, but a few items gathered are far more difficult to come by and rarer to encounter.");
        outputText("\n\nAs you're looking over the stalls, the owner almost silently approaches you. He announces his presence by clearing his throat. You turn to face him, only to be greeted by him smiling at you like a cat that caught the mouse. After a moment of pause, he breaks the silence.");
        outputText("\n\n\"<i>Welcome to my humble shop dear and precious customer. I am Moga Hen. What needs bring you here today? To repair some damage caused by using items you casually picked up or to obtain some specific change? Or perhaps you need to exchange gems for spirit stones, mayhaps even the other way round? I can also give you a fair price on special items that are useless for non-cultivators.</i>\" Each word sounds almost like it was repeated countless times.\n\n");
        menu();
        addButton(0, "1st Stall", makeItemList, tier1).hint("Check out the first stall. This appears to have common or easy to find TF items.");
        addButton(1, "2nd Stall", makeItemList, tier2).hint("Check out the second stall. This stall sells more common TF items.");
        addButton(2, "3rd Stall", makeItemList, tier3).hint("Check out the third stall. Rarer TF items are sold here.");
        addButton(3, "4th Stall", makeItemList, tier4, true).hint("Check out the fourth stall. This stall has a select few, extremely rare TF items. (you need spirit stones to buy those)");
        addButton(11, "Sell", sellItemsForSpiritStones).hint("Sell items for spirit stones.");
        addButton(12, "Exchange", exchangeGemsToSpiritStonesorReverse).hint("Exchange gems to spirit stones or spirit stones to gems.");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }

    public function exchangeGemsToSpiritStonesorReverse():void {
        clearOutput();
        outputText("When you ask about this exchange that was mentioned on the sign over the entrance, Moga thinks for a moment before reaching to the desk near him. After handing you a piece of paper he adds: ");
        outputText("\n\n\"<i>Here are my exchange rates. Pick the one you want and let me know. If you don't like those rates you can go and try to find someone else... not like there is anyone else here that would want to deal with those exchanges besides me.</i>\"");
        menu();
        if (player.gems >= 20) addButton(0, "20 Gems", exchange,1).hint("Exchange 20 gems for 1 spirit stone.");
        if (player.gems >= 100) addButton(1, "100 Gems", exchange,5).hint("Exchange 100 gems for 5 spirit stones.");
        if (player.gems >= 200) addButton(2, "200 Gems", exchange,10).hint("Exchange 200 gems for 10 spirit stones.");
        if (player.gems >= 1000) addButton(3, "1000 Gems", exchange,50).hint("Exchange 1,000 gems for 50 spirit stones.");
        if (player.gems >= 2000) addButton(4, "2000 Gems", exchange,100).hint("Exchange 2,000 gems for 100 spirit stones.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 1) addButton(5, "1 SS", exchange,1,false).hint("Exchange 1 spirit stone for 5 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 5) addButton(6, "5 SS", exchange,5,false).hint("Exchange 5 spirit stones for 25 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(7, "10 SS", exchange,10,false).hint("Exchange 10 spirit stones for 50 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 50) addButton(8, "50 SS", exchange,50,false).hint("Exchange 50 spirit stones for 250 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 100) addButton(9, "100 SS", exchange,100,false).hint("Exchange 100 spirit stones for 500 gems.");
        if (player.gems >= 10000) addButton(10, "10000 Gems", exchange,500).hint("Exchange 10,000 gems for 500 spirit stones.");
        if (player.gems >= 20000) addButton(11, "20000 Gems", exchange,1000).hint("Exchange 20,000 gems for 1,000 spirit stones.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 500) addButton(12, "500 SS", exchange,500,false).hint("Exchange 500 spirit stones for 2,500 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 1000) addButton(13, "1000 SS", exchange,1000,false).hint("Exchange 1,000 spirit stones for 5,000 gems.");
        addButton(14, "Back", mogahenmerchant);
    }
    private function exchange(value:int,toStones:Boolean=true):void{
        if(toStones){
            outputText("\n\nYou count out the gems before giving them to the merchant. ")
            switch(value){
                case 1:outputText("With noticable mumbling about you being stingy he slowly finishes the transaction, giving you one spirit stone.");break;
                case 5:outputText("With barely noticable mumbling about the customer being stingy he slowly finishes the transaction, giving you five spirit stones.");break;
                case 10:outputText("He finishes the transaction, giving you ten spirit stones.");break;
                case 50:outputText("With slight haste he finishes the transaction, giving you fifty spirit stones.");break;
                case 100:outputText("With haste, he finishes the transaction, giving you a hundred spirit stones.");break;
                case 500:outputText("With great haste, he finishes the transaction, giving you five hundred spirit stones.");break;
                case 1000:outputText("With utter haste, he finishes the transaction, giving you a thousand spirit stones.");break;
            }
            player.gems -= 20*value;
            flags[kFLAGS.SPIRIT_STONES]+=value;
        } else {
            switch(value){
                case 1:outputText("You hand over one stone to the merchant. With noticable mumbling about the customer being stingy he slowly counts out your gems, handing them over.");break;
                case 5:outputText("You hand over five stones to the merchant. With barely noticable mumbling about the customer being stingy he slowly counts out and hands over your gems.");break;
                case 10:outputText("You hand over ten stones to the merchant. He finishes the transaction without fuss, giving you your gems.");break;
                case 50:outputText("You hand over fifty stones to the merchant. He finishes the transaction a bit faster than normal, giving you your gems.");break;
                case 100:outputText("You hand over a hundred stones to the merchant. He finishes the transaction faster than normal, giving you your gems.");break;
                case 500:outputText("You hand over five hundred stones to the merchant. With a smile on his face, he swiftly counts up your gems, handing them over.");break;
                case 1000:outputText("You hand over a thousand stones to the merchant. With a large smile on his face, he swiftly counts up your gems, handing them over.");break;
            }
            player.gems += 5*value;
            flags[kFLAGS.SPIRIT_STONES]-=value;
        }
        statScreenRefresh();
        doNext(exchangeGemsToSpiritStonesorReverse);

    }

    public function sellItemsForSpiritStones():void {
        clearOutput();
        outputText("\"<i>Let me look over what you have for sale. I promise I will give you a 'fair' price for them,</i>\" With this said, the merchant calmly awaits what you will take out.");
        menu();
        if (player.hasItem(useables.GOLCORE, 1)) addButton(0, "Sell 1", sellOneGolemCore).hint("Sell 1 golem core.");
        if (player.hasItem(useables.ELSHARD, 1)) addButton(1, "Sell 1", sellOneElementalShard).hint("Sell 1 elemental shard.");
        if (player.hasItem(useables.LELSHARD, 1)) addButton(2, "Sell 1", sellOneLargeElementalShard).hint("Sell 1 large elemental shard.");
        if (player.hasItem(useables.ELCRYST, 1)) addButton(3, "Sell 1", sellOneElementalCrystal).hint("Sell 1 elemental crystal.");
        if (player.hasItem(useables.EL_CORE, 1)) addButton(4, "Sell 1", sellOneElementalCore).hint("Sell 1 elemental core.");
        if (player.hasItem(useables.GOLCORE, 5)) addButton(5, "Sell 5", sellFiveGolemCores).hint("Sell 5 golem cores.");
        if (player.hasItem(useables.ELSHARD, 5)) addButton(6, "Sell 5", sellFiveElementalShards).hint("Sell 5 elemental shards.");
        if (player.hasItem(useables.LELSHARD, 5)) addButton(7, "Sell 5", sellFiveLargeElementalShards).hint("Sell 5 large elemental shards.");
        if (player.hasItem(useables.ELCRYST, 5)) addButton(8, "Sell 5", sellFiveElementalCrystals).hint("Sell 5 elemental crystals.");
        if (player.hasItem(useables.EL_CORE, 5)) addButton(9, "Sell 5", sellFiveElementalCores).hint("Sell 5 elemental cores.");
        if (player.hasItem(useables.E_ICHOR, 1)) addButton(10, "Sell 1", sellOneEIchorVial).hint("Sell 1 vial of E-Ichor.");
        if (player.hasItem(useables.E_ICHOR, 5)) addButton(11, "Sell 5", sellFiveEIchorVials).hint("Sell 5 vials of E-Ichor.");
        if (player.hasItem(useables.PCSHARD, 1)) addButton(12, "Sell 1", sellOnePurpleCrystalShard).hint("Sell 1 purple crystal shard.");
        if (player.hasItem(useables.PCSHARD, 5)) addButton(13, "Sell 5", sellFivePurpleCrystalShards).hint("Sell 5 purple crystal shards.");
        addButton(14, "Back", mogahenmerchant);
    }

    public function sellOneGolemCore():void {
        clearOutput();
        outputText("\"<i>A single golem core. It's still in good shape, so that will be a single spirit stone,</i>\" he states after examining the core. Moments after he went to put away the core, Moga returns and gives you a single stone.");
        player.destroyItems(useables.GOLCORE, 1);
        flags[kFLAGS.SPIRIT_STONES]++;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneElementalShard():void {
        clearOutput();
        outputText("\"<i>A single elemental shard. It still possesses a lot of energy...I can give you three spirit stones for it.</i>\" He takes the shard, going into the back. Moga returns and gives you three stones.");
        player.destroyItems(useables.ELSHARD, 1);
        flags[kFLAGS.SPIRIT_STONES] += 3;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneLargeElementalShard():void {
        clearOutput();
        outputText("\"<i>A single large elemental shard. It still possesses a lot of energy...I can give you nine spirit stones for it.</i>\" He takes the large shard, going into the back. Moga returns and gives you nine stones.");
        player.destroyItems(useables.LELSHARD, 1);
        flags[kFLAGS.SPIRIT_STONES] += 9;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneElementalCrystal():void {
        clearOutput();
        outputText("\"<i>A single elemental crystal. Not so common find...I can give you thirty spirit stones for it.</i>\" He takes the crystal, going into the back. Moga returns and gives you thirty stones.");
        player.destroyItems(useables.ELCRYST, 1);
        flags[kFLAGS.SPIRIT_STONES] += 30;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneElementalCore():void {
        clearOutput();
        outputText("\"<i>A single elemental core. Nearly priceless treasure but...I would give you, <b>with great pain of stones that i must part with</b> a whole one hundred of spirit stones.</i>\" He takes the core, going into the back. Moga returns and gives you one hundred stones.");
        player.destroyItems(useables.EL_CORE, 1);
        flags[kFLAGS.SPIRIT_STONES] += 100;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveGolemCores():void {
        clearOutput();
        outputText("\"<i>Golem cores. Let me check...Hm...They seem to be in decent shape,</i>\" after the examination he walks away and return shortly. \"<i>Five stones for them.</i>\"");
        player.destroyItems(useables.GOLCORE, 5);
        flags[kFLAGS.SPIRIT_STONES] += 5;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveElementalShards():void {
        clearOutput();
        outputText("\"<i>Elemental shards. Let me check...yes all of them seems to be in a decent state,</i>\" after the examination he walks away and returns shortly. \"<i>Fifteen stones for them.</i>\"");
        player.destroyItems(useables.ELSHARD, 5);
        flags[kFLAGS.SPIRIT_STONES] += 15;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveLargeElementalShards():void {
        clearOutput();
        outputText("\"<i>Large elemental shards. Let me check...yes all of them seems to be in a decent state,</i>\" after the examination he walks away and returns shortly. \"<i>Fourty five stones for them.</i>\"");
        player.destroyItems(useables.LELSHARD, 5);
        flags[kFLAGS.SPIRIT_STONES] += 45;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveElementalCrystals():void {
        clearOutput();
        outputText("\"<i>Elemental crystals. Just what luck you have to gather five of them,</i>\" after the examination he walks away and returns shortly. \"<i>One Hundred and fifty stones for them.</i>\"");
        player.destroyItems(useables.ELCRYST, 5);
        flags[kFLAGS.SPIRIT_STONES] += 150;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveElementalCores():void {
        clearOutput();
        outputText("\"<i>Elemental cores? FIVE ELEMENTAL CORES?</i>\" for a moment he's silently breathing until reasuming. \"<i>It's good you came to me. Five hundred stones,</i>\" he exclaims and with haste walks away and returns much sooner than usualy. \"<i>Five hundred stones for them.</i>\"");
        player.destroyItems(useables.EL_CORE, 5);
        flags[kFLAGS.SPIRIT_STONES] += 500;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneEIchorVial():void {
        clearOutput();
        outputText("\"<i>A single vial of E-Ichor. This is a very hard item to find... twenty spirit stones,</i>\" he states after a long examination of the vial. Moments after he went to put away the vial Moga returns and gives you twenty stones, hands shaking. \"<i>Rare, to see this...and yet...</i>\" He tears his gaze from your hand, waving you off. ");
        player.destroyItems(useables.E_ICHOR, 1);
        flags[kFLAGS.SPIRIT_STONES] += 20;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveEIchorVials():void {
        clearOutput();
        outputText("\"<i>Vials of E-Ichor. Let me check...yes all of them seems to be well-preserved,</i>\" after long examination he walks away and return after even longer time. \"<i>Here are your hun... hundred stones for them...</i>\"");
        player.destroyItems(useables.E_ICHOR, 5);
        flags[kFLAGS.SPIRIT_STONES] += 100;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOnePurpleCrystalShard():void {
        clearOutput();
        outputText("\"<i>A single purple crystal shard. It's still glowing. Two spirit stones for it,</i>\" he states after examining the shard. Moga takes your crystal shard in back, and returns a second later with your stones.");
        player.destroyItems(useables.PCSHARD, 1);
        flags[kFLAGS.SPIRIT_STONES] += 2;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFivePurpleCrystalShards():void {
        clearOutput();
        outputText("\"<i>Purple crystal shards. Let me check...yeah, all of them seem to be intact,</i>\" after examination he walks away and return shortly. \"<i>Here you go. Ten spirit stones.</i>\"");
        player.destroyItems(useables.PCSHARD, 5);
        flags[kFLAGS.SPIRIT_STONES] += 10;
        doNext(sellItemsForSpiritStones);
    }

    public function serenamerchant():void {
        clearOutput();//Serena - female siren npc
        outputText("After entering the shop with a sign saying 'Equipment' over the doors you see a few shelves filled with various weapons, shields, armors and even rarer items like rings and necklaces. Behind the desk in the middle of the shop you see a woman that has features from a variety of different races. A shark face and tail contrasts it's owner's feather covered arms, the fin from her tail bobbing, barely entering your field of view on each side of the desk. She's an odd mix of shark and bird.");
        outputText("\n\n\"<i>Greetings dear customer. I'm Serena and this is my humble shop. If something catches your eyes let me know,</i>\"");
        menu();
        addButton(0, "Shelf 1", soulequipmentshelf1).hint("Soul Training Equipment");
        addButton(1, "Shelf 2", soulequipmentshelf2).hint("Weapons");
        addButton(2, "Shelf 3", soulequipmentshelf3).hint("Armors");
        addButton(3, "Shelf 4", soulequipmentshelf4).hint("Consumables");
        addButton(4, "Shelf 5", soulequipmentshelf5).hint("Misc");
		//addButton(7, weapons.MACE.shortName, weaponBuy, weapons.MACE);//(?magically enchanced?) awl - wymagać bedzie możliwość lewitacji czy coś od PC aby to używać
        //addButton(12, "Talk", ).hint("Tak with .");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }
    public function soulequipmentshelf1():void {
        menu();
		addButton(0, weapons.TRASAXE.shortName, weaponBuy, weapons.TRASAXE, soulequipmentshelf1);
        addButton(1, weaponsrange.TRSXBOW.shortName, weaponBuy, weaponsrange.TRSXBOW, soulequipmentshelf1);
        addButton(2, shields.TRASBUC.shortName, weaponBuy, shields.TRASBUC, soulequipmentshelf1);
        addButton(3, armors.TRASARM.shortName, weaponBuy, armors.TRASARM, soulequipmentshelf1);
        addButton(4, weaponsflyingswords.TRASFLS.shortName, weaponBuy, weaponsflyingswords.TRASFLS, soulequipmentshelf1);
        addButton(5, undergarments.STSHIRT.shortName, weaponBuy, undergarments.STSHIRT, soulequipmentshelf1);
        addButton(6, undergarments.STPANTY.shortName, weaponBuy, undergarments.STPANTY, soulequipmentshelf1);
        addButton(7, headjewelries.TSHAIR.shortName, weaponBuy, headjewelries.TSHAIR, soulequipmentshelf1);
        addButton(8, necklaces.TSNECK.shortName, weaponBuy, necklaces.TSNECK, soulequipmentshelf1);
        addButton(9, jewelries.TSRNG.shortName, weaponBuy, jewelries.TSRNG, soulequipmentshelf1);
        addButton(10, necklaces.SMNECK.shortName, weaponBuy, necklaces.SMNECK, soulequipmentshelf1);
        addButton(11, jewelries.SOULRNG.shortName, weaponBuy, jewelries.SOULRNG, soulequipmentshelf1);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf2():void {
        menu();
        addButton(0, weapons.UGATANA.shortName, weaponBuy, weapons.UGATANA, soulequipmentshelf2);
        addButton(1, weapons.KATANA.shortName, weaponBuy, weapons.KATANA, soulequipmentshelf2);
        addButton(2, weapons.NODACHI.shortName, weaponBuy, weapons.NODACHI, soulequipmentshelf2);
        addButton(3, weapons.S_GAUNT.shortName, weaponBuy, weapons.S_GAUNT, soulequipmentshelf2);
        addButton(4, weapons.CLAWS.shortName, weaponBuy, weapons.CLAWS, soulequipmentshelf2);
        addButton(5, weapons.RCLAYMO.shortName, weaponBuy, weapons.RCLAYMO, soulequipmentshelf2);
        addButton(6, weapons.SCLAYMO.shortName, weaponBuy, weapons.SCLAYMO, soulequipmentshelf2);
        addButton(7, weapons.TCLAYMO.shortName, weaponBuy, weapons.TCLAYMO, soulequipmentshelf2);
        addButton(8, weapons.ACLAYMO.shortName, weaponBuy, weapons.ACLAYMO, soulequipmentshelf2);
        //9
        addButton(10, weapons.WHIP.shortName, weaponBuy, weapons.WHIP, soulequipmentshelf2);
        addButton(11, weapons.DAISHO.shortName, weaponBuy, weapons.DAISHO, soulequipmentshelf2);
        addButton(12, weapons.ZWNDER.shortName, weaponBuy, weapons.ZWNDER, soulequipmentshelf2);
        //13
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf3():void {
        menu();
        if (player.hasPerk(PerkLib.SoulApprentice)) addButton(0, armors.LAYOARM.shortName, weaponBuy, armors.LAYOARM, soulequipmentshelf3);
		else addButtonDisabled(0, "???", "Req. Soul Apprentice");
        if (player.hasPerk(PerkLib.SoulPersonage)) addButton(1, armors.HAYOARM.shortName, weaponBuy, armors.HAYOARM, soulequipmentshelf3);
		else addButtonDisabled(1, "???", "Req. Soul Personage");
        //addButton(11, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic armor made of soulmetal that works with unhindered perk xD czyli coś ala bikini lub ogólnie tylko underwear z fragmentami zbroi lewitującymi wokół postaci i tylko w wypadku ataku wroga przesuwające sie aby przyjąć atak
        //addButton(12, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic light armor made of soulmetal
        //addButton(10, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic heavy armor made of soulmetal
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf4():void {
        menu();
        if (player.level >= 6) addButton(5, consumables.BANGBM1.shortName, weaponBuy, consumables.BANGBM1, soulequipmentshelf4);
		else addButtonDisabled(5, "???", "Req. lvl 6+");
        if (player.level >= 24) addButton(6, consumables.BANGBM2.shortName, weaponBuy, consumables.BANGBM2, soulequipmentshelf4);
        else addButtonDisabled(6, "???", "Req. lvl 24+");
        if (player.level >= 42) {
			addButton(0, consumables.BALLOFL.shortName, weaponBuy, consumables.BALLOFL, soulequipmentshelf4);
			addButton(1, consumables.FROZENB.shortName, weaponBuy, consumables.FROZENB, soulequipmentshelf4);
			addButton(2, consumables.THUNDBl.shortName, weaponBuy, consumables.THUNDBl, soulequipmentshelf4);
			addButton(3, consumables.BALLOTD.shortName, weaponBuy, consumables.BALLOTD, soulequipmentshelf4);
			addButton(4, consumables.POISONB.shortName, weaponBuy, consumables.POISONB, soulequipmentshelf4);
			addButton(7, consumables.BANGBM3.shortName, weaponBuy, consumables.BANGBM3, soulequipmentshelf4);
			//addButton(8, consumables.BANGBM3.shortName, weaponBuy4, consumables.BANGBM3);
		}
        else {
			addButtonDisabled(0, "???", "Req. lvl 42+");
			addButtonDisabled(1, "???", "Req. lvl 42+");
			addButtonDisabled(2, "???", "Req. lvl 42+");
			addButtonDisabled(3, "???", "Req. lvl 42+");
			addButtonDisabled(4, "???", "Req. lvl 42+");
			addButtonDisabled(7, "???", "Req. lvl 42+");
			//addButtonDisabled(8, "???", "Req. lvl 42+");
		}
        addButton(10, consumables.BANGB_M.shortName, weaponBuy, consumables.BANGB_M, soulequipmentshelf4);
        addButton(11, consumables.W_STICK.shortName, weaponBuy, consumables.W_STICK, soulequipmentshelf4);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf5():void {
        menu();
        addButton(0, weapons.A_WAND.shortName, weaponBuy, weapons.A_WAND, soulequipmentshelf5);
		addButton(1, weapons.W_STAFF.shortName, weaponBuy, weapons.W_STAFF, soulequipmentshelf5);
		addButton(2, weapons.AWL_.shortName, weaponBuy, weapons.AWL_, soulequipmentshelf5);
		addButton(3, weapons.RULER.shortName, weaponBuy, weapons.RULER, soulequipmentshelf5);
		addButton(4, weapons.NRSABER.shortName, weaponBuy, weapons.NRSABER, soulequipmentshelf5);
		addButton(5, weapons.RIBBON.shortName, weaponBuy, weapons.RIBBON, soulequipmentshelf5);
		//6
        addButton(7, weapons.HSWORDS.shortName, weaponBuy, weapons.HSWORDS, soulequipmentshelf5);
		addButton(8, weapons.SNAKESW.shortName, weaponBuy, weapons.SNAKESW, soulequipmentshelf5);
		//addButton(9, Changdao
        addButton(10, weapons.FLYWHIS.shortName, weaponBuy, weapons.FLYWHIS, soulequipmentshelf5);
        addButton(11, weapons.PRURUMI.shortName, weaponBuy, weapons.PRURUMI, soulequipmentshelf5);
        addButton(12, weapons.CHAKRAM.shortName, weaponBuy, weapons.CHAKRAM, soulequipmentshelf5);
        addButton(13, shields.MABRACE.shortName, weaponBuy, shields.MABRACE, soulequipmentshelf5);
        addButton(14, "Back", serenamerchant);
    }

	private function weaponBuy(itype:ItemType, returnFunc:Function):void {
		var descString:String = "After entering the shop with a sign saying 'Equipment' over the doors you see a few shelves filled with various weapons, shields, armors and even rarer items like rings and necklaces. Behind the desk in the middle of the shop you see a woman that has features from a variety of different races. A shark face and tail contrasts it's owner's feather covered arms, the fin from her tail bobbing, barely entering your field of view on each side of the desk. She's an odd mix of shark and bird."
        + "\n\n\"<i>Greetings dear customer. I'm Serena and this is my humble shop. If something catches your eyes let me know,</i>\"\n";
		MultiBuy.confirmBuyMulti(returnFunc, "Serena", 10, itype, descString, "\n", true);
	}

	public function entranceToRiverDungeon():void {
		clearOutput();
		if (flags[kFLAGS.NEISA_FOLLOWER] == 0) {
			outputText("As you approach the cave a bunch of heavily armored guards stops you. You can barely see their faces under their helmets.\n\n");
			outputText("\"<i>Hey, you there! Hold! This cave is dangerous, we can’t just let you head in by yourself. You must go with someone else, where is your partner?</i>\"\n\n");
			outputText("Partner? What partner?\n\n");
			outputText("\"<i>Your teammate you moron. This place has claimed more adventurers lives than the wilds of Mareth by now. No one goes in there alone.</i>\"\n\n");
			outputText("It seems like these people won’t let you go in the cave without a teammate.\n\n");
			flags[kFLAGS.NEISA_FOLLOWER] = 1;
			outputText("You decide to play by the rules and go find another hero to team with. The problem is, where would you even look for one?\n\n");
			doNext(riverislandVillageStuff);
		}
		else {
			outputText("Seeing as you come as a team the guards let you in, but not before issuing a final warning.\n\n");
			outputText("\"<i>Try not to die down there, a lot of people went in and never came back.</i>\"\n\n");
			outputText("You will keep that in mind.\n\n");
			doNext(riverdungeon.enterDungeon);
		}
	}

    public function ermaswiftarrowmerchant():void {
        clearOutput();
        outputText("After entering the shop with a sign saying 'Soul Arrow' over the doors you see a few shelves filled with various ranged weapons of all sorts, from bows, to crossbows, to some more exotic ones that you aren't even sure what they are called. ");
        outputText("Behind the desk in the central point of the shop you see a centauress. She has no fancy or provocative clothes, and sports an average body. She moves quite gracefully around the shelves, despite her larger body.");
        outputText("\n\n\"<i>Greetings, my name is Erma Swiftarrow and this is my shop. Go ahead and look around, if something catches your eye, simply let me know,</i>\" she say all that almost entirely in one breath after noticing your presence.");
        menu();
        addButton(1, "Shelf 1", ermaswiftarrowmerchantshelf1).hint("Bows and Crossbows");
        addButton(3, "Shelf 2", ermaswiftarrowmerchantshelf2).hint("Other types");
        //addButton(9, weapons.MACE.shortName, weaponBuy, weapons.MACE);//bow made for soul cultivator xD
        addButton(13, "Training", ermaswiftarrowmerchantarcherytraining).hint("Archery training.");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }
    public function ermaswiftarrowmerchantshelf1():void {
        menu();
        addButton(0, weaponsrange.BOWLIGH.shortName, weaponRangeBuy, weaponsrange.BOWLIGH, ermaswiftarrowmerchantshelf1);
        addButton(1, weaponsrange.BOWHUNT.shortName, weaponRangeBuy, weaponsrange.BOWHUNT, ermaswiftarrowmerchantshelf1);
        addButton(2, weaponsrange.BOWLONG.shortName, weaponRangeBuy, weaponsrange.BOWLONG, ermaswiftarrowmerchantshelf1);
        addButton(3, weaponsrange.BOWKELT.shortName, weaponRangeBuy, weaponsrange.BOWKELT, ermaswiftarrowmerchantshelf1);
        addButton(5, weaponsrange.LCROSBW.shortName, weaponRangeBuy, weaponsrange.LCROSBW, ermaswiftarrowmerchantshelf1);
        addButton(6, weaponsrange.HUXBOW_.shortName, weaponRangeBuy, weaponsrange.HUXBOW_, ermaswiftarrowmerchantshelf1);
        addButton(7, weaponsrange.HEXBOW_.shortName, weaponRangeBuy, weaponsrange.HEXBOW_, ermaswiftarrowmerchantshelf1);
        addButton(14, "Back", ermaswiftarrowmerchant);
    }
    public function ermaswiftarrowmerchantshelf2():void {
        menu();
        addButton(0, weaponsrange.ATKNIFE.shortName, weaponRangeBuy, weaponsrange.ATKNIFE, ermaswiftarrowmerchantshelf2);
        addButton(1, weaponsrange.RTKNIFE.shortName, weaponRangeBuy, weaponsrange.RTKNIFE, ermaswiftarrowmerchantshelf2);
        addButton(2, weaponsrange.STKNIFE.shortName, weaponRangeBuy, weaponsrange.STKNIFE, ermaswiftarrowmerchantshelf2);
        addButton(3, weaponsrange.TTKNIFE.shortName, weaponRangeBuy, weaponsrange.TTKNIFE, ermaswiftarrowmerchantshelf2);
        addButton(5, weaponsrange.O_JAVEL.shortName, weaponRangeBuy, weaponsrange.O_JAVEL, ermaswiftarrowmerchantshelf2);
        addButton(6, weaponsrange.T_KNIFE.shortName, weaponRangeBuy, weaponsrange.T_KNIFE, ermaswiftarrowmerchantshelf2);
        addButton(7, weaponsrange.SHURIKE.shortName, weaponRangeBuy, weaponsrange.SHURIKE, ermaswiftarrowmerchantshelf2);
        addButton(14, "Back", ermaswiftarrowmerchant);
    }

	private function weaponRangeBuy(itype:ItemType, returnFunc:Function):void {
		var descString:String = "After entering the shop with a sign saying 'Soul Arrow' over the doors you see a few shelves filled with various ranged weapons of all sorts, from bows, to crossbows, to some more exotic ones that you aren't even sure what they are called. "
		+ "Behind the desk in the central point of the shop you see a centauress. She has no fancy or provocative clothes, and sports an average body. She moves quite gracefully around the shelves, despite her larger body."
		+ "\n\n\"<i>Greetings, my name is Erma Swiftarrow and this is my shop. Go ahead and look around, if something catches your eye, simply let me know,</i>\" she say all that almost entirely in one breath after noticing your presence.";
		MultiBuy.confirmBuyMulti(returnFunc, "Erma", 10, itype, descString, "\n", true);
	}

	public function ermaswiftarrowmerchantarcherytraining():void {
		clearOutput();
		if (flags[kFLAGS.ERMA_ARCHERY_TRAINING] > 0) outputText("\"<i>Need more training? Sure, but it's 10 spirit stones, paid up front, if you would.</i>\"");
		else {
			outputText("Bows are nice and all but they won’t be of much use to you if you can’t wield them properly. You thus ask Erma if training is something the shop can provide.\n\n");
			outputText("\"<i>I have trained new archers before. Yes, I can train you, but I don’t do it for free. It would be 10 spirit stones a session if you want me to teach you.</i>\"");
			flags[kFLAGS.ERMA_ARCHERY_TRAINING] = 1;
		}
		menu();
		addButton(0, "Yes", ermaswiftarrowmerchantarcherytrainingYes);
		addButton(1, "No", ermaswiftarrowmerchantarcherytrainingNo);
	}
	public function ermaswiftarrowmerchantarcherytrainingNo():void {
		outputText("\n\nYou were just inquiring, for now you do not take her up on the offer, but keep it in mind.");
		doNext(ermaswiftarrowmerchant);
	}
	public function ermaswiftarrowmerchantarcherytrainingYes():void {
		if (player.statusEffectv1(StatusEffects.Kelt) > 99) {
			outputText("\n\nShe looks up and down at you, and says \"<i>I'm sorry, but I don't think I have much more that I can teach you.</i>\"");
			doNext(ermaswiftarrowmerchant);
		}
		else {
			if (flags[kFLAGS.SPIRIT_STONES] < 10) {
				outputText("\n\nSadly, you lack the spirit stones for training right now.");
				doNext(ermaswiftarrowmerchant);
			}
			else {
				flags[kFLAGS.SPIRIT_STONES] -= 10;
				outputText("\n\nYou follow Erma behind the shop into the backyard. She has a field there for target practice. You spend the better part of the day shooting arrows, practicing and improving your aim while Erma corrects your stance and gives advice. You leave the village with improved skills at archery.");
				if (!player.hasStatusEffect(StatusEffects.Kelt)) player.createStatusEffect(StatusEffects.Kelt, 10, 0, 0, 0);
				else player.addStatusValue(StatusEffects.Kelt, 1, 10);
				if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);
				doNext(camp.returnToCampUseSixHours);
			}
		}
	}

	public function qimerchant():void {
        clearOutput();
        outputText("After entering the shop with a sign saying 'Flying Swords are always with you!' over the doors you see a few shelves filled with various flying swords. ");
        outputText("Behind the desk in the central point of the shop you see a flesh golem on unidentified gender.");
        outputText("\n\n\"<i>Greetings, customer. Go ahead and look around, if something catches your eye, simply let me know,</i>\" it say all that almost entirely in one breath after noticing your presence.");
        menu();
		addButton(0, weaponsflyingswords.S_HALFM.shortName, flyingSwordBuy, weaponsflyingswords.S_HALFM, qimerchant);
		addButton(1, weaponsflyingswords.E_HALFM.shortName, flyingSwordBuy, weaponsflyingswords.E_HALFM, qimerchant);
		addButton(2, weaponsflyingswords.B_HALFM.shortName, flyingSwordBuy, weaponsflyingswords.B_HALFM, qimerchant);
		addButton(3, weaponsflyingswords.W_HALFM.shortName, flyingSwordBuy, weaponsflyingswords.W_HALFM, qimerchant);
		addButton(4, weaponsflyingswords.MOONLGT.shortName, flyingSwordBuy, weaponsflyingswords.MOONLGT, qimerchant);
		addButton(5, weaponsflyingswords.S_TWINS.shortName, flyingSwordBuy, weaponsflyingswords.S_TWINS, qimerchant);
		addButton(10, weaponsflyingswords.ASAUCHI.shortName, flyingSwordBuy, weaponsflyingswords.ASAUCHI, qimerchant);
        addButton(13, "Qi", qimerchantTraningMain).hint("Flying Sword training and others related matters.");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }
	
	private function qimerchantTraningMain():void {
		clearOutput();
		outputText("\"<i>Welcome customer,</i>\" Qi stretches his arms out toward you before gesturing to his inventory. \"<i>Please, browse my wares. Can I interest you in a sword, or are you looking for something else?</i>\"");
		menu();
		if (player.hasPerk(PerkLib.SoulSense) && flags[kFLAGS.SPIRIT_STONES] >= 50) addButtonIfTrue(0, "Basic training", qimerchantTraningMainFlyingSwordPath1, "You already learned basic control of flying swords.", !player.hasPerk(PerkLib.FlyingSwordPath));
		else addButtonDisabled(0, "Basic training", "Req. Soul Sense perk & 50 spirit stones.");
		addButtonIfTrue(10, "Soaring Blades", qimerchantTraningMainSoaringBladesManual, "You need to learn how to control flying swords first (Req. Flying Sword Path perk).", player.hasPerk(PerkLib.FlyingSwordPath));
		addButton(14, "Back", qimerchant);
	}
	private function qimerchantTraningMainFlyingSwordPath1():void {
		clearOutput();
		outputText("He motions you to follow him to next room. Once inside after him, you notice something a strange sensation. The room feels off, as if it's larger than it has any right to be. Should you go back out and double check?\n\n");
		outputText("Qi notices your confusion, \"<i>It's just minor space expansion effect set up. It's useful when I need to do some training or teach others such as you. It prevents accidents when you have more room to learn in.</i>\" He then points you to sit on one of cushions set in the middle of the room.\n\n");
		outputText("He settles down with you before he resumes the lesson, \"<i>Using flying swords require two things: First it's to imprint mark on the sword using your own soulforce. Let me show you.</i>\"\n\n");
		outputText("He pulls out a small flying sword from a Bag of Holding. While he explains the whole process, he makes new imprint of it. He follows with explaining how to find if a particular sword already has an imprint. Then, he takes out another sword and gives it to you to repeat what he has shown.\n\n");
		outputText("It takes a tremendous effort to get used to, but Qi remains patient, watching you intently with a steady gaze. After several initial failures, you managed to imprint the sword.\n\n");
		outputText("Qi applauds briefly, \"<i>Good. Now, the second step: Controlling it to do what you want utilizing your Soul Sense. Imagine using it as you would with your hand and control flying sword.</i>\"\n\n");
		outputText("Qi takes out four smaller swords before tossing them into air. He watches them float as they bring themselves into a basic formation instead of falling down on the floor. \"<i>At first, you may find it difficult to not gesticulate as you draw on your soul force to guide the swords...</i>\" He moves his right hand, causing all the swords follow his gesture, \"<i>As you find your sense of self, I'd advise against any movements or somatics. Work your way until you don't have to make a single movement...</i>\" He pauses his hand as the swords continue circling the both of you until they all return to his side like faithful hounds.\n\n");
		outputText("\"<i>Naturally, it'll be much easier to control multiple smaller weapons over larger ones.</i>\" With a wave of his hand, the swords seem to fold over one another before vanishing into his bag. \"<i>Though, that is a lesson for the future. Now, if you succeed, you will be able to, at best, use one massive, two large or four small ones.</i>\"\n\n");
		outputText("For the next half hour, you work on controlling the swords under Qi's guidance, watching his lessons with intent as he instructs each moment meticulously, ensuring you can reach your full potential.\n\n");
		outputText("\"<i>Good, it would appear that you understand the basics of using flying swords. Besides using them to move and attack, you could also use ride on a sword that's large enough, though, this inhibits all offensive potential, of course.</i>\"\n\n");
		outputText("He extends his hand to you, \"<i>Now, please return that sword. You can always buy one from me when you need it, that one is solely for practice.</i>\"\n\n");
		outputText("You return the sword to him, to which he responds with a respectful bow before running a piece of cloth over it, clearing any imprints upon it as he stashes it away. \"<i>Until your cultivation base not attain major breakthrough i can't teach you anything new beside providing you with manual for minor technique that helps you to lessen burden of using flying swords as your progress through each major realm. It's not super cheap one but I can sell it to you. As long you got enough spirit stones to buy it.</i>\" He laugh heartly then stands up and leading you back to first room where the golem stays.\n\n");
		outputText("<b>(<b>Gained Perk: Flying Sword Path (Rank 1)!</b>)</b>\n\n");
		player.createPerk(PerkLib.FlyingSwordPath, 1, 0, 0, 0);
		flags[kFLAGS.SPIRIT_STONES] -= 50;
		advanceMinutes(150);
		doNext(qimerchantTraningMain);
	}
	private function qimerchantTraningMainFlyingSwordPath2():void {
		clearOutput();
		outputText("\"<i></i>\"\n\n");
		advanceMinutes(150);
		doNext(qimerchantTraningMain);
	}
	private function qimerchantTraningMainSoaringBladesManual():void {
		clearOutput();
		outputText("Qi holds up the manual and says, \"<i>It would teach you Soaring Blades, that helps with reducing soulfroce consumption to operate flying swords.  It is <b>50 spirit stones</b></i>.\" ");
		doYesNo(buySoaringBladesManual, qimerchantTraningMain);
	}	
	private function buySoaringBladesManual():void {
		if (flags[kFLAGS.SPIRIT_STONES] < 50) {
			clearOutput();
			outputText("\n\nQi sighs, indicating you need " + String(50 - flags[kFLAGS.SPIRIT_STONES]) + " more spirit stones to purchase this manual.");
			doNext(qimerchantTraningMain);
		}
		else {
			flags[kFLAGS.SPIRIT_STONES] -= 50;
			inventory.takeItem(consumables.S_B_MAN, qimerchantTraningMain);
		}
	}

	private function flyingSwordBuy(itype:ItemType, returnFunc:Function):void {
		var descString:String = "After entering the shop with a sign saying 'Flying Swords are always with you!' over the doors you see a few shelves filled with various flying swords. "
		+ "Behind the desk in the central point of the shop you see a flesh golem on unidentified gender."
		+ "\n\n\"<i>Greetings, customer. Go ahead and look around, if something catches your eye, simply let me know,</i>\" it say all that almost entirely in one breath after noticing your presence.\n";
		MultiBuy.confirmBuyMulti(returnFunc, "Erma", 10, itype, descString, "\n", true);
	}

public function soularena():void {
	clearOutput();//arena do walk z przeciwnikami na exp tylko - zadnych sex scenes tylko walk do wygranej niewazne czy przez hp czy lust - przeciwnicy: ?weak deviant golem?, niskopoziomowi przeciwnicy uzywajacy soul skills (moze po prostu wesje zwyklych przeciwnikow ale z dodanymi soul attakami?)
	if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 10 && flags[kFLAGS.CHI_CHI_AFFECTION] < 15 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && !SceneLib.chichiScene.ChiChiKickedOut) SceneLib.chichiScene.EnterOfTheChiChi();
	else {
		outputText("Coming closer to the arena you see two muscular tigersharks standing on each side of the entrance, they only briefly glance at you the moment you pass by. Moments after you enter, a tall, slightly muscular cat-morph approaches you. Most of his body is covered by armor, yet two long tails wave behind him.");//osoba zarządzająca areną bedzie male nekomanta npc
		outputText("\n\n\"<i>Welcome to the Soul Arena. Don't start fights outside of the proper place or you will be thrown out. We have training facilities, and fights you can enter. Fights cost spirit stones. Make sure you have enough of them. We aren't a charity.</i>\"");
		outputText(" Without wasting time the nekomata overseer of this place explains to you all that you needed to know about the place and walks away.\n\nSo which of the three possible areas do you want to visit this time?");
		if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) outputText("\n\nYou notice Ignis sitting in the stands, a notebook in his paws. The kitsune seems to be watching the fights and taking notes.");
		if (flags[kFLAGS.CHI_CHI_AFFECTION] < 1) flags[kFLAGS.CHI_CHI_AFFECTION] = 0;
		menu();//statuseffect(soulArena) dodać na początku walk co pozwoli dać inne dropy itp. w stosunku do spotkania podobnego wroga w innym miejscu a nawet łatwo pozwoli zrobić wersje soulforce niektórych ras bez tworzenia nowych opisów monsterów - zrobić to dla trybu challenge, w który walka z wrogie da określony drop a nawet można na niej grać aby uzyskać nagro...np. nowego camp member ^^
		if (flags[kFLAGS.SPIRIT_STONES] < 1) addButtonDisabled(0, "Solo", "To go to the section of soul arena for 1 on 1 fights you need to give 1 spirit stone.");
		else addButton(0, "Solo", soularenaSolo).hint("Go to the section of soul arena for 1 on 1 fights.");
		if (flags[kFLAGS.SPIRIT_STONES] < 2) addButtonDisabled(1, "Group", "To go to the section of soul arena for group fights you need to give 2 spirit stones.");
		else addButton(1, "Group", soularenaGroup).hint("Go to the section of soul arena for group fights.");
		if (flags[kFLAGS.SPIRIT_STONES] < 3) addButtonDisabled(2, "Challange", "To go to the section of soul arena for challenges you need to give 3 spirit stones.");
		else addButton(2, "Challenge", soularenaChallenge).hint("Go to the section of soul arena for challenges. (Who knows what rewards you may get after winning any of the challenges there...)");
		if (flags[kFLAGS.IGNIS_ARENA_SEER] >= 1) addButton(10, "Ignis", ignisarenaseer.mainIgnisMenu);
		addButton(11, "M.S.L.", mrsShigureLectures).hint("Mrs. Shigure Lectures about soul cultivation.");
		addButton(14, "Back", riverislandVillageStuff);
		statScreenRefresh();
	}
}

    public function soularenaSolo():void {
        clearOutput();
		flags[kFLAGS.SPIRIT_STONES] -= 1;
        outputText("Picking the one on the left, you prepare for a solo fight. You enter the area and look around for anyone currently available for a sparring session.");
        statScreenRefresh();
		menu();
        //addButton(0, "Goblin", );//Goblinka
        addButton(5, "D.Golem", arenaSelection,GolemDummy).hint("Dummy Golem LVL 6");
        addButton(6, "I.D.Golem", arenaSelection,GolemDummyImproved).hint("Improved Dummy Golem LVL 12");
        addButton(7, "A.D.Golem", arenaSelection,GolemDummyAdvanced).hint("Advanced Dummy Golem LVL 18");
        addButton(8, "S.D.Golem", arenaSelection,GolemDummySuperior).hint("Superior Dummy Golem LVL 24");
        addButton(10, "B.T.Golem", arenaSelection,GolemTrueBasic).hint("Basic True Golem LVL 33");
        addButton(11, "I.T.Golem", arenaSelection,GolemTrueImproved).hint("Improved True Golem LVL 42");
        addButton(12, "A.T.Golem", arenaSelection,GolemTrueAdvanced).hint("Advanced True Golem LVL 51");
        addButton(14, "Back", soularenaSoloBack);
    }
	public function soularenaSoloBack():void {
		flags[kFLAGS.SPIRIT_STONES] += 1;
		statScreenRefresh();
		soularena();
	}

    public function soularenaGroup():void {
        clearOutput();
        flags[kFLAGS.SPIRIT_STONES] -= 2;
        outputText("Picking the one on the right, you prepare for a group fight. You enter the area and look around for a group currently available for a sparring session.");
        statScreenRefresh();
		menu();
        //addButton(0, "Goblins", );//Córki goblinki z solo areny ^^
        addButton(5, "D.Golems", arenaSelection,GolemsDummy).hint("Dummy Golems LVL 6");
        addButton(6, "I.D.Golems", arenaSelection,GolemsDummyImproved).hint("Improved Dummy Golems LVL 12");
        addButton(7, "A.D.Golems", arenaSelection,GolemsDummyAdvanced).hint("Advanced Dummy Golems LVL 18");
        addButton(8, "S.D.Golems", arenaSelection,GolemsDummySuperior).hint("Superior Dummy Golems LVL 24");
        addButton(10, "B.T.Golems", arenaSelection,GolemsTrueBasic).hint("Basic True Golems LVL 33");
        addButton(11, "I.T.Golems", arenaSelection,GolemsTrueImproved).hint("Improved True Golems LVL 42");
        addButton(12, "A.T.Golems", arenaSelection,GolemsTrueAdvanced).hint("Advanced True Golems LVL 51");
        addButton(14, "Back", soularenaGroupBack);
    }
	public function soularenaGroupBack():void {
		flags[kFLAGS.SPIRIT_STONES] += 2;
		statScreenRefresh();
		soularena();
	}

    public function soularenaChallenge():void {
        clearOutput();
        flags[kFLAGS.SPIRIT_STONES] -= 3;
        outputText("Picking the one in the middle you prepare for the challenges. You enter the area and look around for anyone currently available.");
        statScreenRefresh();
		soularenaChallengeSubpages();
    }
	private function soularenaChallengeSubpages(page:int = 1):void {
		menu();
		if (page == 1) {
			if (player.statusEffectv1(StatusEffects.SoulArenaGaunlets1) > 1) addButtonDisabled(0, "Gaunlet 1", "You already won this gauntlet today. Come back tomorrow.");
			else addButton(0, "Gaunlet 1", gaunletchallange1fight1).hint("Fight 3 diff enemies one after another.");
			if (player.statusEffectv1(StatusEffects.SoulArenaGaunlets1) > 0) {
				if (player.statusEffectv2(StatusEffects.SoulArenaGaunlets1) > 1) addButtonDisabled(1, "Gaunlet 2", "You already won this gauntlet today. Come back tomorrow.");
				else addButton(1, "Gaunlet 2", gaunletchallange2fight1).hint("Fight 4 diff enemies one after another.");
			}
			else addButtonDisabled(1, "Gaunlet 2", "You need to finish Gauntlet 1 first.");
			//addButton(2, "Gauntlet 3", gaunletchallange3).hint("Fight 5 diff enemies one after another.");
			//addButton(3, "Gauntlet 4", gaunletchallange4).hint("Fight 6 diff enemies one after another.");
			//addButton(4, "Gauntlet 5", gaunletchallange5).hint("Fight 7 diff enemies one after another.");
			//addButton(5, "Gauntlet 6", gaunletchallange6).hint("Fight 8 diff enemies one after another.");
			addButton(7, "LvL 24 Gargoyle (F)", arenaSelection,GargoyleFBasic).hint("Gargoyle (F) LVL 24 (axe-tail)");
			addButton(8, "LvL 24 Gargoyle (M)", arenaSelection,GargoyleMBasic).hint("Gargoyle (M) LVL 24 (mace-tail)");
			addButton(9, "-2-", soularenaChallengeSubpages, page + 1);
			addButton(10, "LvL 33 Golems", arenaSelection,GolemsBasic).hint("Basic Golems LVL 33");
			addButton(11, "LvL 42 Golems", arenaSelection,GolemsImproved).hint("Improved Golems LVL 42");
			addButton(12, "LvL 51 Golems", arenaSelection, GolemsAdvanced).hint("Advanced Golems LVL 51");
			addButton(14, "Back", soularenaChallengeBack);
		}
		if (page == 2) {
			//addButton(0, "Kitty", arenaSelection, Veronika);
			//addButton(1, "Golemancer", arenaSelection,Jeniffer).hint("Golemancer goblin.");
			//addButton(2, "AyotechManiac", arenaSelection,Jinx).hint("Crazy gremlin girl wearing lots of belts... err Ayotech weapons.");
			//addButton(5, "Macho Mander", arenaSelection,Syth).hint("He's Macho & Mander.");
			//if () addButton(6, "Miss Mander", arenaSelection,Asuka).hint("Salamander woman.");
			//else addButton(6, "Miss Mander", arenaSelection,Asuka).hint("Young salamander girl.");
			//addButton(7, "Miss Oni", arenaSelection,Rangiku);
			addButton(9, "-1-", soularenaChallengeSubpages, page - 1);
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButtonDisabled(10, "IntermedLeader", "Req. to have any henchman with you to start this fight.");
			else addButton(10, "IntermedLeader", intermediateleadershipfight1).hint("Intermediate Leadership fight");
			addButton(14, "Back", soularenaChallengeBack);
		}
	}
    private function arenaSelection(mon:Class):void{
		player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
		if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
        startCombatImmediate(new mon());
		monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
		monster.XP = monster.XP * 2;
    }
	public function soularenafightsbetween():void {
		cleanupAfterCombat();
		player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
	}
	public function intermediateleadershipfight1():void {
		clearOutput();
		outputText("As you enter the arena the announcer voice booms in and the crowd cheers you up. They get to see the hero who defeated the previous trial make a come back and thats clearly not an everyday spectacle.\n\n");
		outputText("\"<i>Greeting people of the river town, welcome to the arena. Today our favourite champion faces off against team battles, you know what this means!</i>\"\n\n");
		outputText("The crowd suddenly starts calling out as a pair of large figures easily 8 feet tall steps out from the opposite archway. It's a minotaur and its lacta bovine wife. ");
		outputText("A single minotaur is normally much trouble but partnered up with a lacta bovine there's no telling what shenanigan could happen! The bull walks toward you confident in his might he won't let you simply trample his pride before his wife.\n\n");
		player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
		startCombat(new MinotaurKing());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function intermediateleadershipfight2():void {
		clearOutput();
		soularenafightsbetween();
		outputText("\n\nAs the minotaur couple falls down utterly defeated the announcer claims. \"<i>Well seeing as the challenger defeated the cows we have a special surprise for you today. Angels do not typically associate with us folks as they are too busy waging a bloody war against the demon and scouring corruption from the land ");
		outputText("but through many deals and persuasion we managed to secure the collaboration of these two. I present to you Gabriel and Uriel the angel twins! Do not be deceived by their beauty noor their innocent look they are definitely out for blood!</i>\"\n\n");
		outputText("The two angels calmly hover into the battlefield flanked by two pairs of toothed winged orbs. Their demeanour is almost void of expression as they fixate you and emotionlessly declare at the same time.\n\n");
        outputText("\"<i>Do not make this complicated for us mortal… simply fall.</i>\"\n\n");
		startCombat(new AngelLR());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function intermediateleadershippostfight():void {
		clearOutput();
		outputText("The twins stare at you in complete confusion as too weak to continue fighting their wings fails them causing them to fall to the ground. Their angeloid constructs are too damaged to even grant them support.\n\n");
		outputText("\"<i>Woa look like we got a winner here congratulation [name]!</i>\"\n\n");
		outputText("Successfully working together with another person has taught you how to better fight in a party. <b>Gained Perk: Intermediate Leadership</b>\n\n");
		player.createPerk(PerkLib.IntermediateLeadership, 0, 0, 0, 0);
        cleanupAfterCombat();
	}
	public function dishHelper():void {
		menu();
		if (flags[kFLAGS.PLAYER_COMPANION_1] != "") addButton(0, "1st", dishHelper2, 1).hint("Ask your first henchman to deal with it.");
		if (flags[kFLAGS.PLAYER_COMPANION_2] != "") addButton(1, "2nd", dishHelper2, 2).hint("Ask your second henchman to deal with it.");
	}
	public function dishHelper2(henchman:Number = 0):void
	{
		clearOutput();
		player.createStatusEffect(StatusEffects.MinoKing,henchman,0,0,0);
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Neisa you need her to handle the bova girl so you can fight the Minotaur Challanger alone.\n\n");
				outputText("Neisa nods, \"<i>A sound stratagem, leave it to me!</i>\" She raises her shield before ramming into the bova girl. The stun knocks her out cold.\n\n");
				outputText("Neisa turns back, giving you a thumbs up along with an excited smile.\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You tell Neisa you need her to handle Excellia so you can fight the Minotaur King alone.\n\n");
				outputText("Neisa nods, \"<i>A sound stratagem, leave it to me!</i>\"\n\n");
				outputText("Neisa raises her shield before ramming into Excellia. The stun knocks Excellia off her feet before she rises, ready to fight her new foe.\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Etna")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Etna you need her to take care of bova girl so you can focus your assault on the Minotaur Challanger.\n\n");
				outputText("Etna smirks, \"<i>Let’s see if her face will enjoy my tail.</i>\"\n\n");
				outputText("She wastes no time flying into the air before dive-bombing into the bova girl, quickly wrapping the cow girl within her tail. It doesn’t take long for the bova girl to succumb to the venom, enthralled by Etna’s presence.\n\n");
				outputText("Etna speaks out to you, \"<i>I’ll keep this little toy occupied, you have fun, [name].</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You tell Etna you need her to take care of Excellia so you can focus your assault on the Minotaur King.\n\n");
				outputText("Etna smirks, \"<i>Let’s see if her face will enjoy my tail.</i>\"\n\n");
				outputText("She wastes no time flying into the air before dive-bombing into Excellia, doing her best to wrap her within her tail, and envenom the cow girl.\n\n");
				outputText("Excellia fights back, evidently stronger than she appears.\n\n");
				outputText("\"<i>You won’t take me that easily!</i>\" Excellia shouts.\n\n");
				outputText("Etna raises her claws, \"<i>Just give in, it’ll be so much easier for us.</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Aurora you need her to take care of the bova girl so you can focus your assault on the Minotaur Challanger.\n\n");
				outputText("Aurora nods before raising her wings before swooping down onto the Bova girl, pinning her beneath her stone frame. The bova girl is quickly pinned down.\n\n");
				outputText("Aurora calls out to you, \"<i>I’ll just watch from here, this girl won’t be doing anything now.</i>\"\n\n");
			}
			else {
				outputText("You tell Aurora you need her to take care of Excellia so you can focus your assault on the Minotaur King.\n\n");
				outputText("Aurora nods before raising her wings before swooping down onto Excellia, pinning her beneath her stone frame. Excellia struggles and manages to throw Aurora off of her.\n\n");
				outputText("\"<i>You’re not going to take me that easily.</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Alvina you need her to handle the Bova girl so you can focus your assault on the Minotaur Challanger.\n\n");
				outputText("Alvina rolls her eyes, \"<i>Fine, I’ll just keep her restrained for now.</i>\"\n\n");
				outputText("She sets down her scythe before drawing somatic symbols with a single finger. The girl is forcibly risen, hoisted further into the air before vanishing in an instant.\n\n");
				outputText("\"<i>That’ll keep her contained, it’s so much easier when they’re a weak-willed slave like her. I’ll just keep this focused so I don’t kill her… yet…</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You tell Alvina you need her to handle Excellia so you can focus your assault on the Minotaur King.\n\n");
				outputText("Alvina rolls her eyes, \"<i>Fine, I’ll just keep her restrained for now.</i>\"\n\n");
				outputText("She sets down her scythe before drawing somatic symbols with a single finger. Excellia is forcibly risen, hoisted further into the air before vanishing in an instant.\n\n");
				outputText("\"<i>That’ll keep her contained, I’ll just keep this focused so I don’t kill her… yet…</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Mitzi")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Mizti and her daughters you need them to take care of bova girl so you can focus your assault on the Minotaur Challanger.\n\n");
				outputText("Mitzi raises her fist as her several daughters cheer, \"<i>Let’s get that slut!</i>\"\n\n");
				outputText("Furxia, Lidea, Mizti, and Roxy rush the bova girl, flanking her from every direction.\n\n");
				outputText("The Bova girl holds up her hands, \"<i>Please, have mercy!</i>\"\n\n");
				outputText("The goblins exchange sinister glances with each other. It would seem they have their prey all to themselves.\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You tell Mizti and her daughters you need them to take care of Excellia so you can focus your assault on the Minotaur King.\n\n");
				outputText("Mitzi raises her fist as her several daughters cheer, \"<i>Let’s get that slut!</i>\"\n\n");
				outputText("Furxia, Lidea, Mizti, and Roxy rush Excellia, flanking her from every direction.\n\n");
				outputText("Excellia braces herself, trying to fight back against the determined goblin horde.\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Excellia")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Excellia you need her to take care of the bova girl.\n\n");
				outputText("Excellia readies herself, \"<i>I can handle that with ease.</i>\"\n\n");
				outputText("She barges in, slamming her weight against the bova girl as she’s quickly knocked out.\n\n");
				outputText("Excellia turns to you, \"<i>I’ll stay here and make sure she stays down. You can handle this, [name].</i>\"\n\n");
			}
			else {
				outputText("You tell Excellia you need her to take care of her past self.\n\n");
				if (EngineCore.silly()) {
					outputText("Excellia frowns, \"<i>You really wanted to cheat and see what happens when you use me against myself? How pathetic. Fine, I’ll do it. Now go share this screenshot with everyone so you can gain clout on the internet.</i>\"\n\n");
					outputText("Excellia saunters up to herself. Because this scene isn’t canon in the slightest, the past Excellia is confused and is promptly vaporized due to a coding error or something.\n\n");
					outputText("<b>*poof*</b>\n\n");
				}
				else {
					outputText("Excellia rolls her eyes, \"<i>Next time you shouldn’t cheat just to see what happens.</i>\"\n\n");
					outputText("Excellia rushes in, using the weight of her body to smash into herself.\n\n");
				}
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Amily") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Amily")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You ask Amily if she can take care of the Bova girl so you can focus on fighting the Minotaur Challanger alone.\n\n");
				outputText("Amily nods before coating her daggers in some poison, \"<i>I got this, you can count on me.</i>\"\n\n");
				outputText("She rushes through, evading the Minotaur King before throwing a knife at the girl. The bova girl stumbles back as Amily wastes no time recovering her knife while keeping up the pressure.\n\n");
				outputText("\"<i>Ah, you bitch!</i>\" The girl shouts as she’s pinned to the ground.\n\n");
				outputText("Amily calls back to you, \"<i>You got this, [name]! I’ll stay here and make sure she does not do anything stupid, but I won’t take her out just yet.</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You ask Amily if she can take care of Excellia so you can focus on fighting the Minotaur King alone.\n\n");
				outputText("Amily nods before coating her daggers in some poison, \"<i>I got this, you can count on me.</i>\"\n\n");
				outputText("She rushes through, evading the Minotaur King before throwing a knife at Excellia. Excellia stumbles back as Amily wastes no time recovering her knife while keeping up the pressure.\n\n");
				outputText("\"<i>You bitch!</i>\" Excellia shouts, trying to brush off her wound before reading herself to fight back.\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Zenji you need him to hold back Excellia so you can take care of the Minotaur Challanger.\n\n");
				outputText("Zenji nods, \"<i>Leave it ta me, champion!</i>\"\n\n");
				outputText("He readies his spear before pouncing on the bova girl, keeping her pinned beneath his weight.\n\n");
				outputText("\"<i>Stay down!</i>\" he shouts.\n\n");
				if (EngineCore.silly()) outputText("\"<i>Yes daddy, harder!</i>\" she grunts.\n\n");
				else outputText("She moans lewdly, not resisting him in the slightest.\n\n");
				outputText("\"<i>No! Bad!</i>\" Zenji retorts before knocking her out with the butt of his spear.\n\n");
				outputText("Zenji calls out to you, \"<i>I will keep dis brat down, ya can do dis, [name]!</i>\"\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You tell Zenji you need him to hold back Excellia so you can take care of the Minotaur King.\n\n");
				outputText("Zenji nods, \"<i>Leave it ta me, champion!</i>\"\n\n");
				outputText("He readies his spear before pouncing on Excellia, keeping her pinned beneath his weight.\n\n");
				outputText("\"<i>Stay down!</i>\" he shouts.\n\n");
				outputText("Excellia struggles before throwing him off, \"<i>Why don’t you make me?!</i>\"\n\n");
				outputText("Zenji chuckles, \"<i>Haha, I will den.</i>\"\n\n");
				outputText("You redirect your attention back to your fight now that they’re occupied. Now it’s just you and the Minotaur King.\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Kiha")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You tell Kiha you need her to take care of the Bova Girl so you can focus your assault on the Minotaur.\n\n");
				outputText("She scoffs teasingly, \"<i>What, an idiot like you needs a distraction. Yeah, don’t worry, I got this.</i>\" Kiha throws her weapon in the air before charging at Excellia, \"<i>Hope you like a goof fight, bitch! You sure as hell won’t stop me from getting to Lethice!</i>\"\n\n");
				outputText("The bova girl quivers as Kiha picks up her axe in mid-air, swinging it down to barely an inch from the girl’s face. The bova girl faints in distress dramatically as she brings her hand to her forehead.\n\n");
				outputText("Kiha grins as she taps her axe, \"<i>Pssh, that’s what I thought.</i>\"\n\n");
			}
			else {
				outputText("You tell Kiha you need her to take care of Excellia so you can focus your assault on the Minotaur King.\n\n");
				outputText("She scoffs teasingly, \"<i>What, an idiot like you needs a distraction. Yeah, don’t worry, I got this.</i>\" Kiha throws her weapon in the air before charging at Excellia, \"<i>Hope you like a goof fight, bitch! You sure as hell won’t stop me from getting to Lethice!</i>\"\n\n");
				outputText("Excellia quickly spins amidst the quarrel, bashing her shoulder into Kiha. The dragon-woman recoils before she catches her axe, trying to slam it down against Excellia before the woman moves out of the way, pieces of her hair sliced off from the blade.\n\n");
				outputText("Excellia grits her teeth, \"<i>Oh, it is on!</i>\"\n\n");
			}
		}
		if ((henchman == 1 && flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") || (henchman == 2 && flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia")) {
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				outputText("You look at bova girl, realizing the problem she poses. Turning to Tyrantia, you tell your amazoness to stop her from interfering.\n\n");
				outputText("Swinging her spear, Tyrantia rolls her seven working eyes. \"<i>I’m not a cattle rancher, [name]</i>\", she mutters, before giving you a thumbs-up \"<i>But that cow doesn’t stand a chance.</i>\"\n\n");
				outputText("Tyrantia charges, her spear hitting bova girl in the gut. As the bovine is stunned, Tyrantia follows through with a shoulder charge, slamming them both into a wall.\n\n");
				outputText("\"<i>Kick his ass, [name]!</i>\" She calls back, as bova girl tries to gore her. Tyrantia dodges, but the effort seems to piss her off. Tyrantia grabs bova girl by the horns, and begins to bodily toss the unfortunate bovine around like a ragdoll.\n\n");
				outputText("Now it’s just you and the Minotaur Challanger.\n\n");
			}
			else {
				outputText("You look at Excellia, realizing the problem she poses. Turning to Tyrantia, you tell your amazoness to stop her from interfering.\n\n");
				outputText("Swinging her spear, Tyrantia rolls her seven working eyes. \"<i>I’m not a cattle rancher, [name]</i>\", she mutters, before giving you a thumbs-up \"<i>But that cow doesn’t stand a chance.</i>\"\n\n");
				outputText("Tyrantia charges, her spear hitting Excellia in the gut. As the bovine is stunned, Tyrantia follows through with a shoulder charge, slamming them both into a wall.\n\n");
				outputText("\"<i>Kick his ass, [name]!</i>\" She calls back, as Excellia tries to gore her. Tyrantia dodges, but the effort seems to piss her off. Tyrantia grabs Excellia by the horns, and begins to bodily toss the unfortunate bovine around like a ragdoll.\n\n");
				outputText("Now it’s just you and the Minotaur King.\n\n");
			}
		}
		SceneLib.combat.enemyAIImpl();
	}
	public function dishHelperIL():void {
		clearOutput();
		player.createStatusEffect(StatusEffects.MinoKing,0,0,0,0);
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") {
			outputText("You tell Neisa you need her to keep the suspended angel from recovering!\n\n");
			outputText("Neisa nods, \"<i>A great stratagem, leave it to me!</i>\" She raises her shield before charging at "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", repeatedly bashing the angel with her shield to keep them out of the fight.\n\n");
			if (silly()) outputText("She speaks through her exertion, \"<i>Stop resisting! I said stop resisting! You angels think you’re so high and mighty, just above the law don’t you?!</i>\"\n\n");
			else outputText("She speaks through her exertion, \"<i>I need you to stay down!</i>\"\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") {
			outputText("You tell Etna you need her to keep the suspended angel from recovering!\n\n");
			outputText("Etna smirks, \"<i>Hmm, how long can an angel last against my tail? Time to find out!</i>\"\n\n");
			outputText("Wasting no time, The manticore leaps with a hungry lunge, diving at "+(monster.short == "Uriel"?"Gabriel":"Uriel")+" as she quickly wraps her tail around them to keep them out of the fight.\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") {
			outputText("You tell Aurora you need her to keep the suspended angel from recovering!\n\n");
			outputText("Aurora nods, raising her wings before swooping down onto "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", pinning them beneath her stone frame, keeping them out of the fight.\n\n");
			outputText("\"<i>Prevention is the best method to stop danger, now, let’s put a halt to this nuisance.</i>\"\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") {
			outputText("You tell Alvina you need her to handle one of the angels before you.\n\n");
			outputText("Alvina rolls her eyes, \"<i>Oh, why, of course… Leave me to do the dirty work.</i>\"\n\n");
			outputText("She sets down her scythe before drawing somatic symbols with a single finger. "+(monster.short == "Uriel"?"Gabriel":"Uriel")+" is imprisoned in shadowy chains as they’re thrust into the ground.\n\n");
			outputText("A faint grin curls up her face, \"<i>It’s so easy to keep them locked down…</i>\"\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi") {
			outputText("You tell Mitzi and her daughters that you need them to keep the suspended angel from recovering!\n\n");
			outputText("Mitzi raises her fist as her several daughters cheer, \"<i>Let’s get that bitch!</i>\"\n\n");
			outputText("Furxia, Lidea, Mitzi and Roxy rush "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", trapping them within their onslaught as they try to keep the angel pinned and out of the fight.\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia") {
			outputText("You tell Excellia you need her to keep the suspended angel from recovering!\n\n");
			outputText("Excellia rolls her shoulders briefly, \"<i>I can handle that easily.</i>\" Without further hesitation, she rushes in, using the weight of her body to smash into "+(monster.short == "Uriel"?"Gabriel":"Uriel")+" and keep them out of the fight.\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Amily") {
			outputText("You tell Amily you need her to keep the suspended angel from recovering!\n\n");
			outputText("Amily nods before coating a dagger in some poison, \"<i>A little more paralytic poison should do the trick…</i>\"\n\n");
			outputText("Amily quickly rushes to "+(monster.short == "Uriel"?"Gabriel":"Uriel")+" before driving her dagger into them to keep them out of the fight. \"<i>Now I just need to make sure they don’t get up… Let’s hope I have enough to last.</i>\"\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji") {
			outputText("You tell Zenji you need him to keep the suspended angel from recovering!\n\n");
			outputText("Zenji nods, \"<i>Leave it to me, champion!</i>\"\n\n");
			outputText("He readies his spear before pouncing on "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", smacking them with the blunt side of his spear to keep them out of the fight.\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha") {
			outputText("You tell Kiha you need her to keep the suspended angel from recovering!\n\n");
			outputText("She scoffs teasingly, \"<i>Oh, an idiot like you can’t manage against multiple foes? Yeah, don’t worry, I’ll totally take care of it.</i>\" Axe in hand, Kiha charges at "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", bashing the angel with the blunt side of her axe to keep them out of the fight.\n\n");
		}
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") {
			outputText("You notice the angels eyeing your Drider giantess, disgust all over their expressions. In response, you can <i>feel</i> her aura thickening, her eyes narrowing.\n\n");
			outputText("\"<i>What?!</i>\" She demands, the hairs on her legs standing straight up. \"<i>WHAT?!</i>\"\n\n");
			outputText("You point at "+(monster.short == "Uriel"?"Gabriel":"Uriel")+", telling your Amazoness that you need her to keep him down, so you can focus on the other.\n\n");
			outputText("\"<i>Oh…I am all OVER that.</i>\" Tyrantia lets out a guttural roar, shooting a glob of her “webbing” at "+(monster.short == "Uriel"?"Gabriel":"Uriel")+". The angel dodges, but her black and pink aura flares, and she rushes in, black aura hiding the angel’s light from your view.\n\n");
		}
		SceneLib.combat.enemyAIImpl();
    }
    public function gaunletchallange1fight1():void {
        clearOutput();
        outputText("You register for the gauntlet challenge, and wait patiently until you are called. You're motioned forward quickly, and move out beyond the arena gate to face your opponent. The crowd is big, you certainly have quite the audience! A man with a necktie and a weird stick screams across the area.\n\n");
        outputText("\"<i>Ladies and gentlemen! Today a new gladiator enters the arena seeking the glory of the gauntlet! A triple battle for gems and fame!</i>\"\n\n");
        outputText("The crowd cheers for you loudly.\n\n");
        outputText("\"<i>We're starting out with an old timer. Even if this is only the warm up, don't count these statues out! Beware... the Dummy golems!!!</i>\"\n\n");
        outputText("A set of walking stone statues enter the arena, ready for battle. It seems you are to fight these first.\n\n");
        player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
        startCombat(new GolemsDummy());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
    }
    public function gaunletchallange1fight2():void {
        clearOutput();
		soularenafightsbetween();
		outputText("\n\nAs the last of the golems fall down, the commentator resumes.\n\n");
        outputText("\"<i>This one is straight from the woods. Freshly caught and horny to boot. Can our champion’s strength overcome the beast’s lust? LET'S FIND OUT!!</i>\"\n\n");
        outputText("A shadow moves out behind the gate, revealing the shape of a fluid starved tentacle beast.\n\n");
        startCombat(new TentacleBeast());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
    }
    public function gaunletchallange1fight3():void {
        clearOutput();
		soularenafightsbetween();
		outputText("\n\nAs the tentacle beast whimpers and crawls away, the crowd cheers for you. Here comes the final round.\n\n");
        outputText("\"<i>This contestant is smaller than the last two... She's smarter, and most of all, extremely deadly. She’s paid a handsome sack of gems to kick the ass of anyone who reaches this stage. This femme fatale is by far the deadliest combatant of her division. The crowd favorite huntress from the dark woods... Elodie the light elf!!!</i>\"\n\n");
        outputText("A woman with light skin walks by the entrance of the arena with only a bow for a weapon. She sure does look like an elf. However, she’s nothing like the gentle creature from your childhood stories. She observes you with a cruel, calculating gaze. The light elf readies her bow, smirking.\n\n");
        flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] = 10;
		startCombat(new LightElfs());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
    }
    public function gaunletchallange1postfight():void {
        clearOutput();
        outputText("You exit the arena, victorious, basking in the cheering of the crowd and go to the prize counter for your reward. A woman greets you.\n\n");
        if (player.statusEffectv1(StatusEffects.SoulArenaGaunlets1) == 1) {
            outputText("\"<i>Good show, champion. As a reward for your performance, please accept these 15 spirit stones. Please do come back again. Might I suggest a harder gauntlet, to test your skills?</i>\"\n\n");
            player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 1, 1);
			flags[kFLAGS.SPIRIT_STONES] += 15;
            cleanupAfterCombat();
        }
        else {
            outputText("\"<i>Good show, champion. As a reward for your performance, please accept this magical bow. Please do come back again. Might I suggest a harder gauntlet, to test your skills?</i>\"\n\n");
            if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlets1)) player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 1, 2);
			else player.createStatusEffect(StatusEffects.SoulArenaGaunlets1, 2, 0, 0, 0);
            inventory.takeItem(weaponsrange.BOWGUID, cleanupAfterCombat);
        }
    }
	public function gaunletchallange2fight1():void {
		clearOutput();
		outputText("As you enter the arena you spot your opponent at the other edge of the battlefield. She's a goblin, not unlike those you've met in the wilderness, however she’s armed with a set of throwing knives and other gear you don’t see normally on those critters.\n\n");
        outputText("The voice of the announcer rings across the stadium.\n\n");
        outputText("\"<i>Ladies and gentlemans, this champion from another world has risen to challenge our second gladiatorial gauntlet! Can this would be hero defeat all three opponents? It's not just bragging rights on the line here, but also a sack full of fine gems, right from our coffers!  LET'S RUMBLE!</i>\"\n\n");
        outputText("The gates open and the goblin charges at you, weapon at the ready.\n\n");
        player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
        startCombat(new GoblinAssassin());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2fight2():void {
		clearOutput();
		soularenafightsbetween();
		outputText("\n\nAs the goblin falls unconscious to the ground the crowd cheers you on.\n\n");
        outputText("\"<i>It would seems the hero squashed that midget good, but we're only just beginning. Our next contestant has been incarcerated for daring to break the laws of our fair city! For forcing his way in, and attempting to have his way with our fairest, he'll be here for a good long time! He's been kept locked up for two consecutive months. No sex, no masturbation... and he is desperate to sow his seed...Can the challenger take him on? Or will they take him...IN?! We now release... THE HOUND!!!</i>\"\n\n");
        outputText("A hellhound of massive proportions rush out of an opening gate. Its eyes burning with lust.\n\n");
        startCombat(new HellHound());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2fight3():void {
		clearOutput();
		soularenafightsbetween();
		outputText("\n\nThe mutt falls to the floor as the crowd screams your name. The announcer announces the next contestant.\n\n");
        outputText("\"<i>The next opponent is a crowd favorite. You've heard her name told in shallow whispers. The silken jailer, the Bondswebber... The Bitch Breaker! That's right, our next opponent is an expert of the dreaded art known as BDSM. Will the challenger hold her back? Or will the Mistress claim another victim?! Please welcome...Mistress...Malady!!!</i>\"\n\n");
        outputText("A drider in a bondage suit comes out of the gate and eyes you, amused.\n\n");
        outputText("\"<i>So... you are my opponent? You don’t look like much, little pet. By the time I’m done binding you, you will be calling me mistress!</i>\"\n\n");
        startCombat(new CorruptedDrider());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2fight4():void {
		clearOutput();
		soularenafightsbetween();
		outputText("\n\nAs the drider falls defeated, the crowd cheers. That said the battle is far from over yet. A large number of shadows mass behind the opposite gate and already you can guess what's coming for you.\n\n");
        outputText("\"<i>The final contestant is both a new opponent and a test! Our resident golemancer has been cooking up something special. Using the traditional gargoyle model, deprived of a soul, only fit for mass production, these living weapons feel no pain, show no fear...and HAVE. NO. MERCY! Our challenger has broken through the competition so far, but can they break this wall of stone?</i>\"\n\n");
        outputText("A full squad of stone gargoyles pour out of the gate, their mace-like tails trailing in the sands. Their claws are sharp and their soulless gaze tells you it will end poorly should you lose.\n\n");
        startCombat(new BossGolems());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2postfight():void {
		clearOutput();
		outputText("The last gargoyle crumbles to rubble and you hold its head up toward the stands, flexing your victory. The crowd roars, and the announcer takes his stand once again.\n\n");
        outputText("\"<i>The challenger defeated all of their opponents, what a miracle! Challenger, you may now exit the arena and claim your prize, well done!</i>\"\n\n");
        outputText("You make your way towards the exit and to your surprise meet face to face with the town golemancer. She grudgingly hands you your reward.\n\n");
        outputText("\"<i>I’m supposed to reward you ");
        if (player.statusEffectv2(StatusEffects.SoulArenaGaunlets1) == 1) {
			outputText("a full chest of spirit stones. Tsk, I guess my golems were not ready yet. My future creations won't make the same mistakes.</i>\"\n\n");
			player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 2, 1);
			flags[kFLAGS.SPIRIT_STONES] += 20;
            cleanupAfterCombat();
		}
		else {
			outputText("with this scepter. Tsk, I guess my golems were not ready yet. My future creations won't make the same mistakes.</i>\"\n\n");
			player.addStatusValue(StatusEffects.SoulArenaGaunlets1, 2, 2);
			inventory.takeItem(weapons.SCECOMM, cleanupAfterCombat);
		}
	}
	public function soularenaChallengeBack():void {
		flags[kFLAGS.SPIRIT_STONES] += 3;
		statScreenRefresh();
		soularena();
	}
	public function mrsShigureLectures():void {
		menu();
		if (player.gems >= 50 && player.wis >= 10 && !player.hasPerk(PerkLib.JobSoulCultivator)) addButton(0, "1st", mrsShigureLecturesBasics).hint("Mrs. Shigure's lecture on the very basics of soul cultivation.");
		else if (player.hasPerk(PerkLib.JobSoulCultivator)) addButtonDisabled(0, "1st", "You've already learned the basics of soul cultivation.");
		else if (player.wis < 10) addButtonDisabled(0, "1st", "Your wisdom isn't high enough to grasp these concepts.");
		else addButtonDisabled(0, "1st", "You don't have enough gems to attend today's lecture.");
		if (!player.hasPerk(PerkLib.Dantain)) {
			if (flags[kFLAGS.SPIRIT_STONES] >= 5 && player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "2nd", mrsShigureLecturesFirst).hint("Mrs. Shigure's lecture on the first step of soul cultivation.");
			else addButtonDisabled(1, "2nd", "You don't have enough spirit stones (5) or not yet reached Early Soul Apprentice to listen to today's lecture.");
		}
		else if (player.hasPerk(PerkLib.Dantain)) addButtonDisabled(1, "2nd", "You've already taken the first steps of soul cultivation.");
		if (!player.hasPerk(PerkLib.SoulSense)) {
			if (flags[kFLAGS.SPIRIT_STONES] >= 10 && player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "3rd", mrsShigureLecturesSecond).hint("Mrs. Shigure's lecture on the second step of soul cultivation.");
			else addButtonDisabled(2, "3rd", "You don't have enough spirit stones (10) or not yet reached Early Soul Personage to listen to today's lecture.");
		}
		else if (player.hasPerk(PerkLib.SoulSense)) addButtonDisabled(2, "3rd", "You've already taken the second step of soul cultivation.");
		if (player.hasKeyItem("Heavenly Tribulation: Myths and Facts") < 0 && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
			if (flags[kFLAGS.SPIRIT_STONES] >= 15 && player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "4th", mrsShigureLecturesThird).hint("Mrs. Shigure's lecture on the third step of soul cultivation.");
			else addButtonDisabled(3, "4th", "You don't have enough spirit stones (15) or not yet reached Early Soul Warrior to listen to today's lecture.");
		}
		else if (player.hasKeyItem("Heavenly Tribulation: Myths and Facts") >= 0 || player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButtonDisabled(3, "4th", "You've already taken the third step of soul cultivation.");
		if (player.hasKeyItem("A summary of Marethian Sects") < 0) {
			if (flags[kFLAGS.SPIRIT_STONES] >= 20 && player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(4, "5th", mrsShigureLecturesFourth).hint("Mrs. Shigure's lecture on the fourth step of soul cultivation.");
			else addButtonDisabled(4, "5th", "You don't have enough spirit stones (20) or not surtvived your first tribulation to listen to today's lecture.");
		}
		else if (player.hasKeyItem("A summary of Marethian Sects") >= 0) addButtonDisabled(4, "5th", "You already taken the fourth step of soul cultivation.");
		if (player.hasPerk(PerkLib.Dantain)) addButton(13, "MissAkemi", missAkemiManualsShop);
		else addButtonDisabled(13, "???", "You must attend the 2nd grade of Lectures first.");
		addButton(14, "Back", soularena);
	}
	public function mrsShigureLecturesBasics():void {
		clearOutput();
		player.gems -= 50;
		outputText("After you pay the gems, a slender young Kitsune guides you to the side of the arena, into a stone building built off of it. The open space has seating for over a hundred people, and most of the seats are already filled…Especially near the front, where several students are arguing, jostling for seats at the front.\n\n");
		outputText("Not interested in the overeager students, you find a seat near the middle of the lecture hall, squeezing down in. You take your seat, listening to the murmur of the class. A few minutes later, the slender kitsune from earlier takes the stage, and speaks in a low, slightly nervous voice.\n\n");
		outputText("\"<i>Thank you for coming, everyone. Today’s lecture will begin momentarily.</i>\" Everyone turns to face the stage, the chatter coming to a dead halt. You hear footsteps from backstage, and you steel yourself, expecting a dried up old elder to take the stage. Some geezer who’s spent their entire lives in a dusty old temple, with a dry, barely audible voice. However, as your instructor steps out, you can hear a muffled gasp, then silence as many of the assembled students stop breathing.\n\n");
		outputText("Her legs, long and slender, toned with just a hint of softness, hit you first. Bare to the thigh, her pale skin reflects the light. Slowly, you move your gaze up. Her hips sway, wide and motherly, with each step she takes. Her kimono doesn’t hide the shape of her ass, large, yet firm, bouncing ever so slightly with each step she takes. Her hips, ass and legs are perfectly proportioned, almost as if chiselled by the Gods themselves.\n\n");
		outputText("To your shock, nine golden tails erupt from her back, silky fur shimmering with elegance and power. You can <i>feel</i> the magic, even from back here, light seeming to spread naturally from her tails.\n\n");
		outputText("While her chest isn’t the largest you’ve ever seen, her cleavage is substantial, and with each movement, the silk of her kimono moves, ever-so-slightly. Her fit, toned body and substantial assets give her a perfect hourglass figure. The kitsune beside her, while reasonably attractive, simply pales in comparison to this otherworldly beauty. She seems to notice that, returning to an empty seat near the front of the room.\n\n");
		outputText("She turns to face the audience, and another wave of indrawn breath sweeps through the otherwise silent auditorium, as those assembled behold her heavenly visage.\n\n");
		outputText("She has a slender raised nose, a few small, blonde whiskers on either side, a pointed chin and a slender, soft-looking neck. There were simply no flaws that one could see, her proportions strikingly feminine. Her golden eyes sweep across the gathered crowd, shimmering orbs deep with wisdom, and bright, fierce intelligence burning like an undying star. Her pale skin seems to reflect and amplify that light, smoothing what could be a piercing glare into a soft, warm radiance. Her silky-smooth hair, like woven gold, hangs down to her waist, flowing like woven gold with each movement of her head.\n\n");
		outputText("Just by standing there, she was like a fairy of the highest heavens, ethereal and ephemeral. With each movement of her eyes, she seemed to see through whatever meets her gaze. Her long and slender legs, her impeccable figure, her full curves, her proud and arrogant charisma, her gentle fingers, every part of her was like a perfect piece of artwork. She places her slender fingers on the podium, and speaks in a voice like birdsong, drawing what few gazes remained to her.\n\n");
		outputText("\"<i>Greetings everyone. You can call me Mrs. Shigure, and I will be your instructor for today. Today’s lesson is the basics of SoulForce.</i>\"\n\n");
		outputText("\"<i>Now that we've put the boring part behind us, let's begin.</i>\" kitsune walks to the podium and sits behind it. She rests an elbow on the podium, cradling her head, and crosses her legs in front of her. Moving her left hand to the side, she smirks, a small flame forming in her palm. \"<i>It's Fox Fire. An ability Kitsune can use naturally. However, to use it effectively, it requires both mana and soulforce.</i>\" She closes her hands into a fist, snuffing out the flame.\n\n");
		outputText("\"<i>But mana is not the focus of today's lesson. You all paid to learn about the other aspect of Fox-Fire. Soulforce.</i>\" She looks around gathered before asking. \"<i>Do any of you have idea what soulforce is?</i>\"\n\n");
		outputText("After a minute of silence, a lizan raises his hand. She nods, pointing at him, and he stands, stealing a glance at the kitsune's bountiful cleavage. \"<i>It's mystical energy that is purer than mana. It can be found nearly anywhere and gathered. Its users calls themself cultivators. As for the source of it that cultivators use...</i>\" ");
		outputText("Lizan stops as if trying to think about the answer. \"<i>...They use their life force.</i>\" He finaly comes with an answer and ends quite pleased with himself.\n\n");
		outputText("\"<i>Hmmmm not bad, not bad. You got most of it right.</i>\" His smile becomes wider when the kitsune slightly shakes her head. \"<i>All living beings... then what about demons?</i>\" With that his smile freezes, shrinking as he looks down at his feet. \"<i>De... mons... they...</i>\" he stutters.\n\n");
		outputText("\"<i>Oh my, are you troubled?</i>\" She smile like a vixen with her toy. \"<i>No. They would never be able to use soulforce.</i>\" She looks around all gathered. \"<i>Does anyone have idea why?</i>\"\n\n");
		outputText("Long silence fall at audience interrupted only by ocassional teacher sighs. \"<i>Nobody? Fine. It's soul. Without it demons couldn't gather soulforce like any of you could or would be able to soon.</i>\" She stood up. \"<i>Now let move on to more...practical applications.</i>\"\n\n");
		outputText("After that she started explaining how SoulForce can be detected, going over the basics of detecting the energy around you. After giving the crowd a few minutes to try, she continues, talking about the various daos, and how some students have been able to use them.\n\n");
		outputText("\"<i>From zero comes one</i>\"\n");
		outputText("\"<i>From one comes two</i>\"\n");
		outputText("\"<i>From two comes four</i>\"\n");
		outputText("\"<i>The four are expressed through the eight</i>\"\n\n");
		outputText("Class drags on for most of the hour, Ms Shigure walking between the gathered students as they practice, stopping here or there to give some more in depth explanations.\n\n");
		outputText("\"<i>Now my dear listeners, that's all I can do. While reading and lectures are a good start, the actual work must be done by each of you, in your own time. If you feel ready to start your own path, to become a Cultivator...</i>\" She returns to the podium, sitting back down. \"<i>Come here, and accept my gift. This is a basic manual for cultivation, going over meditation, energy sensing, and basic manipulation. It should be all you need to master the very basics...Should the heavens will it. Good fortune to you all.</i>\"\n\n");
		outputText("With this, she started calling each student one by one, giving them a small book, bound in an odd bamboo. Your turn comes, and you take your copy. Ms. Shigure gives you a small smile, but says nothing as you take your tome and head back to camp. You feel a buzzing in your fingers, your temples throbbing. You close your eyes, and for an instant, you feel a pulse...Was that your heartbeat...? Or...? You were there less than hour, but the foxy teacher clearly had some effect on you.\n\n");
		outputText("<b>Gained perk: Soul Cultivation\n\nGained Key Item: Cultivation Manual: Duality</b>");
		player.createKeyItem("Cultivation Manual: Duality", 0, 0, 0, 0);
		player.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
		doNext(camp.returnToCampUseFourHours);
	}
	public function mrsShigureLecturesFirst():void {
		clearOutput();
		flags[kFLAGS.SPIRIT_STONES] -= 5;
		if (player.hasPerk(PerkLib.HistoryCultivator) || (player.hasPerk(PerkLib.PastLifeCultivator) && player.hasPerk(PerkLib.JobSoulCultivator))) {
			outputText("After paying the gems you followed guidance and entered one of the arena sides where was already set up stand in the middle nad places to sit around it. Squizzing between already gathered people founded empty spot near the front and after sitting down looked toward the place where the teaching person should be. And her looks suprised you, which espected to that elder been some old geezer that will talk hadrly undenstable words.\n\n");
			outputText("An unrivalled woman that made all others feel inferior in their heart. Just by casually standing there, she was like a fairy of the highest heavens, ethereal and ephemeral. This woman had an appearance that neared perfection. She has an amazing body, silky smooth golden hair and has a voice of a lark that can instantly charm and captivate the masses, making it hard to resist her perfection.\n\n");
			outputText("She has a fine raised nose, pointed chin and a slender jade like neck. There were simply no flaws that one could see. In addition, she exuded an aura of wisdom and purity, causing an inevitable thought to enter the minds of those who set their eyes on her: A peerless beauty.\n\n");
			outputText("Her eyes were bright and deep, as if they contained undying stars.\n\n");
			outputText("Her eyes were as deep as the night skies, so profound that one could be lost in them with a single glance.\n\n");
			outputText("Her skin was flawless perfection and seemed to faintly radiate the brilliance of the moon.\n\n");
			outputText("Her face is covered in a strange wave light energy, making her seem dreamy and mysterious.\n\n");
			outputText("Her body was covered in mysteries, making one forever unable to see her goals.\n\n");
			outputText("Her long and slender legs, her impeccable figure, her full curves, her proud and arrogant charisma, her gentle fingers, every part of her was like a perfect piece of artwork.\n\n");
			outputText("\"<i>Greetings, everyone. You can call me Shigure, Mrs. Shigure and I will talk today about basic as in really basics.</i>\" Elder in lead of the lecture introduce herself after making sure pay attention to her.\n\n");
		}
		else {
			outputText("\"<i>Greetings, everyone. Thank you for attending today’s lecture.</i>\" Mrs. Shigure warmly greets everyone before proceeding.\n\n");
		}
		outputText("\"<i>I see a few familiar faces today,</i>\" she says casually. Following her gaze you notice a certain lizan student from before, who blushes at her attention. \"<i>I congratulate you all. You've awoken your SoulForce. You can sense the energy around you, and took your first steps along the Cultivator's path. Do any of you know the subject of today's lesson?</i>\"\n\n");
		outputText("The students begin murmuring, looking between themselves, but nobody answers. After five minutes, the curvy kitsune claps her hands. \"<i>Eyes on me, please. </i>\" No few students didn't need the prompt, shamelessly staring at her, but the chatter around the room stops.\n\n");
		outputText("\"<i>Today's lecture is on the different fields of study. Now that you've awoken your SoulForce, many paths have opened up for you. Not all cultivators follow the same path and honestly...</i>\" she takes a breath, looking at the assembled students. \"<i>there are many paths to tread. Each of you will walk a different path, at your own pace, for as no two souls are the same, the paths we tread differ. But I digress, there are a few areas in which most souls gather. Three, to be exact. Three categories of discipline that encompass the paths that most cultivators take.</i>\" She motions with one hand, pointing to the back of the room. You turn to see three people stand, gracefully making their way to the stage. A white-furred wolf, a buxom lacta bovine, and a smaller, thinner raccoon-morph. They take a position next to her, and she motions to the Wolf.\n\n");
		outputText("\"<i>My first assistant here is to demonstrate the most common, well-trodden path. He decided to develop his abilties of soulforce manipulation. It's the easiest path for most, especially those with experience in the mystic arts, and is especially popular among the Lizans, Unicorns, Nekomata, and my own race, the Kitsunes. This discipline focuses on manipulating the energy around them, not unlike more classic mages. </i>\" She motions, and the Winter Wolf raises his hands, spreading his arms wide. Etherial blades form above him, and with a flick of his hands, they spin, slicing the air with rapid strokes. He flicks his hands again, and the blades erupt into flame before vanishing. Several students clap, and he smiles slightly, bowing respectfully. Ms Shigure shakes her head, a small smile on her face. \"<i>We call that the Daoist's path.</i>\" She then turns to the second one.\n\n");
		outputText("\"<i>Our bovine friend here decided to focus on her body instead. This path doesn't focus on manipulation, like the Daoists. Her energy isn't as fluid, or controlled... but instead, she draws the energy in, focusing it into her body. </i>\" Ms Shigure motions again, and two assistants drag a stone pillar in, placing it in front of the bovine. \"<i>This, of course, allows for physical abilities that the Daoists couldn't hope to match.</i>\" The bovine woman grins, bringing her hand down upon the top of the stone pillar. The rock splinters, shards of stone showering the stage with shards. The muscular woman doesn't seem effected in the slightest by the stone shards now embedded in her kimono, and as another round of applause breaks out, she chuckles and grins, scratching the back of her head. Ms Shigure looks out at the assembled students, motioning to her assistant. \"<i>This is the path of Body Cultivation. It tends to be popular among races with already impressive physicality, such as the Oni, Minotaur, Lacta-Bovine and Orca races.</i>\" The Lacta Bovina steps back, leaving the last assistant standing with Ms. Shigure.\n\n");
		outputText("\"<i>This cultivator didn't pick the previous paths. Scholars have been arguing for centuries, as to which path is more demanding, this, or the Body Cultivator's path. He's developing heartforce, focusing on the mind and mental state. Some say it's pure willpower, unlike the esoteric nature of daoist magic or body cultivators raw physicality. Such cultivators we calls Heartforce Cultivators.</i>\" She motions, and an etherial white tiger forms around the raccoon-morph. He grins as several snakes erupt from his arms, sending a slight shock through the crowd. The animals bare their fangs, before fading away.\n\n");
		outputText("With all three introduced, ms Shigure spends the next ten or so minutes explaining each path a little more in-depth, going over each path's basic strengths and weaknesses.\n\n");
		outputText("\"<i>Now that we all should have a decent grasp of the basics, after this lecture you can buy manuals. These study guides will help you take the first steps along your path.</i>\" She then points to the young kitsune that sits at a small table in the back of the hall. \"<i>Miss Akemi will be happy to sell you the study materials you need. Good luck on your chosen paths.</i>\"\n\n");
		outputText("\"<i>Let get to the last part of today's lecture.</i>\" Shigure claps her hands, waiting for a moment as the students focus back on her. She gives a few Kitsune in the crowd small glances, her tails flicking as she burns her gaze in, licking her lips hungrily before moving to the next.\n\n");
		outputText("\"<i>No matter which path you walk, there are some basics that every cultivator should know. Each of us have special regions in our bodies where soulforce gathers. We call such regions dantian. We shall now learn simple techniques to allow you all to feel your Dantain, and start to tap into the flow of your SoulForce.</i>\"\n\n");
		outputText("Few next minutes she goes over the Dantain regions, and where they tend to be on different races. With a single warning of the dangers of overusing SoulForce, she steps down from the podium, telling the assembled students to tap into their Dantain. For two hours she slides gracefully from student to student, correcting postures, massaging temples, and demonstrating the technique for small groups of students. She sighs at the end of the two hours,taking the podium and clearing her throat. It takes mere seconds for attention to focus back on her, and she smiles.\n\n");
		outputText("\"<i>Good work, everyone, we're done for today.  Rest, don't feel discouraged if you didn't get it, and train when you're able. I'll see you all again at the next lesson.</i>\" She says a few more pleasantries before walking offstage, leaving you and the rest of the students to leave.\n\n");
		outputText("<b>Gained perk: Dantian</b>");
		player.createPerk(PerkLib.Dantain, 0, 0, 0, 0);
		doNext(camp.returnToCampUseFourHours);
	}
	public function mrsShigureLecturesSecond():void {
		clearOutput();
		flags[kFLAGS.SPIRIT_STONES] -= 10;
		outputText("\"<i>Greetings, everyone. Another meeting with so many of you. One would think I’d start remembering your names, right?</i>\" Shigure cracks a small joke to lighten the mood.\n\n");
		outputText("\"<i>It's good to see so many of you have continued on your path into SoulForce, and are still getting value out of my lectures. Or maybe you come here for different reasons...</i>\" Shigure says, looking down at her gown, which has slipped aside, showing her shapely thighs. As it slips further, nearly giving you (and everyone else) a glance at her womanhood, she winks, covering herself again.\n\n");
		outputText("\"<i>Being here today means you all managed to ascend above the level of Soul Apprentice. I expect that my techniques were helpful, considering most of you returned.</i>\" She nods and then turns around, giving everyone a good look at her shapely back and tails as she reaches for some small booklet.\n\n");
		outputText("\"<i>Now some of you may start to feel your...powers...growing. </i>\" She gives that Lizan from before a direct look. \"<i> You may feel confident in your power, from training, or perhaps from besting your peers. You can feel your SoulForce expanding, your skills rising, and you may feel ready to test yourself.</i>\" She smiles down at her students. \"<i>It's a wonderful feeling, being able to better yourself, to feel the power thrumming inside you...</i>\" Her smile fades, and she looks down sternly.  \"<i>unless it gets to your head. The path of the cultivator is a path to power, but it is by no means the only one to walk. Confidence can easily lead to arrogance. And that is what can fell even the strongest, the most skilled... Many, so many of our people have fallen victim to such. Some, we were able to find, to recover.</i>\" She looks up, eyes somber. \"<i> But most end up as some demon's sex toy, or worse...</i>\" she sighs, cutting herself off and breathing deeply. \"<i>Mareth is not forgiving, students. If you learn nothing else here, learn that the world is dangerous, especially for the weak or the foolish.</i>\" ");
		outputText("She then looks at the ground, \"<i>Mareth is not just a place of demons and lunatics. There are much worse things buried below this land, ancient powers which you would never wish to let...Stir.</i>\" Shigure shudders, letting the silence build. Suddenly, she claps her hands, popping upright and sending her breasts jiggling.\n\n");
		outputText("\"<i>Anyways, enough of that. For now, you don't need to worry about such things. They're well outside your grasp...However, I think something new is in order. A skill using your SoulForce. Not only is this skill convenient in your everyday life, but it's a very useful way to train at your level, and save some time and effort as well. It's called Soul Sense.</i>\" She looks over the audience. \"<i>Is anyone already familiar with this technique?</i>\" She waits for few minutes but noone speaks.\n\n");
		outputText("\"<i>Well then, since nobody here has prior knowledge and the willingness to share, I shall explain it personally.</i>\" She sighs a bit, as if expected someone to step up. What follows is a lengthy explanation, a bit different form previous lectures, that relay lots of vital information about what soul sense is and what it could be used for. \"<i>My personal favorite use for Soul Sense is outside the walls of our fair city. Many odd traders and friendly souls still wander Mareth, and once you get to know these people, you can use your Soul Sense to easily find them again, avoiding the need for a potentially dangerous search.</i>\" ");
		outputText("\"<i> This technique is limited, however, in its scope. Someone with a weak soul would be harder to detect, and there are techniques to prevent this skill from finding you, should you wish to remain hidden. Most importantly, things...or creatures...Without a soul cannot be found using soul sense. While this may be inconvenient, should you wish to find a lost object, more importantly, this skill cannot be used to find demons.</i>\" She shrugs. \"<i>Although why you would be searching for such creatures, I have no idea.</i>\" The busty Kitsune taps her podium with a finger, and a few students in front, including that Lizan from earlier, begin passing out small manuals. Once everyone's been handed one, they sit back down, and Ms. Shigure smiles.\n\n");
		outputText("\"<i>I hope everyone found that lesson informative, and I expect to feel your SoulForce in the future, out in Mareth. Our next lesson will be about the various trials set before each of you. As cultivators, you will find your power plateau, and stagnate...Unless you take on said trials, and survive. </i>\" She makes a deep bow, allowing those in first rows see very deep into her bountiful cleavage. \"<i>Stay safe, and come back to me, my students.</i>\"\n\n");
		outputText("<b>Gained Key Item: 'Soul Sense and You' Manual</b>");
		player.createKeyItem("'Soul Sense and You' Manual", 0, 0, 0, 0);
		doNext(camp.returnToCampUseTwoHours);
	}
	public function mrsShigureLecturesThird():void {
		clearOutput();
		flags[kFLAGS.SPIRIT_STONES] -= 15;
		outputText("\"<i>Greetings, everyone. The Head Elder decided that I should be responsible for today’s lecture again. Honestly, I’m not sure whether he thinks he’s punishing me, or rewarding me. </i>\" Shigure cracks up, and chuckles fill the auditorium.\n\n");
		outputText("\"<i>Today we shall discuss tribulations. It's something that each of us must face in their life at least once. If you feel you're unable to pass even the most basic of tribulations, it may been a mistake to even start. Not all are cut out for the cultivator's path.</i>\" She sits comfortably behind the desk, tails swishing as she looks out on her students.\n\n");
		outputText("\"<i>Each time us cultivators face a trial, the objective is simple. The world around you will hold nothing back, and you must not either. To pass is to live. To fail...is to die.</i>\" A few students' eyes widen, and several more murmur, seemingly shocked. \"<i>Please, students. Nothing in this world is risk-free.</i>\" She sighs. \"<i>While it is a risk, one could easily argue that every day on Mareth is its own trial, nowadays. And when a cultivator passes, they will be rewarded, not only with possibility to progress further on the endless road, but maybe even gain something else, something...special.</i>\" She looks over the gathered before continuing.\n\n");
		outputText("\"<i>However, survival isn't always your only focus in such a trial. While risky, it'\s sometimes possible to fight back, rather than simply surviving the trial. While it can leave you vulnerable, should you fail, a cultivator will often gain more by excelling at a trial, defeating it outright, as opposed to simply surviving.</i>\" At that moment some lizan interrupts, raising his hand.\n\n");
		outputText("\"<i> Ms. Shigure, are you speaking from experience? Or is this word of mouth from other cultivators?</i>\"\n\n");
		outputText("\"<i>Hmmmm...</i>\" she pauses, giving the Lizan a favorable smile. \"<i>Yes, I speak from experience. While my first tribulation, I simply sought to live, my subsequent trials were...easier for me. When I realized this, I took a more aggressive approach, dispelling the clouds with my own power. </i>\" She continues the lecture, describing what happened during her tribulations, and those of other cultivators. From there, she moves on to practical matters,  describing the tribulation's lightning, and how a cultivator could avoid or defend against such attacks.\n\n");
		outputText("\"<i>When the time will come each of you should feel the approaching tribulation. Some feel it in their Dantain, others have noted a strong metallic smell in the air. Luckily for us, it takes time to build up a proper storm... well beside some rare, extreme, cases, it would take a few hours, at least. So be sure to find a good, open place to face it. Ahh and be careful to not involve others in your trial. Tribulations tend to get much harder if more than one cultivator faces it. Pets or minions should be fine, but trials are unfortunately not group projects.</i>\"\n\n");
		outputText("The lecture continues for the next hour or so, as your busty teacher speaks in detail about her own tribulations, also using the words and stories from other cultivators. <i>While my second trial was like the first, a heavenly storm, Elder Namaste had a surge of water rise, nearly drowning him. Elder Lemouse, on the other hand, had a volcano erupt, spreading sacred ash around that slowed his movements, while also raining droplets of magma. </i>\n\n");
		outputText("\"<i>At the ending i would like to once again bestow you all with a small blessing, in the form of this humble manual. Inside is all the knowledge in today's lecture, for those of you who didn't take notes already. </i>\" This gets a few chuckles. \"<i> I hope to see you all at my next lecture. I assume none of you will have an issue surviving your first tribulation.</i>\" With that, Ms. Shigure turns, sending her gown fluttering up and giving you all a long look at her legs and tails as she walks away. A few students take the stage as she leaves, taking the manuals from her desk and passing them out.\n\n");
		outputText("<b>Gained Key Item: Heavenly Tribulation: Myths and Facts</b>");
		player.createKeyItem("Heavenly Tribulation: Myths and Facts", 0, 0, 0, 0);
		doNext(camp.returnToCampUseTwoHours);
	}

	public function mrsShigureLecturesFourth():void {
		clearOutput();
		flags[kFLAGS.SPIRIT_STONES] -= 20;
		outputText("\"<i>Greetings, everyone. Is it just me, or does it smell like Ozone in here? It’s like every single one of you has been hit by lightning recently. </i>\" She waves her hand daintily in front of her nose, getting some laughs.\n\n");
		outputText("\"<i>Congratulations everyone! From the feel of you, everyone here has survived your first tribulation.</i>\" She gives you a few claps, and some students join in, a small token applause echoing around the lecture hall. She sternly stares at those clapping, flicking her tails as a small scowl forms on her face. \"<i>Don't let it go to your heads. This was by far the easiest trial, and there will be more.</i>\" She inhales deeply, nodding sagely.  \"<i>After each of the three major levels of Cultivation, there will be another trial.</i>\" There are a few gasps, some groans, and she stares those students down, golden eyes deadly serious. \"<i>Three heavenly trials to pass, getting stronger as you do. No matter how powerful you feel, remember that your Tribulation will rise to meet you, no matter what.</i>\"\n\n");
		outputText("\"<i>Now some of you may feel a stronger connection to some of the world's energies. We call such energy Dao, and you can find it in nearly anything. From the sky, the ground or even living beings, almost everything has a Dao. Some races, such as the Salamanders or Ice Wolves, have a natural affinity to their element. This makes it easier to comprehend, and makes that form of elemental dao easier for them to work with. So, for those of you without such natural advantages, don't be afraid to spend some time working with elemental energies. Such efforts can give you increased damage with that element, and");
		outputText(" even some minor protection from it. But the last part may be not noticable until ending early stages of comprehension.</i>\" She continue her explanations on elemental daos giving even some examples.\n\n");
		outputText("\"<i>Second matter I would like to mention is sects. Some maybe heard about them or maybe not. In simpler words it's groups of similar minded cultivators with patriarch leader, it direct subordinates like elders and common members been disciplines. Now that you all have passed your first major trial, you could try joining a cultivator sect. Naturally, joining one would reduce the freedom you enjoy now as rogue cultivators but there are benefits to membership. Joining a sect will give access to better materials or ");
		outputText("various manuals. Some will even fight alongside their members, granting some measure of protection. I must warn you, however, of some of the dangers of being in such an alliance.</i>\" The busty kitsune sighs, leaning on her podium. \"<i> While we cultivators are wiser than most...or so we like to think</i>\". This gets a few chuckles. \"<i>Unfortunately, we fight like any other mortals. Many sects have rivalries, alliances or even hatred, bad blood that only gets put aside when everything we all love is at stake.</i>\" She lowers her head, and drops her voice, closing her golden eyes. \"<i>One of the only times we've ever united the sects...Was the war that shall not be named.</i>\" Shigure visibly shivers, revealing a vulnerable side for the first time. \"<i>As cultivators, we can draw power from our surroundings, strength from the earth itself, and take to the sky...But even the mightiest of us can be felled by numbers. As it was against the demons.</i>\" She opens her eyes, tails glowing orange. ");
		outputText("\"<i>After the goblin city fell, the council of the State of Azoh called for us, everyone who could fight...and we answered, souls blazing. While we were outnumbered, hundreds to one, the demons were not strong individually, and our Dao hearts were firm.</i>\" Ms. Shigure inhales, shaking her head. \"<i>...Too firm. We were so focused on the battle, on stopping those monstrosities...that we drew power from the land, more than it could sustain. Inch by inch, the land was robbed of power, of the SoulForce around it...To say nothing of what the demons did.\"</i> Ms. Shigure grips the podium with both hands, her golden tails limp. \"<i>You younger ones likely know this blighted place only as 'The Battlefield'...But now you know of its true story...And hopefully, you learn from our mistakes.</i>\" The younger Kitsune assistant puts a hand on Ms. Shigure's shoulder, and she shudders, visibly pulling herself back together. \"<i>Anyways, let's get into more lighthearted topics, shall we?</i>\" She goes on for another ten to twenty minutes talking about the various benefits or obligations that comes with several different sects of cultivators.\n\n");
		outputText("\"<i>As a parting gift, since this is our last lecture, I would like to give you all this small booklet. Inside is a pamphlet for most of our local sects. And if fate allows, we may meet again somewhere in State of Azoh. May your dao be endless,</i>\" with this she ends lecture and leaves, waving goodbye.\n\n");
		outputText("<b>Gained Key Item: A summary of Marethian Sects</b>");
		player.createKeyItem("A summary of Marethian Sects", 0, 0, 0, 0);
		doNext(camp.returnToCampUseFourHours);
	}
	public function missAkemiManualsShop():void {
		clearOutput();
		outputText("\"<i>Five Spirit Stones per manual.</i>\" From the look in her young eyes, you can tell that trying to haggle would be a poor decision.\n\n");
		menu();
		addButtonIfTrue(0, "Daoist", missAkemiManualsShopDaoist, "You already bought this manual.", player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") < 0);
		addButtonIfTrue(1, "BodyCult", missAkemiManualsShopBodyCultivator, "You already bought this manual.", player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") < 0);
		//addButtonIfTrue(2, "HeartCult", missAkemiManualsShopHeartforceCultivator, "You already bought this manual.", player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") < 0);
		addButton(4, "Back", mrsShigureLectures);
	}
	public function missAkemiManualsShopDaoist():void {
		if (flags[kFLAGS.SPIRIT_STONES] < 5) {
			outputText("\"<i>I sincerely hope you're joking. Please try to remember our prices, okay? Five spirit stones. No more, no less.</i> She seems genuinely concerned for your well-being. You blush, slightly embarassed by her sincerity\"\n\n");
			doNext(missAkemiManualsShop);
			return;
		}
		flags[kFLAGS.SPIRIT_STONES] -= 5;
		outputText("\"<i>You like sticks, do you?</i>\" she teases, sticking her tongue out as she hands over the manual.\n\n");
		outputText("<b>Gained Key Item: Cultivation Manual: My Dao Sticks are better than Yours</b>");
		player.createKeyItem("Cultivation Manual: My Dao Sticks are better than Yours", 0, 0, 0, 0);
		doNext(missAkemiManualsShop);
	}
	public function missAkemiManualsShopBodyCultivator():void {
		if (flags[kFLAGS.SPIRIT_STONES] < 5) {
			outputText("\"<i>I sincerely hope you're joking. Please try to remember our prices, okay? Five spirit stones. No more, no less.</i> She seems genuinely concerned for your well-being. You blush, slightly embarassed by her sincerity\"\n\n");
			doNext(missAkemiManualsShop);
			return;
		}
		flags[kFLAGS.SPIRIT_STONES] -= 5;
		outputText("\"<i>So you're into Coke Demons.... er... Fiends?</i>\" she eyes you suspisciously as she passes over the tome.\n\n");
		outputText("<b>Gained Key Item: Cultivation Manual: Body like a Coke Fiend</b>");
		player.createKeyItem("Cultivation Manual: Body like a Coke Fiend", 0, 0, 0, 0);
		doNext(missAkemiManualsShop);
	}
	public function missAkemiManualsShopHeartforceCultivator():void {
		if (flags[kFLAGS.SPIRIT_STONES] < 5) {
			outputText("\"<i><i>I sincerely hope you're joking. Please try to remember our prices, okay? Five spirit stones. No more, no less.</i> She seems genuinely concerned for your well-being. You blush, slightly embarassed by her sincerity\"</i>\"\n\n");
			doNext(missAkemiManualsShop);
			return;
		}
		flags[kFLAGS.SPIRIT_STONES] -= 5;
		outputText("\"<i>Watch out for their eyes... the upper ones at least,</i>\" she says somberly, handing over the manual.\n\n");
		outputText("<b>Gained Key Item: Cultivation Manual: Heart-shaped Eyed She-Devil</b>");
		player.createKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil", 0, 0, 0, 0);
		doNext(missAkemiManualsShop);
	}

	private function golemancershop():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.GolemancerShop)) {
			outputText("The goblin golemancer answers at the counter as you walk in.\n\n");
			outputText("\"<i>What spicing will it be?</i>\"");
		}
		else {
			outputText("You enter a shop filled with what appears to be stone body parts, strange arcanic objects and other items needed to craft golems. A small goblin answers at the counter, slightly annoyed at having to pause her work.\n\n");
			outputText("\"<i>Welcome to my shop " + player.mf("mister", "miss") + ", what are ya here to buy?</i>\"");
			player.createStatusEffect(StatusEffects.GolemancerShop, 0, 0, 0, 0);
		}
		golemancershop1();
	}
	private function golemancershopRepeat():void {
		clearOutput();
		outputText("\"<i>Came here to buy, huh? I thought so. Show me the stones.</i>\"");
		golemancershop1();
	}
	private function golemancershop1():void {
		menu();
		if (player.hasPerk(PerkLib.AdvancedGolemancyTheory) || player.hasPerk(PerkLib.EpicGolemMaker)) addButton(0, "Energy Core", buyItemEnergyCore).hint("A power source for devices.");
		else addButtonDisabled(0, "???", "Items only for Epic Golemancer users or possesing Advanced Golemancy Theory knowledge.");
		if (player.hasPerk(PerkLib.EpicGolemMaker)) addButton(1, "Mechanism", buyItemMechanism).hint("A complex set of gears and gyros.");
		else addButtonDisabled(1, "???", "Items only for Epic Golemancer users.");
		addButton(5, "G.Rod", buyItem, weapons.G_ROD).hint("Golemancer Rod");
		addButton(6, "G.E.Man", buyItem, weaponsrange.G_E_MAN).hint("Golemancy Evocation Manuscript");
		addButton(7, "Y.U.Panel", buyItem, shields.Y_U_PAN).hint("Yogi Uh Panel");
		if (player.hasPerk(PerkLib.MasterGolemMaker)) {
			if (player.hasKeyItem("Golems, Animations and You") >= 0) addButtonDisabled(12, "G,A&Y Man.", "You already bought 'Golems, Animation and You' manual.");
			else addButton(12, "G,A&Y Man.", golemancershopPermGolemsUpgradesGuide).hint("Buy 'Golems, Animation and You' manual to make golems great again.");
		}
		else addButtonDisabled(12, "???", "Req. Master Golem Maker perk.");
		if (player.hasPerk(PerkLib.JobGolemancer)) {
			if (player.hasPerk(PerkLib.MasterGolemMaker)) addButtonDisabled(13, "'Free Cores?'", "How could such an esteemed golemancer like you ask for freebies? Go smash a few golems to take their cores instead to try beg her...");
			else {
				if (player.statusEffectv1(StatusEffects.GolemancerShop) == 0) addButton(13, "'Free Cores?'", golemancershopNotSoFreeCores).hint("A dark side of you whispers: 'Dew it!!! Press this button!!! Dew it now!!!'");
				else addButtonDisabled(13, "'Free Cores?'", "You already pressed the button'. No more freebies for ya...");
			}
		}
		addButton(14, "Leave", riverislandVillageStuff);
	}
	private function golemancershopNotSoFreeCores():void {
		clearOutput();
		outputText("You ask if the goblin would have any free supplies for a fellow golemancer.\n\n");
		outputText("\"<i>Well as a matter of fact, I do. I give these away for first timers. You can have one and only one of those packages, got to keep myself competitive after all. <b>Still, you owe me one.</b></i>\"\n\n");
		outputText("<b>You have now 15 golem cores in your bag for making new golems!</b>\n\n");
		player.addStatusValue(StatusEffects.GolemancerShop, 1, 1);
		flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 15;
		doNext(golemancershopRepeat);
	}
	private function golemancershopPermGolemsUpgradesGuide():void {
		clearOutput();
		outputText("You would like to buy a 'Golems, Animation and You' manual from her if she has one.\n\n");
		outputText("\"<i>As it happens, yes. I have exactly one. It won't come cheap. ");
		menu();
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 1) {
			outputText("3000 gems and it's yours, how's that for a price?</i>\"");
			if (player.gems >= 3000) addButton(1, "Buy", golemancershopPermGolemsUpgradesGuideYes);
			else addButtonDisabled(1, "Buy", "You do not have enough gems to buy this.");
		}
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 0) {
			outputText("Come to think of it, you have been a very faithful customer... So I'll give you a one time deal. 500 gems and it's yours.</i>\"");
			if (player.gems >= 500) addButton(1, "Buy", golemancershopPermGolemsUpgradesGuideYes);
			else addButtonDisabled(1, "Buy", "You don't have enough gems to buy this.");
		}
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function golemancershopPermGolemsUpgradesGuideYes():void {
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 1) player.gems -= 3000;
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 0) player.gems -= 500;
		statScreenRefresh();
		outputText("She counts the gems before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business, anything else you want to buy?</i>\"\n\n");
		player.createStatusEffect(StatusEffects.GolemUpgrades1, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.GolemUpgrades2, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.GolemUpgrades3, 0, 0, 0, 0);
		player.createKeyItem("Golems, Animations and You", 0, 0, 0, 0);
		doNext(golemancershopRepeat);
	}
	private function buyItemEnergyCore():void {
		clearOutput();
		var cost:int = 520 / 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) cost *= 0.5;
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else if (CampStatsAndResources.EnergyCoreResc >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
		else addButton(1, "Buy", curry(buyItemEnergyCoreYes, cost));
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemEnergyCoreYes(cost:Number):void {
		flags[kFLAGS.SPIRIT_STONES] -= cost;
		statScreenRefresh();
		outputText("She counts the stones before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business, anything else you want to buy?</i>\"\n\n");
		CampStatsAndResources.EnergyCoreResc++;
		doNext(golemancershopRepeat);
	}
	private function buyItemMechanism():void {
		clearOutput();
		var cost:int = 700 / 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) cost *= 0.5;
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else if (CampStatsAndResources.MechanismResc >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
		else addButton(1, "Buy", curry(buyItemMechanismYes, cost));
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemMechanismYes(cost:Number):void {
		flags[kFLAGS.SPIRIT_STONES] -= cost;
		statScreenRefresh();
		outputText("She counts the stones before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business, anything else you want to buy?</i>\"\n\n");
		CampStatsAndResources.MechanismResc++;
		doNext(golemancershopRepeat);
	}
	private function buyItem(odd:ItemType):void {
		clearOutput();
		var cost:int = odd.value / 5;
		if (player.hasPerk(PerkLib.MasterGolemMaker)) cost *= 0.5;
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else addButton(1, "Buy", curry(buyItemYes,odd,cost));
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemYes(odd:ItemType, cost:Number):void {
		flags[kFLAGS.SPIRIT_STONES] -= cost;
		statScreenRefresh();
		outputText("She counts the stones before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business: Anything else you want to buy?</i>\"\n\n");
		inventory.takeItem(odd, golemancershopRepeat);
	}

    public function restaurantShiraOfTheEast():void {
        clearOutput();
        outputText("You arrive at the exotic food restaurant, ‘Shira of the east’ and look at the menu posted on the outside. Would you like get something to eat?");
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) flags[kFLAGS.CHI_CHI_FOLLOWER] = 1;
        menu();
        addButton(0, "Yes", restaurant,true);
        addButton(1, "No", restaurant,false);
    }
    private function restaurant(selected:Boolean):void {
        if(!selected){
            outputText(" You aren’t hungry right now, maybe you can come back to eat later?");
            doNext(riverislandVillageStuff);
            return;
        } else if (flags[kFLAGS.SPIRIT_STONES] < 1){
            outputText(" You would like to eat but you don’t have enough spirit stones to afford it.");
            doNext(riverislandVillageStuff);
            return;
        }
        clearOutput();
        outputText("You take a seat and look at the menu. ");
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff) || SceneLib.chichiScene.ChiChiKickedOut) outputText("A dog morph that looks like a pekinese comes over to take your order.");
        else outputText("A literally blazing mouse girl come over to take your order. Her arms, legs and even her tail are on fire. ");
        outputText("\n\n\"<i>Hello my name is ");
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff) || SceneLib.chichiScene.ChiChiKickedOut) outputText("Rin");
        else outputText("Chi Chi");
        outputText(" and I will be your waitress today. We have dumplings, Won ton soup and ramen, offered in mild, spicy and inferno versions of the dishes. What will it be?</i>\"");
        menu();
        addButton(0, "Dumpling", orderFood,0,5,0).hint("Effects: +Spe, +Tou", "Dumpling");
        addButton(1, "Soup", orderFood,0,0,5).hint("Effects: +Int, +Tou", "Soup");
        addButton(2, "Ramen", orderFood,5,0,0).hint("Effects: +Str, +Tou", "Ramen");
    }
    private function orderFood(str:int,spe:int,inte:int,tou:int=5):void{
        outputText("\n\nShe notes your order on a piece of paper.");
        outputText("\n\n\"<i>How spicy would you like it to be?</i>\"");
        player.removeStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1);
        player.createStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1, 25, 0, 0, 0);
        player.buff("ShiraOfTheEastFoodBuff").remove();
        player.buff("ShiraOfTheEastFoodBuff")
            .setStats( { "str": str, "spe": spe, "int": inte, "tou": tou })
            .withText("Restaurant meals!"); //no timer - removed in events with the status effect

        menu();
        addButton(0, "Mild", restaurantSpicing,"mild");
        addButton(1, "Spicy", restaurantSpicing,"spicy");
        addButton(2, "Inferno", restaurantSpicing,"inferno");
    }

    private function restaurantSpicing(level:String):void{
        outputText("\n\nShe finishs noting your order, bows graciously then heads to the kitchen. ");
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff) || SceneLib.chichiScene.ChiChiKickedOut) outputText("The waitress");
        else outputText("Chi Chi");
        outputText(" comes back with your order a few minutes later.");
        switch(level){
            case "mild":
				outputText("\n\nThe meal is comforting. Its refreshing nature will likely help you resist heat for now.");
				player.addStatusValue(StatusEffects.ShiraOfTheEastFoodBuff1, 2, 30);
				break;
            case "spicy":
				outputText("\n\nThe meal is a little spicy, but it leaves you feeling fortified. The weather won’t feel as harsh to you today.");
				player.addStatusValue(StatusEffects.ShiraOfTheEastFoodBuff1, 2, 15);
				player.addStatusValue(StatusEffects.ShiraOfTheEastFoodBuff1, 3, 15);
				break;
            case "inferno":
				outputText("\n\nWow, the meal is so spicy you almost breathe fire. You gulp down several glasses of water but still start to sweat as your inner temperature rises. It’s likely you won’t have much to fear from the cold for now.");
				player.addStatusValue(StatusEffects.ShiraOfTheEastFoodBuff1, 3, 30);
				break;
        }
        outputText("\n\nRegardless, the food is excellent and you leave in high spirits. You hadn't expected to find something so delicious in this realm.");
        flags[kFLAGS.SPIRIT_STONES]--;
		player.refillHunger(100);
        statScreenRefresh();
        doNext(camp.returnToCampUseOneHour);
    }
}
}