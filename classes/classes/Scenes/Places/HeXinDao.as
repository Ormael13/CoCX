/**
 * ...
 * @author Ormael
 *
 * Simple village for soul cultivators He'Xin'Dao - River Island
 */

package classes.Scenes.Places {

import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Scenes.Areas.Forest.TentacleBeast;
import classes.Scenes.Areas.Mountain.HellHound;
import classes.Scenes.Areas.Swamp.CorruptedDrider;
import classes.Scenes.Dungeons.HiddenCave.BossGolems;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.NPCs.NeisaFollower;
import classes.Scenes.Places.HeXinDao.*;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.Asuka;
import classes.Scenes.NPCs.Jeniffer;
import classes.Scenes.NPCs.ChiChiFollower;
import classes.Scenes.NPCs.Jinx;
import classes.Scenes.NPCs.Syth;
import classes.Scenes.NPCs.Rangiku;
import classes.Scenes.NPCs.Veronika;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;

public class HeXinDao extends BaseContent
{
    public var ignisarenaseer:IgnisArenaSeerScene = new IgnisArenaSeerScene();
    public var neisaScene:NeisaFollower = new NeisaFollower();
    public var chichiScene:ChiChiFollower = new ChiChiFollower();
    public var riverdungeon:RiverDungeon = new RiverDungeon();
	public var eraendirorsbulg:EraendirAndOrsbulg = new EraendirAndOrsbulg();

    public function HeXinDao() {}
	
	public function riverislandVillageStuff0():void {
		spriteSelect(null);
        clearOutput();
		if (isLunarNewYear()) {
			outputText("As you enter the town you notice something out of the norm. It would seem the citizens are celebrating something. The streets are covered with decorations. Bright red drapes hang off almost every building, yellow paper lanterns dangle from lines tossed between the buildings, and simple stalls have been set up, selling festively colored trinkets. A parade winds through the streets, with a giant snake-like Muppet at the center of it. He’Xin’Dao is in the middle of a massive festival. Would you like to join in?");
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
        outputText("You go deeper in town and discover the whole place is indeed covered in red. The big question now is what should you check upon first?");
		menu();
		if (!player.hasStatusEffect(StatusEffects.CanGetLunarGift)) addButton(0, "Gifts", riverislandVillageStuffLunarGifts);
		addButton(1, "Food", riverislandVillageStuffLunarFood);
		addButton(2, "Clothing", riverislandVillageStuffLunarClothing);
		if (model.time.hours > 19) addButton(3, "Fireworks", riverislandVillageStuffLunarFireworks);
		else addButtonDisabled(3, "Fireworks", "You need to wait till 8 PM for that.");
		if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 20 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 2 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && model.time.hours > 17) addButton(4, "Chi Chi", riverislandVillageStuffLunarChiChi);
		else addButtonDisabled(4, "Chi Chi", "You need to wait until it's 6 PM or later for that.");
		addButton(14, "Back", riverislandVillageStuff1).hint("Leave the festival.");
	}
	public function riverislandVillageStuffLunarGifts():void {
		clearOutput();
		outputText("There seems to be a gift exchange going about. Some people are handing over red envelopes, something about luck for the coming year. You get hold of one and open it hoping for great luck. You open the envelope and... ");
		var SpiritStones:Number = 50;
		SpiritStones += rand(100);
		outputText("Wow! You were lucky! There was " + SpiritStones + " spirit stones inside! This sure is good fortune for the coming year.");
		player.createStatusEffect(StatusEffects.CanGetLunarGift,0,0,0,0);
		flags[kFLAGS.SPIRIT_STONES] += SpiritStones;
		statScreenRefresh();
		doNext(riverislandVillageStuffLunar);
	}
	public function riverislandVillageStuffLunarFood():void {
		clearOutput();
		outputText("The local restaurant seems to be offering some speciality food and best of all; it's free! Some " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + "-morphs are passing it all over for extra thematics. You proceed to grab a plate of these strange ravioli the people calls jiǎozi, taking the rice dessert they call niángāo right after. The meal is comforting and you would believe everything in Mareth was going fine right now if not for the reddish stormy sky in the distance.");
		player.refillHunger(50);
		eachMinuteCount(30);
		doNext(riverislandVillageStuffLunar);
	}
	public function riverislandVillageStuffLunarClothing():void {
		clearOutput();
		outputText("As you take a corner you spot a " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + " girl working at what appears to be a festive clothing store.");
		outputText("\n\n\"<i>Come over people! Look the part! Buy a dress for the festivities only for 10 spirit stones! C'mon and buy while there's some left!</i>\"");
		outputText("\n\nDo you buy one from the " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + " girl?");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(1, "Yes", riverislandVillageStuffLunarClothing2);
		else addButtonDisabled(1, "Yes", "You not have enough spirit stones to buy anything here");
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
        outputText("She hands you the dress after taking in your gems.");
		outputText("\n\n\"<i>Happy year of the " + flags[kFLAGS.LUNAR_NEW_YEAR_ANIMAL] + ", I wish you great luck!</i>\"");
		outputText("\n\nYou put the dress in your bag for now. Now to put it on.");
		outputText("\n\n<b>You got a Lunar new year dress.</b>\n\n");
		flags[kFLAGS.SPIRIT_STONES] -= 10;
		cheatTime(1/3);
        inventory.takeItem(itype, riverislandVillageStuffLunar);
    }
	public function riverislandVillageStuffLunarFireworks():void {
		clearOutput();
		outputText("There are some extravagantly beautiful fireworks exploding in the sky above town. Red rockets are regularly shot up, exploding in bright flashes. You chuckle inside pondering what would happen if some harpy were to fly into one of those fireworks… would it become roasted chicken? Speaking of chickens while you were thinking about harpies a few imps indeed drop dead from the sky. They must've got a little too close to the explosion and got caught in the blast.");
		doNext(camp.returnToCampUseFourHours);
	}
	public function riverislandVillageStuffLunarChiChi():void {
		clearOutput();
		outputText("You are surprised to spot Chi Chi in the crowd wearing a traditional kimono. The hinezumi notices you right away and invites you to join her.");
		if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 3) {
			outputText("\n\n\"<i>Come over people! Look the part! Buy a dress for the festivities only for 50 gems! C'mon and buy while there's some left!</i>\"");
			outputText("\n\nYou put the dress in your bag for now. Now to put it on.");
		}
		else if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) {
			outputText("\n\n\"<i>Hey, Baka! I thought you'd never join in. I waited for you here all day, you know! Sit next to me and hold my hand, I want the folks out there to know we're together.</i>\"");
			outputText("\n\nTogether as in a couple? Is she opening up or something? Your comment makes her light red cheeks even redder.");
			outputText("\n\n\"<i>N..no! Nothing of the sort! It's not like I care if all the other girls look at you right now! I’m just preventing you from flirting with half of the town's feminine cast!</i>\"");
			outputText("\n\nYou spend several hours watching the fireworks. Eventually Chi Chi asks you something.");
			outputText("\n\n\"<i>Say [name] if.. if the two of us were a couple... would you kiss me right now?</i>\"");
			outputText("\n\nYou sure would, why?");
			outputText("\n\n\"<i>Well w..would you please kiss me, then? I..it's not like I'm really desperate for one but...</i>\"");
			outputText("\n\nYou proceed to shut up her silly explanation by taking hold of her mouth and pulling her in for a deep kiss, her eyes opening wide in surprise before she gives herself up to you fully, her arms wrapping around you in a tight embrace.");
			outputText("\n\nYou both break the kiss a few seconds later, Chi Chi redder than a canine pepper.");
			outputText("\n\n\"<i>T..That was nice. Don’t you dare tell anyone in camp we did that though.</i>\"");
			outputText("\n\nYeah, sure, whatever she says. You spend a little more time with her before returning to camp.");
		}
		else {
			outputText("\n\n\"<i>Oh it's you? Did you come to train? Sorry, but I'm taking a break today. It's the Lunar festival and this event only happens once a year. How about we share a cup of tea and watch the fireworks? You could use a break too, ya know?</i>\""); //WTF? Sake? What is this, Japan? Yes
			outputText("\n\nYou share tea and food and jokes all night long while watching the fireworks. It's only when it gets very late that you bid her farewell and head back to camp.");
		}
		doNext(camp.returnToCampUseSixHours);
	}

    public function riverislandVillageStuff():void {
        spriteSelect(null);
        clearOutput();
        outputText("He'Xin'Dao is a large village connected and assembled between many smaller islands in the middle of large river that flows from the east to the west. In addition to the bridges connecting each of the islands together, two larger bridges connects them as a whole to both sides of the river, serving as the only points of access to the village.  The village is strategically laid out, preventing anyone from entering by swimming directly from the river to any of the islands, forcing anyone who can't fly to use the bridges if they wish to enter.\n");
        outputText("\n\nNear one of major bridges is a wide variety of shops, ranging from a few shops with vicious-looking weapons, to one shop with a goblin out front, hawking what appears to be golem-making materials. On the opposite side of village, near other bridge is a medium sized shop with a large 'Currency Transfer' sign. A market chock full of seemingly random items is in the same building, and as you get closer, you recognize several transformative items from your travels in this realm.");
        outputText("\n\nAt the West end of He'Xin'Dao you see one of biggest buildings here. The roar of a crowd rises up from it occasionally, and when you listen close, you can hear the rasping of blades, and various other sounds of combat. You assume it's a local arena.");	//Side question, why can't the ones with wings fly in? Answered: Because flying cultivators would kick their asses. 
        outputText("You notice several towers, positioned at central points on some of the larger islands. These hardy-looking wood and stone constructions have open, flat roofs, and several people perch on each. \n\n.");
	outputText("While at first glance, these people seem random. Some wield bows, others daggers, a few with no weapons at all...But as you focus on them, you can <i> feel </i> their soulforce, almost reacting to your attention. \n\n");
	outputText("As you look even closer into the sky, you see a few glints of light, something metal in the sky reflecting the sun's rays. Are those...people riding on flying swords? \n\n"); 
	//outputText("\n.");	//Z czasem jak bede dodawac miejsca opis wioski bedzie rozbudowywany :P
        riverislandMenuShow();
    }

    public function riverislandMenuShow():void {
        menu();
        addButton(0, "Merchant", golemmerchant);
        addButton(1, "TFspec/Exch", mogahenmerchant);
        addButton(2, "SoulEquip", serenamerchant);
        addButton(3, "SoulArrow", ermaswiftarrowmerchant);
		if (flags[kFLAGS.NEISA_FOLLOWER] == 0) addButton(4, "Dungeon", entranceToRiverDungeon);
		else {
			if (player.companionsInPCParty()) addButton(4, "Dungeon", entranceToRiverDungeon);
			else addButtonDisabled(4, "Dungeon", "You need to find some backup if you wish to enter!");
		}
        //addButton(5, "", ); siedziba lokalnej grupy zrzeszającej soul cultivators - PC aby potem pojsc dalej bedzie musial dolaczyc tutaj (pomyslec nad wiarygodnym sposobem zmuszenia go do tego - moze jakies ciekawe itemy/inne rzeczy dla czlonkow beda a miejsce sie zwolni jak wywala tak goblinke tworzynie golemow, ktora potem oczywiscie wcisnie sie do obozu PC aby w spokoju rozwijac sie w tworzeniu golemow itp.)
        addButton(6, "JourTTEast", SceneLib.journeyToTheEast.enteringInn);
        addButton(7, "Arena", soularena);
        addButton(8, "Restaurant", restaurantShiraOfTheEast);
		addButton(10, "Eraendir", eraendirorsbulg.EraendirMainMenu);
		addButton(11, "Orsbulg", eraendirorsbulg.OrsbulgMainMenu);
		addButton(12, "Golemancer", golemancershop);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 20 && flags[kFLAGS.CHI_CHI_FOLLOWER] < 2 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) addButton(13, "Chi Chi", chichiScene.MeetingChiChiInHeXinDao);
        addButton(14, "Leave", camp.returnToCampUseOneHour);
    }
    public function golemmerchant():void {
        clearOutput();
        outputText("You enter a shop titled 'Soul Items' from the sign on its entrance. Inside you see a few shelves with many different items on display.  It doesn't seem like this merchant has a wide choice of things to sell, but for someone at the beginning of their soul cultivation path, it's probably enough.  Sensing motion from a corner of the shop permanently covered in darkness, a person appears without making a sound.  'He' is around five feet tall, and looks like some kind of demonic monster.");
        if (flags[kFLAGS.FOUND_CATHEDRAL] > 0) outputText(" But he does look quite similar to the gargoyle from the cathedral.");
        outputText("\n\n\"<i>Welcome to my master's shop, dear customer. Feel free to look around,</i>\" he says. \n\n");
        if (flags[kFLAGS.CODEX_ENTRY_GOLEMS] <= 0) {
            flags[kFLAGS.CODEX_ENTRY_GOLEMS] = 1;
            outputText("<b>New codex entry unlocked: Golems!</b>\n\n")
        }
        menu();
        var buyItem1:Function = curry(confirmBuy1,golemmerchant,"Golem",1);
        var buyItem2:Function = curry(confirmBuy2,golemmerchant,"Golem",0.2);
        var introText:String = "\"When you reach towards one of the items on the display, the golem says, \"<i>";
        var costText:String = " Interested?  It is <b>";
        var endText1:String = " gems</b></i>.\"";
        var endText2:String = " spirit stones</b></i>.\"";
        function sayLine1(itype:ItemType,desc:String):String{
            return introText+desc+costText+itype.value+endText1;
        }
        function sayLine2(itype:ItemType,desc:String):String{
            return introText+desc+costText+(itype.value*0.2)+endText2;
        }
		addButton(1, "1st Stall", TierI).hint("Check out the first stall. This shop sells common items, for beginning soul cultivators.");
        if (player.hasPerk(PerkLib.SoulApprentice)) addButton(2, "2nd Stall", TierII).hint("Check out the second stall. This sells items for Soul Apprentices, Soul Personage and Soul Warrior stage cultivators.");
		else addButtonDisabled(2, "2nd Stall", "You need to be at least a Soul Apprentice to check those items.");
        if (player.hasPerk(PerkLib.SoulSprite)) addButton(3, "3rd Stall", TierIII).hint("Check out the third stall. This stall sells items for Soul Sprites, Soul Scholars and Soul Elder stage cultivators.");
		else addButtonDisabled(3, "3rd Stall", "You need to be at least a Soul Sprite to check those items.");
		function TierI():void {
			menu();
            addButton(0, "LGSFRecovPill", buyItem1,consumables.LG_SFRP,
					sayLine1(consumables.LG_SFRP,"It's a rather quite useful item for any soul cultivator, this little pill can help you restore some of your soulforce. Unless don't have your soul.")).hint("Low-grade Soulforce Recovery Pill.");
			addButton(1, "IncenOfInsig", buyItem1,consumables.INCOINS,
					sayLine1(consumables.INCOINS,"These incenses are quite special. They will grant you visions for a short moment while meditating. This should help you find the wisdom and insight you need.")).hint("Incense of Insight.");
			addButton(2, "E.P.Bottle", buyItem2,useables.E_P_BOT,
					sayLine2(useables.E_P_BOT,"These bottles can be used to organize SoulForce pills. Due to the nature of the pills, they must be consumed shortly after opening the bottle or they would lose their effects. Some cultivators have theorized on the properties of the pills for a long time, but no definitive answer has been reached.")).hint("Empty Pills Bottle.");
			addButton(3, "Bag of Cosmos", buyItem2,consumables.BAGOCOS,
					sayLine2(consumables.BAGOCOS,"A quintessential item for all soul cultivators, this little bag is dimensionally transcendental, that is, it's bigger on the inside. ")).hint("Bag of Cosmos.");
			if (flags[kFLAGS.HUNGER_ENABLED] > 0) addButton(4, "Fasting Pill", buyItem2,consumables.FATPILL,
					sayLine2(consumables.FATPILL,"It's a rather useful item for soul cultivators, this little pill can help you stave off hunger for a few days.")).hint("Fasting Pill.");
			if (player.hasPerk(PerkLib.JobSoulCultivator)) {
				addButton(5, "Triple Thrust", buyItem2,consumables.TRITMAN,
						sayLine2(consumables.TRITMAN,"It's a manual for Triple Thrust. This very simple technique allows you to unleash three thrusts that will become stronger and stronger as you train your body and soul."),
						"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  It seems like even the name of the manual could have been influenced by this realm's nature... either that or it's just a coincidence.  " //NTP-What does the second paragragh mean??? Tried my best here. #1
				).hint("Triple Thrust Manual.");
				addButton(6, "Draco Sweep", buyItem2,consumables.DRASMAN,
						sayLine2(consumables.DRASMAN,"It's a manual for Draco Sweep. This simple technique allows you to unleash an attack that would strike in wide arc before you, perfect for when you are fighting a group of enemies. It also becomes more powerful as long you train your body and soul."),
						"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to use when fighting a group of enemies.  You don't often meet more than one enemy at at a time, but you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once and would need something to deal with them.  "
				).hint("Draco Sweep Manual.");
				addButton(7, "Many Birds", buyItem2,consumables.MABIMAN,
						sayLine2(consumables.MABIMAN,"It's a manual for Many Birds. This simple technique allows you to project a figment of your soulforce as a crystal, firing it at extreme speeds. As you train your body and soul, this skill will become stronger."),
						"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you are not certain.  "
				).hint("Many Birds Manual.");
				addButton(8, "Hail of Blades", buyItem2,consumables.HOB1MAN,
						sayLine2(consumables.HOB1MAN,"It's a manual for Hail of Blades. This simple technique allows you to form several etheral weapons, then launch them at extreme speeds. As you train your body and soul, this skill will become stronger."),
						"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you are not certain.  "
				).hint("Hail of Blades Manual.");
			}
			addButton(10, "FlamesOfLove", buyItem1,consumables.FOLBMAN,
					sayLine1(consumables.FOLBMAN,"It's a manual for Flames of Love (Rankless), this simple technique allows you to convert excess lust into flames."),
					"\n\nIt seems like some sort of art to deal with needless lust by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  "
			).hint("Flames of Love (Rankless) Manual.");
			addButton(11, "IciclesOfLove", buyItem1,consumables.IOLBMAN,
					sayLine1(consumables.IOLBMAN,"It's a manual for Icicles of Love (Rankless), this simple technique allows you to covert excess lust into icicles."),
					"\n\nIt seems like some sort of art to deal with needless lust by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  "
			).hint("Icicles of Love (Rankless) Manual.");
			addButton(12, "SoSisterhood", buyItem1,consumables.SOSBMAN,
					sayLine1(consumables.SOSBMAN,"It's a manual for Storm of Sisterhood (Rankless), this simple technique allows you to convert excess wrath into lighting."),
					"\n\nIt seems like some sort of art to deal with needless wrath by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  "
			).hint("Storm of Sisterhood (Rankless) Manual.");
			addButton(13, "NoBrotherhood", buyItem1,consumables.NOBBMAN,
					sayLine1(consumables.NOBBMAN,"It's a manual for Night of Brotherhood (Rankless), this simple technique allows you to covert excess wrath into darkness."),
					"\n\nIt seems like some sort of art to deal with needless wrath by changing it into another....more deadly form.  But what does rankless mean?  Is there a higher rank for this soulskill?  "
			).hint("Night of Brotherhood (Rankless) Manual.");
			addButton(14, "Back", golemmerchant);
            statScreenRefresh();
		}
		function TierII():void {
			menu();
			addButton(0, "Comet", buyItem2,consumables.COMETMA,
					sayLine2(consumables.COMETMA,"It's a manual for Comet, this technique allows you to project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.  Perfect for when you are fighting groups of enemies, it also becomes more powerful as long as you keep training your body and soul."),
					"\n\nWhether you are going to try to go deeper into all that 'soulforce' stuff or not, at least you now have something to use when fighting groups of enemies.  You don't often meet more than one enemy at at a time, but you're sure that deeper in this forsaken realm you will face groups or maybe even hordes of demons at once. Best to be prepared. "
			).hint("Comet Manual.");
			addButton(1, "V P Trans", buyItem2,consumables.VPTRMAN,
					sayLine2(consumables.VPTRMAN,"It's a manual for Violet Pupil Transformation, this advanced technique allows you to channel soulforce into regenerative power, allowing you to recover even from the brink of death.  Its only flaw is that it constantly drains the cultivator's soulforce. "),
					"\n\nIt seems like it's similar to a healing spell soul skill, but instead of being used immediately, with enough soulforce it could be kept active for a very long period of time.  It could give you an edge against the demons.  Additionally, the ability to heal from the brink of death could prove to be useful in future fights.  "
			).hint("Violet Pupil Transformation Manual.");
			if (player.hasPerk(PerkLib.SoulPersonage)) {
				addButton(4, "Sextuple Thrust", buyItem2,consumables.SEXTMAN,
						sayLine2(consumables.SEXTMAN,"It's a manual for Sextuple Thrust, this simple technique allows you to unleash six thrusts. As you train your body and soul, this skill will become stronger."),
						"\n\nWhether you are going to go deeper into all that 'soulforce' stuff or not, at least you now have something to train with. The name of the manual seems like it could have been influenced by this realm...or it's just a coincidence.  " 
				).hint("Sextuple Thrust Manual."); //NTP-What does the second paragragh mean??? Tried my best here. #1
				addButton(5, "Grandiose Hail of Blades", buyItem2,consumables.HOB2MAN,
						sayLine2(consumables.HOB2MAN,"It's a manual for Grandiose Hail of Blades, this technique allows you to form many etheral weapons traveling at extreme speeds. As you train your body and soul, this skill will become stronger."),
						"\n\nWhether you are going to go deeper into all that 'soulforce' stuff or not, at least you now have something to begin with.  The name of the manual is strange, but it makes you remember something...but what and from where you not certain.  "
				).hint("Grandiose Hail of Blades Manual.");
			}
			if (player.hasPerk(PerkLib.SoulWarrior)) {
				addButton(7, "MGSFRecovPill", buyItem2,consumables.MG_SFRP,
					sayLine2(consumables.MG_SFRP,"It's a rather useful item for all cultivators at Soul Warrior stage or higher, this small pill can help you restore some of your soulforce and would provide much more than the low-grade one.")).hint("Mid-grade Soulforce Recovery Pill.");
			}
            addButton(14, "Back", golemmerchant);
            statScreenRefresh();
		}
		function TierIII():void {
			menu();
			addButton(0, "Nonuple Thrust", buyItem2,consumables.NONTMAN,
					sayLine2(consumables.NONTMAN,"It's a manual for Nonuple Thrust, this technique allows you to unleash nine thrusts. As you train your body and soul. "),
					"\n\nSince you are going deeper into soulforce, you got something more advanced to train with.  The name of the manual seems like it could have been influenced by this realm...or it's just a coincidence.  "
			).hint("Nonuple Thrust Manual."); //NTP-What does the second paragragh mean??? Tried my best here. #1
			addButton(1, "GHoMB", buyItem2,consumables.HOB3MAN,
					sayLine2(consumables.HOB3MAN,"It's a manual for Grandiose Hail of Moon Blades, this technique allows you to form a huge amount of etheral weapons traveling at extreme speeds. As you train your body and soul, this skill will become stronger."),
					"\n\nSince you are going deeper into soulforce, you got something more advanced to train with.  The name of the manual is strange, but it makes you remember something...but what and from where you not certain.  "
			).hint("Grandiose Hail of Moon Blades Manual.");
			/*addButton(2, "Yin Yang Blast", buyItem2,consumables.YYB_MAN,
					sayLine2(consumables.YYB_MAN,"It's a manual for Yin Yang Blast, this technique allows you to make team attack using Yin Palm and Yang Fist to destroy your enemies."),
					"\n\nSince you going deeper into all that 'soulforce' stuff you now got something to train with someone that would goes into fights alongside you.  Maybe there is some more of those 'combined' soulskills somewhere?  "
			).hint("Yin Yang Blast Manual.");*/
			addButton(14, "Back", golemmerchant);
            statScreenRefresh();
		}/*
		if (player.hasPerk(PerkLib.SoulExalt)) { lub soul overlord - each soul stage above starting allow to extend channeling time by 1 round
			addButton(1, "GHoMB", buyItem2,consumables.HOB4MAN,
					sayLine2(consumables.HOB4MAN,"It's a manual for Grandiose Hail of Moon Blades, this technique allows you to form a simply massive amount of etheral weapons, sending them at your foe with extreme speed. As you train your body and soul, this skill will become stronger. "),
					"\n\nYou already went so deep into becoming cultivator so why not?  'Few' more weapons formed will not hurt at this point, right?  "
			).hint("Grandiose Heavenly Hail of Yin-Yang Blades: Endless Tide Manual.");
		}*/
		if (player.hasPerk(PerkLib.SoulOverlord)) {
			addButton(10, "HGSFRecovPill", buyItem2,consumables.HG_SFRP,
					sayLine2(consumables.HG_SFRP,"It's a rather useful item for all cultivators at Soul Overlord stage or higher, this small pill can help you restore some of your soulforce and would provide much more than the mid-grade one.")).hint("High-grade Soulforce Recovery Pill.");
		}
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
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
        clearOutput();
        outputText("You enter a shop titled 'Transformative Items and Exchanges'. Inside you see a few shelves with many different items on display.  Most items seem rather generic, but a few items gathered are far more difficult to come by and rarer to encounter.");
        outputText("\n\nAs you're looking over the stalls, the owner almost silently approaches you. He announces his presence by clearing his throat. You turn to face him, only to be greeted by him smiling at you like a cat that caught the mouse. After a moment of pause, he breaks the silence.");
        outputText("\n\n\"<i>Welcome to my humble shop dear and precious customer. I am Moga Hen. What needs bring you here today? To repair some damage caused by using items you casually picked up or to obtain some specific change? Or perhaps you need to exchange gems for spirit stones, mayhaps even the other way round? I could even give you a fair price on special items that are useless for non-cultivators.</i>\" Each word sounds almost like it was repeated countless times.\n\n");
        var buyItem1:Function = curry(confirmBuy1,mogahenmerchant,"Moga",3);
        var buyItem2:Function = curry(confirmBuy2,mogahenmerchant,"Moga",5);
        var introText:String = "When you point towards one of the items on display the merchant says, \"<i>This item is used to embrace the ";
        var costText:String = " in you.  Interested?  It is merely <b>";
        var endText1:String = " gems</b></i>.\"";
        var endText2:String = " spirit stones</b></i>.\"";
        var onBuyString1:String="\n\nAfter you give Hen a few gems, he hands you the transformative. ";
        var onBuyString2:String="\n\nAfter you give Hen a few spirit stones he hands you the transformative. ";
        function sayLine1(itype:ItemType,desc:String):String{
            return introText+desc+costText+(itype.value*3)+endText1;
        }
        function sayLine2(itype:ItemType,desc:String):String{
            return introText+desc+costText+itype.value/5+endText2;
        }
        menu();
        addButton(0, "1st Stall", Tier1).hint("Check out the first stall. This appears to have common or easy to find TF items.");
        addButton(1, "2nd Stall", Tier2).hint("Check out the second stall. This stall sells more common TF items.");
        addButton(2, "3rd Stall", Tier3).hint("Check out the third stall. Rarer TF items are sold here.");		//specjalne type TF jak ectoplasm ^^
        addButton(3, "4th Stall", Tier4).hint("Check out the fourth stall. This stall has a select few, extremely rare TF items. (you need spirit stones to buy those)");
        //addButton(10, "Talk", TalkWithMogaHen).hint("Talk with the shopkeeper.");
        addButton(11, "Sell", sellItemsForSpiritStones).hint("Sell items for spirit stones.");
        addButton(12, "Exchange", exchangeGemsToSpiritStonesorReverse).hint("Exchange gems to spirit stones or spirit stones to gems.");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
        //buyItem,consumables.,sayLine(consumables.,""),onBuyString
        function Tier1():void {
            menu();
            addButton(0, "BlackPp", buyItem1,consumables.BLACKPP,sayLine1(consumables.BLACKPP,"dog"),onBuyString1).hint("Buy solid black canine pepper.\nCost: " + String(consumables.BLACKPP.value * 3) + " Gems");
            addButton(1, "BulbyPp", buyItem1,consumables.BULBYPP,sayLine1(consumables.BULBYPP,"dog"),onBuyString1).hint("Buy a bulbous pepper.\nCost: " + String(consumables.BULBYPP.value * 3) + " Gems");
            addButton(2, "DblPepp", buyItem1,consumables.DBLPEPP,sayLine1(consumables.DBLPEPP,"dog"),onBuyString1).hint("Buy a double canine pepper.\nCost: " + String(consumables.DBLPEPP.value * 3) + " Gems");
            addButton(3, "KnottyP", buyItem1,consumables.KNOTTYP,sayLine1(consumables.KNOTTYP,"dog"),onBuyString1).hint("Buy a knotty canine pepper.\nCost: " + String(consumables.KNOTTYP.value * 3) + " Gems");
            addButton(4, "LargePp", buyItem1,consumables.LARGEPP,sayLine1(consumables.LARGEPP,"dog"),onBuyString1).hint("Buy an overly large canine pepper.\nCost: " + String(consumables.LARGEPP.value * 3) + " Gems");
            addButton(5, "CanineP", buyItem1,consumables.CANINEP,sayLine1(consumables.CANINEP,"dog"),onBuyString1).hint("Buy a Canine pepper.\nCost: " + String(consumables.CANINEP.value * 3) + " Gems");
            addButton(6, "FaeEar", buyItem1,consumables.ELFEARS,sayLine1(consumables.ELFEARS,"elf"),onBuyString1).hint("Buy a Fae ear shaped plant.\nCost: " + String(consumables.ELFEARS.value * 3) + " Gems");
            addButton(7, "Reptilum", buyItem1,consumables.REPTLUM,sayLine1(consumables.REPTLUM,"lizan"),onBuyString1).hint("Buy a vial of Reptilum.\nCost: " + String(consumables.REPTLUM.value * 3) + " Gems");
            addButton(14, "Back", mogahenmerchant);
            statScreenRefresh();
        }
        function Tier2():void {
            menu();
            addButton(0, "Shark.T", buyItem1,consumables.SHARK_T,sayLine1(consumables.SHARK_T,"shark"),onBuyString1).hint("Buy a sharp shark tooth.\nCost: " + String(consumables.SHARK_T.value * 3) + " Gems");
            addButton(1, "GoldenRind", buyItem1,consumables.GLDRIND,sayLine1(consumables.GLDRIND,"deer"),onBuyString1).hint("Buy a golden rind.\nCost: " + String(consumables.GLDRIND.value * 3) + " Gems");
            addButton(2, "KangaFruit", buyItem1,consumables.KANGAFT,sayLine1(consumables.KANGAFT,"kangaroo"),onBuyString1).hint("Buy a piece of kanga fruit.\nCost: " + String(consumables.KANGAFT.value * 3) + " Gems");
            addButton(3, "BladeGrass", buyItem1,consumables.BLADEGR,sayLine1(consumables.BLADEGR,"mantis"),onBuyString1).hint("Buy a blade shaped grass.\nCost: " + String(consumables.BLADEGR.value * 3) + " Gems");
            addButton(4, "Scorpinum", buyItem1,consumables.SCORICO,sayLine1(consumables.SCORICO,"scorpion"),onBuyString1).hint("Buy a vial of Scorpinum.\nCost: " + String(consumables.SCORICO.value * 3) + " Gems");
            addButton(5, "YetiCum", buyItem1,consumables.YETICUM,sayLine1(consumables.YETICUM,"yeti"),onBuyString1).hint("Buy a bottle of Yeti Cum.\nCost: " + String(consumables.YETICUM.value * 3) + " Gems");
            addButton(6, "BayrLeaf", buyItem1,consumables.BAYRLEA,sayLine1(consumables.BAYRLEA,"bear"),onBuyString1).hint("Buy a Bayr leaf.\nCost: " + String(consumables.BAYRLEA.value * 3) + " Gems");
            addButton(7, "SmartNuts", buyItem1,consumables.SMRTNUT,sayLine1(consumables.SMRTNUT,"squirrel"),onBuyString1).hint("Buy a smarty nut.\nCost: " + String(consumables.SMRTNUT.value * 3) + " Gems");
            addButton(14, "Back", mogahenmerchant);
            statScreenRefresh();
        }
        function Tier3():void {
            menu();
            addButton(0, "Coal", buyItem1,consumables.COAL___,sayLine1(consumables.COAL___,"heat or rut"),onBuyString1).hint("Buy two pieces of coal.\nCost: " + String(consumables.COAL___.value * 3) + " Gems");
            addButton(1, "DryTent", buyItem1,consumables.DRYTENT,sayLine1(consumables.DRYTENT,"anemone"),onBuyString1).hint("Buy a shriveled tentacle.\nCost: " + String(consumables.DRYTENT.value * 3) + " Gems");
            addButton(2, "EctoPls", buyItem1,consumables.ECTOPLS,sayLine1(consumables.ECTOPLS,"ghost"),onBuyString1).hint("Buy a bottle of ectoplasm.\nCost: " + String(consumables.ECTOPLS.value * 3) + " Gems");
            addButton(3, "TrapOil", buyItem1,consumables.TRAPOIL,sayLine1(consumables.TRAPOIL,"sand trap"),onBuyString1).hint("Buy a vial of trap oil.\nCost: " + String(consumables.TRAPOIL.value * 3) + " Gems");
            addButton(4, "Icicle", buyItem1,consumables.ICICLE_,sayLine1(consumables.ICICLE_,"ice shard"),onBuyString1).hint("Buy an icicle.\nCost: " + String(consumables.ICICLE_.value * 3) + " Gems");
            addButton(5, "S.Delight", buyItem1,consumables.SDELITE,sayLine1(consumables.SDELITE,"Succubi's Delight"),onBuyString1).hint("Buy a bottle of 'Succubi's Delight'.\nCost: " + String(consumables.SDELITE.value * 3) + " Gems");
            addButton(14, "Back", mogahenmerchant);
            statScreenRefresh();
        }
		function Tier4():void {
			menu();
            addButton(0, "SatyrWine", buyItem2,consumables.SATYR_W,sayLine2(consumables.SATYR_W,"satyr"),onBuyString2).hint("Buy a bottle of satyr wine.\nCost: " + String(consumables.SATYR_W.value / 5) + " Spirit Stones");
            addButton(1, "DrakeHeart", buyItem2,consumables.DRAKHRT,sayLine2(consumables.DRAKHRT,"dragon"),onBuyString2).hint("Buy a drake's heart's flower.\nCost: " + String(consumables.DRAKHRT.value / 5) + " Spirit Stones");
            addButton(2, "C.Venom", buyItem2,consumables.C_VEMOM,sayLine2(consumables.C_VEMOM,"Centipede"),onBuyString2).hint("Buy a bottle of Centipede venom.\nCost: " + String(consumables.C_VEMOM.value / 5) + " Spirit Stones");
            addButton(3, "Hummus", buyItem2,consumables.HUMMUS_,sayLine2(consumables.HUMMUS_,"humanity"),onBuyString2).hint("Buy a blob of cheesy-looking hummus.\nCost: " + String(consumables.HUMMUS_.value / 5) + " Spirit Stones");
            addButton(4, "ChillyP", buyItem2,consumables.CHILLYP,sayLine2(consumables.CHILLYP,"winter wolf"),onBuyString2).hint("Buy a Chilly pepper.\nCost: " + String(consumables.SATYR_W.value / 5) + " Spirit Stones");
            addButton(5, "MaraFruit", buyItem2,consumables.MARAFRU,sayLine2(consumables.MARAFRU,"plant"),onBuyString2).hint("Buy an apple-shaped fruit.\nCost: " + String(consumables.MARAFRU.value / 5) + " Spirit Stones");
            addButton(6, "SkySeed", buyItem2,consumables.SKYSEED,sayLine2(consumables.SKYSEED,"avian"),onBuyString2).hint("Buy a skyborn seed.\nCost: " + String(consumables.SKYSEED.value / 5) + " Spirit Stones");
            addButton(7, "W.Emerald", buyItem2,consumables.W_EMRLD,sayLine2(consumables.W_EMRLD,"kamaitachi"),onBuyString2).hint("Buy a 'Windstorm Emerald'.\nCost: " + String(consumables.W_EMRLD.value / 5) + " Spirit Stones");
			addButton(14, "Back", mogahenmerchant);
            statScreenRefresh();
		}
    }

    public function exchangeGemsToSpiritStonesorReverse():void {
        clearOutput();
        outputText("When you ask about this exchange that was mentioned on the sign over the entrance, Moga thinks for a moment before reaching to the desk near him. After handing you a piece of paper he adds: ");
        outputText("\n\n\"<i>Here are my exchange rates. Pick the one you want and let me know. If you don't like those rates you can go and try to find someone else... not like there is anyone else here that would want to deal with those exchanges besides me.</i>\"");
        menu();
        if (player.gems >= 20) addButton(0, "20 Gems", exchange,1).hint("Exchange 20 gems for 1 spirit stone.");
        if (player.gems >= 100) addButton(1, "100 Gems", exchange,5).hint("Exchange 100 gems for 5 spirit stones.");
        if (player.gems >= 200) addButton(2, "200 Gems", exchange,10).hint("Exchange 200 gems for 10 spirit stones.");
        if (player.gems >= 1000) addButton(3, "1000 Gems", exchange,50).hint("Exchange 1000 gems for 50 spirit stones.");
        if (player.gems >= 2000) addButton(4, "2000 Gems", exchange, 100).hint("Exchange 2000 gems for 100 spirit stones.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 1) addButton(5, "1 SS", exchange,1,false).hint("Exchange 1 spirit stone for 5 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 5) addButton(6, "5 SS", exchange,5,false).hint("Exchange 5 spirit stones for 25 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(7, "10 SS", exchange,10,false).hint("Exchange 10 spirit stones for 50 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 50) addButton(8, "50 SS", exchange,50,false).hint("Exchange 50 spirit stones for 250 gems.");
        if (flags[kFLAGS.SPIRIT_STONES] >= 100) addButton(9, "100 SS", exchange,100,false).hint("Exchange 100 spirit stones for 500 gems.");
        addButton(14, "Back", mogahenmerchant);
    }
    private function exchange(value:int,toStones:Boolean=true):void{
        if(toStones){
            switch(value){
                case 1:outputText("You count out the gems before giving them to the merchant. With noticable mumbling about the customer being stingy he slowly finishes the transaction, giving you one spirit stone.");break;
                case 5:outputText("You count out the gems before giving them to the merchant. With barely noticable mumbling about the customer being stingy he slowly finishes the transaction, giving you five spirit stones.");break;
                case 10:outputText("You count out the gems before giving them to the merchant. He finishes the transaction, giving you ten spirit stones.");break;
                case 50:outputText("You count out the gems before giving them to the merchant. With slight haste he finishes the transaction, giving you fifty spirit stones.");break;
                case 100:outputText("You count out the gems before giving them to the merchant. With haste he finishes the transaction, giving you hundred spirit stones.");break;
            }
            player.gems -= 20*value;
            flags[kFLAGS.SPIRIT_STONES]+=value;
        } else {
            switch(value){
                case 1:outputText("You hand over one stone to the merchant. With noticable mumbling about the customer being stingy he slowly counts out your gems, handing them over.");break;
                case 5:outputText("You hand over five stones to the merchant. With barely noticable mumbling about the customer being stingy he slowly counts out and hands over your gems.");break;
                case 10:outputText("You hand over ten stones to the merchant. He finishes the transaction without fuss, giving you your gems.");break;
                case 50:outputText("You hand over fifty stones to the merchant. He finishes the transaction a bit faster than normal, giving youg your gems.");break;
                case 100:outputText("You hand over a hundred stones to the merchant. With a smile on his face, he swiftly counts up your gems, handing them over.");break;
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
        if (player.hasItem(useables.GOLCORE, 5)) addButton(1, "Sell 5", sellFiveGolemCores).hint("Sell 5 golem cores.");
        if (player.hasItem(useables.PCSHARD, 1)) addButton(5, "Sell 1", sellOnePurpleCrystalShard).hint("Sell 1 purple crystal shard.");
        if (player.hasItem(useables.PCSHARD, 5)) addButton(6, "Sell 5", sellFivePurpleCrystalShards).hint("Sell 5 purple crystal shards.");
        if (player.hasItem(useables.ELSHARD, 1)) addButton(7, "Sell 1", sellOneElementalShard).hint("Sell 1 elemental shard.");
        if (player.hasItem(useables.ELSHARD, 5)) addButton(8, "Sell 5", sellFiveElementalShards).hint("Sell 5 elemental shards.");
        if (player.hasItem(useables.E_ICHOR, 1)) addButton(10, "Sell 1", sellOneEIchorVial).hint("Sell 1 vial of E-Ichor.");
        if (player.hasItem(useables.E_ICHOR, 5)) addButton(11, "Sell 5", sellFiveEIchorVials).hint("Sell 5 vials of E-Ichor.");
        addButton(14, "Back", mogahenmerchant);
    }

    public function sellOneGolemCore():void {
        clearOutput();
        outputText("\"<i>A single golem core. It's still in good shape, so that will be a single spirit stone,</i>\" he states after examining the core. Moments after he went to put away the core, Moga returns and gives you a single stone.");
        player.destroyItems(useables.GOLCORE, 1);
        flags[kFLAGS.SPIRIT_STONES]++;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveGolemCores():void {
        clearOutput();
        outputText("\"<i>Golem cores. Let me check...Hm...They seem to be in decent shape,</i>\" after the examination he walks away and return shortly. \"<i>Here are your five stones for them.</i>\"");
        player.destroyItems(useables.GOLCORE, 5);
        flags[kFLAGS.SPIRIT_STONES] += 5;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOnePurpleCrystalShard():void {
        clearOutput();
        outputText("\"<i>A single purple crystal shard. It's still glowing, so that will be a two spirit stones,</i>\" he states after examining the shard. Moments after he went to put away the shard Moga returns and gives you two stones.");
        player.destroyItems(useables.PCSHARD, 1);
        flags[kFLAGS.SPIRIT_STONES] += 2;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFivePurpleCrystalShards():void {
        clearOutput();
        outputText("\"<i>Purple crystal shards. Let me check...yeah, all of them seem to be in a decent state,</i>\" after examination he walks away and return shortly. \"<i>Here you go. Ten spirit stones.</i>\"");
        player.destroyItems(useables.PCSHARD, 5);
        flags[kFLAGS.SPIRIT_STONES] += 10;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneElementalShard():void {
        clearOutput();
        outputText("\"<i>A single elemental shard. It still possesses a lot of energy...I can give you three spirit stones for it.</i>\" He takes the shard, going into the back. Moga returns and gives you three stones.");
        player.destroyItems(useables.ELSHARD, 1);
        flags[kFLAGS.SPIRIT_STONES] += 3;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveElementalShards():void {
        clearOutput();
        outputText("\"<i>Elemental shards. Let me check...yes all of them seems to be in decent state,</i>\" after examination he walks away and return shortly. \"<i>Here are your twenty five stones for them.</i>\"");
        player.destroyItems(useables.ELSHARD, 5);
        flags[kFLAGS.SPIRIT_STONES] += 15;
        doNext(sellItemsForSpiritStones);
    }
    public function sellOneEIchorVial():void {
        clearOutput();
        outputText("\"<i>A single vial of E-Ichor. It's super rare item, so... i will give you... twenty spirit stones,</i>\" he states after very lpong examination of the vial. Moments after he went to put away the vial Moga returns and gives you twenty stone, with shaky hand as if parting with something precious.");
        player.destroyItems(useables.E_ICHOR, 1);
        flags[kFLAGS.SPIRIT_STONES] += 20;
        doNext(sellItemsForSpiritStones);
    }
    public function sellFiveEIchorVials():void {
        clearOutput();
        outputText("\"<i>Vials of E-Ichor. Let me check...yes all of them seems to be decently preserved,</i>\" after long examination he walks away and return after even longer time. \"<i>Here are your hun... hundred stones for them...</i>\"");
        player.destroyItems(useables.E_ICHOR, 5);
        flags[kFLAGS.SPIRIT_STONES] += 100;
        doNext(sellItemsForSpiritStones);
    }

    public function serenamerchant():void {
        clearOutput();//Serena - female siren npc
        outputText("After entering the shop with a sign saying 'Equipment' over the doors you see a few shelves filled with various weapons, shields, armors and even rarer items like rings and necklaces. Behind the desk located in the central point of the shop you see a woman that seems to have mixed race traits. A shark face and a tail that sometimes show up on either side of the desk contrasts it's owner's feather covered arms. She's an odd mix of shark and bird.");
        outputText("\n\n\"<i>Greetings dear customer. I'm Serena and this is my humble shop. Look around and if something catches your eyes let me know,</i>\" she says all that almost entirely in one breath.");
        menu();
        addButton(1, "Shelf 1", soulequipmentshelf1).hint("Soul Training Equipment");
        addButton(2, "Shelf 2", soulequipmentshelf2).hint("Weapons");
        addButton(3, "Shelf 3", soulequipmentshelf3).hint("Armors");
        addButton(6, "Shelf 4", soulequipmentshelf4).hint("Flying Swords");
        addButton(7, "Shelf 5", soulequipmentshelf5).hint("Consumables");
        addButton(8, "Shelf 6", soulequipmentshelf6).hint("Misc");
		//addButton(7, weapons.MACE.shortName, weaponBuy, weapons.MACE);//(?magically enchanced?) awl - wymagać bedzie możliwość lewitacji czy coś od PC aby to używać
        //addButton(12, "Talk", ).hint("Tak with .");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }
    public function soulequipmentshelf1():void {
        menu();
		addButton(0, weapons.TRASAXE.shortName, weaponBuy1, weapons.TRASAXE);
        addButton(1, weaponsrange.TRSXBOW.shortName, weaponBuy1, weaponsrange.TRSXBOW);
        addButton(2, shields.TRASBUC.shortName, weaponBuy1, shields.TRASBUC);
        addButton(3, armors.TRASARM.shortName, weaponBuy1, armors.TRASARM);
        addButton(4, weaponsflyingswords.TRASFLS.shortName, weaponBuy1, weaponsflyingswords.TRASFLS);
        addButton(5, undergarments.STSHIRT.shortName, weaponBuy1, undergarments.STSHIRT);
        addButton(6, undergarments.STPANTY.shortName, weaponBuy1, undergarments.STPANTY);
        addButton(7, headjewelries.TSHAIR.shortName, weaponBuy1, headjewelries.TSHAIR);
        addButton(8, necklaces.TSNECK.shortName, weaponBuy1, necklaces.TSNECK);
        addButton(9, jewelries.TSRNG.shortName, weaponBuy1, jewelries.TSRNG);
        addButton(10, necklaces.SMNECK.shortName, weaponBuy1, necklaces.SMNECK);
        addButton(11, jewelries.SOULRNG.shortName, weaponBuy1, jewelries.SOULRNG);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf2():void {
        menu();
        addButton(0, weapons.UGATANA.shortName, weaponBuy2, weapons.UGATANA);
        addButton(1, weapons.KATANA.shortName, weaponBuy2, weapons.KATANA);
        addButton(2, weapons.NODACHI.shortName, weaponBuy2, weapons.NODACHI);
        addButton(3, weapons.RCLAYMO.shortName, weaponBuy2, weapons.RCLAYMO);
        addButton(4, weapons.SCLAYMO.shortName, weaponBuy2, weapons.SCLAYMO);
        addButton(5, weapons.S_GAUNT.shortName, weaponBuy2, weapons.S_GAUNT);
        addButton(6, weapons.CLAWS.shortName, weaponBuy2, weapons.CLAWS);
        addButton(7, weapons.DAISHO.shortName, weaponBuy2, weapons.DAISHO);
        addButton(8, weapons.TCLAYMO.shortName, weaponBuy2, weapons.TCLAYMO);
        addButton(9, weapons.ACLAYMO.shortName, weaponBuy2, weapons.ACLAYMO);
        addButton(10, weapons.WHIP.shortName, weaponBuy2, weapons.WHIP);
        addButton(11, weapons.PWHIP.shortName, weaponBuy2, weapons.PWHIP);
        addButton(12, weapons.ZWNDER.shortName, weaponBuy2, weapons.ZWNDER);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf3():void {
        menu();
        if (player.hasPerk(PerkLib.SoulApprentice)) addButton(0, armors.LAYOARM.shortName, weaponBuy3, armors.LAYOARM);
		else addButtonDisabled(0, "???", "Req. Soul Apprentice");
        if (player.hasPerk(PerkLib.SoulPersonage)) addButton(1, armors.HAYOARM.shortName, weaponBuy3, armors.HAYOARM);
		else addButtonDisabled(1, "???", "Req. Soul Personage");
        //addButton(11, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic armor made of soulmetal that works with unhindered perk xD czyli coś ala bikini lub ogólnie tylko underwear z fragmentami zbroi lewitującymi wokół postaci i tylko w wypadku ataku wroga przesuwające sie aby przyjąć atak
        //addButton(12, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic light armor made of soulmetal
        //addButton(10, weapons.MACE.shortName, weaponBuy, weapons.MACE);//basic heavy armor made of soulmetal
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf4():void {
        menu();
		addButton(0, weaponsflyingswords.S_HALFM.shortName, weaponBuy4, weaponsflyingswords.S_HALFM);
		addButton(1, weaponsflyingswords.E_HALFM.shortName, weaponBuy4, weaponsflyingswords.E_HALFM);
		addButton(2, weaponsflyingswords.B_HALFM.shortName, weaponBuy4, weaponsflyingswords.B_HALFM);
		addButton(3, weaponsflyingswords.W_HALFM.shortName, weaponBuy4, weaponsflyingswords.W_HALFM);
		addButton(4, weaponsflyingswords.MOONLGT.shortName, weaponBuy4, weaponsflyingswords.MOONLGT);
		addButton(5, weaponsflyingswords.S_TWINS.shortName, weaponBuy4, weaponsflyingswords.S_TWINS);
		addButton(10, weaponsflyingswords.ASAUCHI.shortName, weaponBuy4, weaponsflyingswords.ASAUCHI);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf5():void {
        menu();
        if (player.level >= 6) addButton(5, consumables.BANGBM1.shortName, weaponBuy5, consumables.BANGBM1);
		else addButtonDisabled(5, "???", "Req. lvl 6+");
        if (player.level >= 24) addButton(6, consumables.BANGBM2.shortName, weaponBuy5, consumables.BANGBM2);
        else addButtonDisabled(6, "???", "Req. lvl 24+");
        if (player.level >= 42) {
			addButton(0, consumables.BALLOFL.shortName, weaponBuy5, consumables.BALLOFL);
			addButton(1, consumables.FROZENB.shortName, weaponBuy5, consumables.FROZENB);
			addButton(2, consumables.THUNDBl.shortName, weaponBuy5, consumables.THUNDBl);
			addButton(3, consumables.BALLOTD.shortName, weaponBuy5, consumables.BALLOTD);
			addButton(4, consumables.POISONB.shortName, weaponBuy5, consumables.POISONB);
			addButton(7, consumables.BANGBM3.shortName, weaponBuy5, consumables.BANGBM3);
			addButton(8, consumables.BANGBM3.shortName, weaponBuy5, consumables.BANGBM3);
		}
        else {
			addButtonDisabled(0, "???", "Req. lvl 42+");
			addButtonDisabled(1, "???", "Req. lvl 42+");
			addButtonDisabled(2, "???", "Req. lvl 42+");
			addButtonDisabled(3, "???", "Req. lvl 42+");
			addButtonDisabled(4, "???", "Req. lvl 42+");
			addButtonDisabled(7, "???", "Req. lvl 42+");
			addButtonDisabled(8, "???", "Req. lvl 42+");
		}
        addButton(10, consumables.BANGB_M.shortName, weaponBuy5, consumables.BANGB_M);
        addButton(11, consumables.W_STICK.shortName, weaponBuy5, consumables.W_STICK);
        addButton(14, "Back", serenamerchant);
    }
    public function soulequipmentshelf6():void {
        menu();
		addButton(1, weapons.W_STAFF.shortName, weaponBuy6, weapons.W_STAFF);
		addButton(2, weapons.AWL_.shortName, weaponBuy6, weapons.AWL_);
		addButton(3, weapons.RULER.shortName, weaponBuy6, weapons.RULER);
		addButton(4, weapons.NRSABER.shortName, weaponBuy6, weapons.NRSABER);
		addButton(5, weapons.RIBBON.shortName, weaponBuy6, weapons.RIBBON);
        addButton(6, weapons.GUANDAO.shortName, weaponBuy6, weapons.GUANDAO);
        addButton(7, weapons.HSWORDS.shortName, weaponBuy6, weapons.HSWORDS);
		addButton(8, weapons.SNAKESW.shortName, weaponBuy6, weapons.SNAKESW);
		//addButton(9, Changdao
        addButton(10, weapons.FLYWHIS.shortName, weaponBuy6, weapons.FLYWHIS);
        addButton(11, weapons.PRURUMI.shortName, weaponBuy6, weapons.PRURUMI);
        addButton(12, weapons.CHAKRAM.shortName, weaponBuy6, weapons.CHAKRAM);
        addButton(13, shields.MABRACE.shortName, weaponBuy6, shields.MABRACE);
        addButton(14, "Back", serenamerchant);
    }

    private function weaponBuy1(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf1);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon1,itype), soulequipmentshelf1);
    }
    private function debitWeapon1(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf1);
    }
    private function weaponBuy2(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf2);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon2,itype), soulequipmentshelf2);
    }
    private function debitWeapon2(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf2);
    }
    private function weaponBuy3(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf3);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon3,itype), soulequipmentshelf3);
    }
    private function debitWeapon3(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf3);
    }
    private function weaponBuy4(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf4);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon4,itype), soulequipmentshelf4);
    }
    private function debitWeapon4(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf4);
    }
    private function weaponBuy5(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf5);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon5,itype), soulequipmentshelf5);
    }
    private function debitWeapon5(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf5);
    }
    private function weaponBuy6(itype:ItemType):void {
        clearOutput();
        outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            doNext(soulequipmentshelf6);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        doYesNo(curry(debitWeapon6,itype), soulequipmentshelf6);
    }
    private function debitWeapon6(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, soulequipmentshelf6);
    }
	
	public function entranceToRiverDungeon():void {
		clearOutput();
		if (flags[kFLAGS.NEISA_FOLLOWER] == 0) {
			outputText("As you approach the cave a bunch of heavily armored guards stops you. You can barely see their faces under their helmets.\n\n");
			outputText("\"<i>Hey, you there! Hold! This cave is dangerous, we can’t just let you head in by yourself. You must go with someone else, where is your partner?</i>\"\n\n");
			outputText("Partner? What partner?\n\n");
			outputText("\"<i>Your teammate you moron. This place has claimed more adventurers lives then the wilds of Mareth by now. No one goes in there alone.</i>\"\n\n");
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
        outputText("Behind the desk in the central point of the shop you see a centauress. She has no fancy or provocative clothes, and sports an average body with which she moves quite gracefully around the shelves with items for sale despite her naturally larger body than most of the people living here have.");
        outputText("\n\n\"<i>Greetings, my name is Erma Swiftarrow and this is my shop. Go ahead and look around, if something catches your eyes let me know,</i>\" she say all that almost entirely in one breath after noticing your presence.");
        menu();
        addButton(0, weaponsrange.BOWLIGH.shortName, weaponrangeBuy, weaponsrange.BOWLIGH);
        addButton(1, weaponsrange.BOWHUNT.shortName, weaponrangeBuy, weaponsrange.BOWHUNT);
        addButton(2, weaponsrange.BOWLONG.shortName, weaponrangeBuy, weaponsrange.BOWLONG);
        addButton(3, weaponsrange.BOWKELT.shortName, weaponrangeBuy, weaponsrange.BOWKELT);
        addButton(5, weaponsrange.LCROSBW.shortName, weaponrangeBuy, weaponsrange.LCROSBW);
        addButton(6, weaponsrange.HUXBOW_.shortName, weaponrangeBuy, weaponsrange.HUXBOW_);
        addButton(7, weaponsrange.HEXBOW_.shortName, weaponrangeBuy, weaponsrange.HEXBOW_);
        //addButton(4, weapons.MACE.shortName, weaponBuy, weapons.MACE);
        //addButton(8, weapons.MACE.shortName, weaponBuy, weapons.MACE);//awl - wymagać bedzie możliwość lewitacji czy coś od PC aby to używać
        //addButton(9, weapons.MACE.shortName, weaponBuy, weapons.MACE);//bow made for soul cultivator xD
        addButton(13, "Training", ermaswiftarrowmerchantarcherytraining).hint("Archery training.");
        addButton(14, "Back", riverislandVillageStuff);
        statScreenRefresh();
    }

    private function weaponrangeBuy(itype:ItemType):void {
        clearOutput();
        outputText("The centauress nods at your purchase and replies: \"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
        //outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"");
        if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
            outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
            //Goto shop main menu
            doNext(ermaswiftarrowmerchant);
            return;
        }
        else outputText("\n\nDo you buy it?\n\n");
        //Go to debit/update function or back to shop window
        doYesNo(curry(debitWeaponRange,itype), ermaswiftarrowmerchant);
    }
    private function debitWeaponRange(itype:ItemType):void {
        flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
        statScreenRefresh();
        inventory.takeItem(itype, ermaswiftarrowmerchant);
    }
	
	public function ermaswiftarrowmerchantarcherytraining():void {
		clearOutput();
		if (flags[kFLAGS.ERMA_ARCHERY_TRAINING] > 0) outputText("\"<i>Need more training? Sure, but it's 10 spirit stones, and as usual paid up front.</i>\"");
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
				outputText("\n\nYou fellow Erma behind the shop into the backyard. She has a field there for target practice. You spend the better part of the day shooting arrows, practicing and improving your aim while Erma corrects your stance and gives advice. You leave the village with improved skills at archery.");
				if (!player.hasStatusEffect(StatusEffects.Kelt)) player.createStatusEffect(StatusEffects.Kelt, 10, 0, 0, 0);
				else player.addStatusValue(StatusEffects.Kelt, 1, 10);
				if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);
				doNext(camp.returnToCampUseSixHours);
			}
		}
	}

public function soularena():void {
	clearOutput();//arena do walk z przeciwnikami na exp tylko - zadnych sex scenes tylko walk do wygranej niewazne czy przez hp czy lust - przeciwnicy: ?weak deviant golem?, niskopoziomowi przeciwnicy uzywajacy soul skills (moze po prostu wesje zwyklych przeciwnikow ale z dodanymi soul attakami?)
	if (flags[kFLAGS.CHI_CHI_AFFECTION] >= 10 && flags[kFLAGS.CHI_CHI_AFFECTION] < 15 && !player.hasStatusEffect(StatusEffects.ChiChiOff)) chichiScene.EnterOfTheChiChi();
	else {
		outputText("Coming closer to the arena you see two muscular tigersharks standing on each side of the entrance, they only briefly glance at you the moment you pass by them. In few a moments after you entered, a tall, slightly muscular male cat-morph approaches you. Most of his body is covered by armor, yet two long tails wave behind him.");//osoba zarządzająca areną bedzie male nekomanta npc
		outputText("\n\n\"<i>Welcome to the Soul Arena. Don't start fights outside of the proper place or you will be thrown out. We have training facilities, and fights you can enter. Fights cost spirit stones. Make sure you have enough of them. We aren't a charity here,</i>\"");
		outputText(" without wasting time the nekomata overseer of this place explains to you all that you needed to know about the place and walks away.\n\nSo which of the three possible areas do you want to visit this time?");
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
			//addButton(5, "Gauntlet 6", gaunletchallange6).hint("Fight 8 diff enemies one after another.");gdzieś tam tu dodać grupowe tylko walki dające na pierwszej walce oblokowanie perków do powiekszania drużyny
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
			addButton(1, "Golemancer", arenaSelection,Jeniffer).hint("Golemancer goblin.");
			//addButton(2, "AyotechManiac", arenaSelection,Jinx).hint("Crazy girl wearing lots of belts... err Ayotech weapons.");
			addButton(5, "Macho Mander", arenaSelection,Syth).hint("He's Macho & Mander.");
			/*if () addButton(6, "Miss Mander", arenaSelection,Asuka).hint("Salamander woman.");
			else */addButton(6, "Miss Mander", arenaSelection,Asuka).hint("Young salamander girl.");
			//addButton(7, "Miss Oni", arenaSelection,Rangiku);
			addButton(9, "-1-", soularenaChallengeSubpages, page - 1);
			addButton(14, "Back", soularenaChallengeBack);
		}
	}
    private function arenaSelection(mon:Class):void{
		player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
		if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
		startCombat(new mon());
		monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
		monster.XP = monster.XP * 2;
    }
	public function gaunletsinbetween():void {
		cleanupAfterCombat();
		player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
	}
    public function gaunletchallange1fight1():void {
        clearOutput();
        outputText("You register for the gauntlet challenge, and wait patiently until you are called. You're motioned forward quickly, and move out beyond the arena gate to face your opponent. The crowd is big, you certainly have quite the audience! A man with a necktie and a weird stick screams across the area.\n\n");
        outputText("\"<i>Ladies and gentlemen! Today a new gladiator enters the arena seeking the glory of the gauntlet! A triple battle for gold and fame!</i>\"\n\n");
        outputText("The crowd cheers for you loudly.\n\n");
        outputText("\"<i>We start with an old timer everyone knows about. Even if this is only the warm up, don't count these statues out! Beware... the Dummy golems!!!</i>\"\n\n");
        outputText("A set of walking stone statues enter the arena, ready for battle. It seems you are to fight these first.\n\n");
        player.createStatusEffect(StatusEffects.SoulArena, 0, 0, 0, 0);
        player.createStatusEffect(StatusEffects.SoulArenaGaunlet, 0, 0, 0, 0);
        if (flags[kFLAGS.CHI_CHI_AFFECTION] < 10) flags[kFLAGS.CHI_CHI_AFFECTION]++;
        startCombat(new GolemsDummy());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
    }
    public function gaunletchallange1fight2():void {
        clearOutput();
		gaunletsinbetween();
		outputText("\n\nAs the last of the golems fall down, the commentator resumes.\n\n");
        outputText("\"<i>This one is straight from the woods. Freshly caught and horny to boot. Can our champion’s strength overcome the beast’s lust? LET'S FIND OUT!!</i>\"\n\n");
        outputText("A shadow moves out behind the gate, revealing the shape of a fluid starved tentacle beast.\n\n");
        startCombat(new TentacleBeast());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
    }
    public function gaunletchallange1fight3():void {
        clearOutput();
		gaunletsinbetween();
		outputText("\n\nAs the tentacle beast whimpers and crawls away, the crowd cheers for you. Here comes the final round.\n\n");
        outputText("\"<i>This contestant is smaller than the last two... She's smarter, and most of all, extremely deadly. She’s paid a handsome sack of gems daily to kick the ass of anyone who reaches this stage. This femme fatale is by far the deadliest combatant of her division. The crowd favorite huntress from the dark woods... Merisiel the dark elf!!!</i>\"\n\n");
        outputText("A woman with dark skin walks by the entrance of the arena with only a bow for a weapon. She sure does look like an elf. However, she’s nothing like the gentle creature from your childhood stories. She observes you with a cruel, calculating gaze. The dark elf readies her bow, smirking.\n\n");
        startCombat(new DarkElfScout());
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
		gaunletsinbetween();
		outputText("\n\nAs the goblin falls unconscious to the ground the crowd cheers you on.\n\n");
        outputText("\"<i>It would seems the hero squashed that midget good, but we're only just beginning. Our next contestant has been incarcerated for daring to break the laws of our fair city! For forcing his way in, and attempting to have his way with our fairest, he'll be here for a good long time! He's been kept locked up for two consecutive months. No sex, no masturbation... and he is desperate to sow his seed...Can the challenger take him on? Or will they take him...IN?! We now release... THE HOUND!!!</i>\"\n\n");
        outputText("A hellhound of massive proportions rush out of an opening gate. Its eyes burning with lust.\n\n");
        startCombat(new HellHound());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2fight3():void {
		clearOutput();
		gaunletsinbetween();
		outputText("\n\nThe mutt falls defeated to the floor as the crowd screams your name. The announcer announce the next contestant.\n\n");
        outputText("\"<i>The next opponent is a crowd favorite. You've heard her name told in shallow whispers. The silken jailer, the Bondswebber...The Bitch Breaker... That's right...Our next opponent is an expert of the dreaded art known as BDSM. Will the challenger hold her back? Or will the Mistress claim another victim?! Please welcome...Mistress...Malady!!!</i>\"\n\n");
        outputText("A drider in a bondage suit comes out of the gate and eyes you, amused.\n\n");
        outputText("\"<i>So... you are my opponent? You don’t look like much, little pet. By the time I’m done binding you, you will be calling me mistress!</i>\"\n\n");
        startCombat(new CorruptedDrider());
        monster.createStatusEffect(StatusEffects.NoLoot, 0, 0, 0, 0);
	}
	public function gaunletchallange2fight4():void {
		clearOutput();
		gaunletsinbetween();
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
			if (player.hasKeyItem("Golems, Animations and You") >= 0) addButtonDisabled(12, "G,A&Y Man.", "You already bought 'Golems, Animations and You' manual.");
			else addButton(12, "G,A&Y Man.", golemancershopPermGolemsUpgradesGuide).hint("Buy 'Golems, Animations and You' manual to make golems great again.");
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
		outputText("\"<i>Well as a matter of fact, I do. I give these away for first timers. You can have one and only one of those packages, got to keep myself competitive after all. <b>Still, you will owe me one.</b></i>\"\n\n");
		outputText("<b>You have now 15 golem cores in your bag for making new golems!</b>\n\n");
		player.addStatusValue(StatusEffects.GolemancerShop, 1, 1);
		flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] += 15;
		doNext(golemancershopRepeat);
	}
	private function golemancershopPermGolemsUpgradesGuide():void {
		clearOutput();
		outputText("You would like to buy a 'Golems, Animations and You' manual from her if she has one.\n\n");
		outputText("\"<i>As it happens, yes I do have one. It won't come cheap. ");
		menu();
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 1) {
			outputText("3000 gems and it's yours, how's that for a price?</i>\"");
			if (player.gems >= 3000) addButton(1, "Buy", golemancershopPermGolemsUpgradesGuideYes);
			else addButtonDisabled(1, "Buy", "You do not have enough gems to buy this.");
		}
		if (player.statusEffectv1(StatusEffects.GolemancerShop) == 0) {
			outputText("Come to think of it, you have been a very faithful customer... So I'll give you a one time deal. 500 gems and it's yours.</i>\"");
			if (player.gems >= 500) addButton(1, "Buy", golemancershopPermGolemsUpgradesGuideYes);
			else addButtonDisabled(1, "Buy", "You not have enough gems to buy this.");
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
		var cost:int = 1015 / 5;//zmniejszane do /10 dla golemancer pc?
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else if (flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
		else addButton(1, "Buy", buyItemEnergyCoreYes);
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemEnergyCoreYes():void {
		flags[kFLAGS.SPIRIT_STONES] -= 1015 / 5;// * 3
		statScreenRefresh();
		outputText("She counts the stones before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business, anything else you want to buy?</i>\"\n\n");
		flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES]++;
		doNext(golemancershopRepeat);
	}
	private function buyItemMechanism():void {
		clearOutput();
		var cost:int = 1200 / 5;//zmniejszane do /10 dla golemancer pc?
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else if (flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
		else addButton(1, "Buy", buyItemMechanismYes);
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemMechanismYes():void {
		flags[kFLAGS.SPIRIT_STONES] -= 1200 / 5;// * 3
		statScreenRefresh();
		outputText("She counts the stones before handing your purchase over.\n\n");
		outputText("\"<i>Always happy to do business, anything else you want to buy?</i>\"\n\n");
		flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES]++;
		doNext(golemancershopRepeat);
	}	
	private function buyItem(odd:ItemType):void {
		clearOutput();
		var cost:int = odd.value / 5;//zmniejszane do /10 dla golemancer pc?
		outputText("\"<i>That will be " + cost + " spirit stones. Show me da money baby.</i>\"\n\n");
		menu();
		if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
		else addButton(1, "Buy", curry(buyItemYes,odd));
		addButton(3, "Don't Buy", golemancershopRepeat);
	}
	private function buyItemYes(odd:ItemType):void {
		flags[kFLAGS.SPIRIT_STONES] -= odd.value / 5;// * 3
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
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff)) outputText("A dog morph that looks like a pekinese comes over to take your order.");
        else outputText("A literally blazing mouse girl come over to take your order. Her arms, legs and even her tail are on fire. ");
        outputText("\n\n\"<i>Hello my name is ");
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff)) outputText("Rin");
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
        if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 1 || player.hasStatusEffect(StatusEffects.ChiChiOff)) outputText("The waitress");
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
