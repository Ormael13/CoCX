/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.RiverDungeon;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
import classes.Scenes.API.MultiBuy;

public class JourneyToTheEast extends HeXinDaoAbstractContent implements SaveableState
	{
		public var riverdungeon:RiverDungeon = new RiverDungeon();

		public static var AhriStatsToPerksConvertCounter:Number;
		public static var AhriTavernTalks:Boolean;
		public static var AhriStatsToSuperPerksConvertCounter:Number;
		public static var EvelynnPerksToStatsConvertCounter:Number;
		public static var EvelynnTavernTalks:Boolean;
		public static var EvelynnCoreLimitBreakerCounter:Number;
		public static var DianaTavernTalks1:Boolean;
		public static var DianaTavernTalks2:Boolean;

		public function stateObjectName():String {
			return "JourneyToTheEast";
		}

		public function resetState():void {
			AhriStatsToPerksConvertCounter = 0;
			AhriTavernTalks = false;
			AhriStatsToSuperPerksConvertCounter = 0;
			EvelynnPerksToStatsConvertCounter = 0;
			EvelynnTavernTalks = false;
			EvelynnCoreLimitBreakerCounter = 0;
			DianaTavernTalks1 = false;
			DianaTavernTalks2 = false;
		}

		public function saveToObject():Object {
			return {
				"AhriStatsToPerksConvertCounter": AhriStatsToPerksConvertCounter,
				"AhriTavernTalks": AhriTavernTalks,
				"AhriStatsToSuperPerksConvertCounter": AhriStatsToSuperPerksConvertCounter,
				"EvelynnPerksToStatsConvertCounter": EvelynnPerksToStatsConvertCounter,
				"EvelynnTavernTalks": EvelynnTavernTalks,
				"EvelynnCoreLimitBreakerCounter": EvelynnCoreLimitBreakerCounter,
				"DianaTavernTalks1": DianaTavernTalks1,
				"DianaTavernTalks2": DianaTavernTalks2
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				AhriStatsToPerksConvertCounter = o["AhriStatsToPerksConvertCounter"];
				AhriTavernTalks = o["AhriTavernTalks"];
				AhriStatsToSuperPerksConvertCounter = valueOr(o["AhriStatsToSuperPerksConvertCounter"], 0);
				EvelynnPerksToStatsConvertCounter = valueOr(o["EvelynnPerksToStatsConvertCounter"], 0);
				EvelynnTavernTalks = valueOr(o["EvelynnTavernTalks"], false);
				EvelynnCoreLimitBreakerCounter = valueOr(o["EvelynnCoreLimitBreakerCounter"], 0);
				DianaTavernTalks1 = valueOr(o["DianaTavernTalks1"], false);
				DianaTavernTalks2 = valueOr(o["DianaTavernTalks1"], false);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function JourneyToTheEast()
		{
			Saves.registerSaveableState(this);
		}

		public function enteringInn(first:Boolean = true):void {
			clearOutput();
			if(first){
				outputText("You enter the town local Inn ‘Journey to the East’ and look around. ");
			}
			outputText("You can see many people enjoying a meal or drink in the dining hall. Behind his counter, a barman moves to and fro, serving drinks or polishing a glass in front of him with a rag.");
			/*if (flags[kFLAGS.CHI_CHI_FOLLOWER] != 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5 && !player.hasStatusEffect(StatusEffects.ChiChiOff) && !SceneLib.chichiScene.ChiChiKickedOut && model.time.hours >= 18 && rand(4) == 0) {
				SceneLib.chichiScene.ChiChiDrunkSex();
				return;
			}*/
			menu();
			addButton(0, "Drink", drinkAlcohol);
			addButton(2, "Felix", shadyPerson).hint("A strange two-headed chimera with two tails is sitting near the bar.");
			addButton(4, "Adv.Guild", SceneLib.adventureGuild.BoardkeeperYangMain);
			//addButton(5, "Monkey", SceneLib.waizabi.bimboMonkey).hint("You see a massive-breasted woman sitting at a table on your right. At first, she seems human, but as you look, her monkey tail flicks up, grabbing her drink and bringing it to her lips. Her body is heavily muscled, almost amazonian.");//monkey bimbo go go - Waiz'abi
			if (workHoursMadam() || workHoursTemptress()) addButton(6, "5/0/0", tableNo5);
			else addButtonDisabled(6, "5/0/0", "Table No. 5 is curently empty.");
			if (flags[kFLAGS.MICHIKO_FOLLOWER] < 1) addButton(8, "???", SceneLib.michikoFollower.firstMeetingMichiko).hint("You see a suspicious looking squirrel in one corner, nursing a drink and small bowl of peanuts.");
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] < 2 && player.isPureHuman()) {
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] < 1) addButton(9, "???", firstTimeMeetingNekomataBoy).hint("A strange cat morph with two tails is sitting at one of the tables muttering to himself.");
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 1) addButton(9, "???", firstTimeMeetingNekomataBoy).hint("A strange cat morph with two tails is sitting at one of the tables muttering to himself.");
			}
			if (flags[kFLAGS.NEISA_FOLLOWER] == 1) addButton(10, "ShieldMaiden", firstTimeMeetingNeisa);
			if (flags[kFLAGS.NEISA_FOLLOWER] == 2) addButton(10, "Neisa", meetingNeisaAfterDecline);
			if (flags[kFLAGS.NEISA_FOLLOWER] == 3) addButton(10, "Neisa", NeisabutPCgotKOd);
			if (flags[kFLAGS.NEISA_FOLLOWER] == 4 || flags[kFLAGS.NEISA_FOLLOWER] == 5) addButton(10, "Neisa", meetingNeisaPostDungeonExploration).hint("Neisa is sitting at a table enjoying one of the local drinks.");
			if (flags[kFLAGS.NEISA_FOLLOWER] == 6) addButton(10, "Neisa", meetingNeisaPostDungeonExploration2).hint("Neisa is sitting at a table enjoying one of the local drinks.");
			if (DianaTavernTalks1) addButton(11, "Healer", dianaAtJttEMain).hint("You see a horse woman healer sitting at a table on your left.");
			else addButton(11, "???", dianaAtJttEMain).hint("You see a horse woman sitting at a table on your left.");
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}

		private function drinkAlcohol():void {
			clearOutput();
			outputText("You go sit at the counter. After a few minutes, the barman comes over to take your order.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 16) outputText("afternoon");
			else outputText("morning");
			outputText(" " + player.mf("mister", "miss") + ", what can I get you?</i>\"\n\n");
			menu();
			addButton(0, "ManUp B", confirmBuyDrink, consumables.MANUP_B, 1).hint("1 spirit stone");
			addButton(1, "Gob.Ale", confirmBuyDrink, consumables.GOB_ALE, 1).hint("1 spirit stone");
			addButton(2, "OrcMead", confirmBuyDrink, consumables.ORCMEAD, 1).hint("1 spirit stone");
			addButton(3, "OniSake", confirmBuyDrink, consumables.ONISAKE, 1).hint("1 spirit stone");
			addButton(5, "Fiery S", confirmBuyDrink, consumables.FIERYS_, 1).hint("1 spirit stone");
			addButton(6, "SalamFW", confirmBuyDrink, consumables.SALAMFW, 1).hint("1 spirit stone");
			addButton(7, "NoceLiq", confirmBuyDrink, consumables.NOCELIQ, 2).hint("2 spirit stones");
			addButton(8, "Asumaki", confirmBuyDrink, consumables.ASKIRIN, 2).hint("2 spirit stones");
			addButton(12, "BimboL", confirmBuyDrink, consumables.BIMBOLQ, 100).hint("100 spirit stones");
			addButton(13, "BroBrew", confirmBuyDrink, consumables.BROBREW, 100).hint("100 spirit stones");
			addButton(14, "Back", notThirsty);
		}
		private function confirmBuyDrink(itype:ItemType, price:int):void {
			var descString:String = "You ask for " + itype.longName + ".\n\n";
			var onBuyString:String = "\n\nThe barman hands over the drink you ordered.\n\n";

			var priceRate:Number = itype.value / price;

			MultiBuy.confirmBuyMulti(drinkAlcohol, "The barman", priceRate, itype, descString, onBuyString, true);
		}

		//drink list (to be expanded) some generic nonTF beers
		private function notThirsty():void {
			clearOutput();
			outputText("In the end you realise you are not thirsty after all and wave a goodbye before leaving.\n\n");
			doNext(enteringInn,false);
		}

		private function shadyPerson(second:Boolean = true):void {
			clearOutput();//Felix - male beffy bro nekomata twin herald npc
			if (second) {
				outputText("You approach the table seeing very peculiar looking being. It almost looks like someone took a cat and dog morph, then stuck them together.\n\n They have two heads, two pairs of arms and even two tails. ");
				outputText("Left side of body looking clearly canine with dog shaped head. It swivels around, constantly scanning the bar for threats. The right head seems feline, but unlike most cat races you've seen, this person has noticable musculature. Seeing your approach, the cat head turns toward you. Its pupils dialate slightly, and it stares at you with feline interest.\n\n");
			}
			outputText("\"<i>Welcome to 'Felix's Corner' traveler. Do you wanna buy something?</i>\" asks the cat head ending it with a short purr. \"<i>We have wares if you have the spirit stones.</i>\"\n\n");
			outputText("After that the other head stops looking around, baring its teeth at you. \"<i>If you not interested in buying anything, then get lost... we don't have all day.</i>\"\n\n");
			menu();
			addButton(7, necklaces.NECRONE.shortName, itemBuy, necklaces.NECRONE).hint("120 spirit stones");
			addButton(8, weapons.NECROWA.shortName, itemBuy, weapons.NECROWA).hint("128 spirit stones");
			addButton(9, shields.NECROSH.shortName, itemBuy, shields.NECROSH).hint("100 spirit stones");
			addButton(10, necklaces.EZEKIELN.shortName, itemBuy, necklaces.EZEKIELN).hint("50 spirit stones");
			addButton(11, headjewelries.EZEKIELC.shortName, itemBuy, headjewelries.EZEKIELC).hint("40 spirit stones");
			addButton(12, jewelries.EZEKIELS.shortName, itemBuy, jewelries.EZEKIELS).hint("10 spirit stones");
			addButton(13, miscjewelries.EZEKIELSL.shortName, itemBuy, miscjewelries.EZEKIELSL).hint("80 spirit stones");
			addButton(14, "Back", curry(enteringInn,false));
			statScreenRefresh();
		}
		private function itemBuy(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>That'll be " + itype.value / 10 + " spirit stones.</i>\"");
			//outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"");
			if(flags[kFLAGS.SPIRIT_STONES] < itype.value / 10) {
				outputText("\n\nYou count out your spirit stones and realize it's beyond your price range.");
				//Goto shop main menu
				doNext(shadyPerson,false);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			//Go to debit/update function or back to shop window
			doYesNo(curry(debitItem,itype), curry(shadyPerson,false));
		}
		private function debitItem(itype:ItemType):void {
			flags[kFLAGS.SPIRIT_STONES] -= itype.value / 10;
			statScreenRefresh();
			inventory.takeItem(itype, curry(shadyPerson,false));
		}

		private function tableNo5():void {
			clearOutput();
			outputText("You can see many people enjoying a meal or drink in the dining hall. Behind his counter, a barman moves to and fro, serving drinks or polishing a glass in front of him with a rag.");//later make more exclusive text here
			menu();
			if (workHoursMadam()) {
				if (AhriTavernTalks) addButton(0, "Madam", visitMadam).hint("You see the 'Madam' sitting at the table.");
				else addButton(0, "???", visitMadam).hint("You see mysterious looking animal-morph sitting at the table.");//Ahri
			}
			else if (AhriTavernTalks) addButtonDisabled(0, "Madam", "'Madam' isn't currently at her usual spot at table in the inn.");
			if (workHoursTemptress()) {
				if (EvelynnTavernTalks) addButton(1, "Temptress", visitTemptress).hint("You see 'Temptress' sitting at the table.");
				else addButton(1, "???", visitTemptress).hint("You see mysterious looking devil sitting at the table.");//Evelynn
			}
			else if (EvelynnTavernTalks) addButtonDisabled(1, "Temptress", "'Temptress' isn't currently at her usual spot at table in the inn.");
			addButton(14, "Back", curry(enteringInn,false));
		}
		private function workHoursMadam():Boolean {
			return (model.time.hours >= 7 && model.time.hours <= 9) || (model.time.hours >= 18 && model.time.hours <= 22);

		}
		private function visitMadam():void {
			clearOutput();
			if (AhriTavernTalks) outputText("\"<i>You came back? What do you seek from this Madam?</i>\" You can swear to see her eyes glow for a moment under the hood as she looks at you. \"<i>Another session to exchange your grown potential to increased ability to develop mystical abilities?</i>\"\n\n");
			else {
				outputText("You see a person covered wholy by the loose robe. For a moment it looks like it not noticed your presence next to it.\n\n");
				outputText("\"<i>Greeting potential customer. You can call me Madam,</i>\" clearly female voice with undeniable subtle charm interrupts the silence. \"<i>You came to our table seeking my services? I am not able to provide much... aside from something i call... 'conversion'.</i>\"\n\n");
				outputText("Conversion? Seeing your puzzle expression she continues, \"<i>I would take a bit of your grown potential to exchange it for increased ability to develop mystical abilities. But...</i>\" she make a gesture with one of her hands showing briefly her hand with five outstretched fingers \"<i>...I shall only do this ten times. No more and no less than ten.</i>\"\n\n");
				outputText("Just like that? Without any string attatched?\n\n");
				outputText("\"<i>Of course there would be additional price. Ten spirit stones.</i>\" She pause before asking \"<i>So, dear customer, would you like me to perform this conversion on you?</i>\"\n\n");
				AhriTavernTalks = true;
			}
			menu();
			addButton(1, "Convert", visitMadamConvert);
			addButton(3, "Back", tableNo5);
		}
		private function visitMadamConvert():void {
			clearOutput();
			if (flags[kFLAGS.SPIRIT_STONES] < 10) {
				outputText("\"<i>Ten Spirit Stones.</i>\" Madam shakes her head, \"<i>Come see me again when you gather them.</i>\"\n\n");
				doNext(visitMadam);
			}
			else if (player.statPoints < 5) {
				outputText("\"<i>Seems your grown potential isn't sufficient.</i>\" Madam shakes her head, \"<i>Come see me again when it would increase.</i>\"\n\n");
				doNext(visitMadam);
			}
			else if (AhriStatsToPerksConvertCounter > 9 && AhriTavernTalks > 0) {
				outputText("\"<i>It's unfotunate but I can't help you anymore,</i>\" Madam rise her hand to show five fingers, \"<i>My service can be repeated maximum ten times and you, dear customer, have reached this limit.</i>\"\n\n");
				doNext(visitMadam);
			}
			else {
				outputText("After recieving payment Madam reaches down to her belt, depositing them into a small pouch. \"<i>Come we can't do 'it' here</i>\". She leads you into a short corridor at the back of the inn, with several rooms just off it. Opening one of the side room doors, she motions for you to come inside.\n\n");
				outputText("\"<i>Please sit down. This process is strenuous, and will take some time.</i>\" She points toward a sofa in the middle of the room. You sit, and she walks behinds you. \"<i>Dear customer, please close your eyes.</i>\" Her voice is low, humming...almost buzzing. It's somehow both calming and enticing at once.\n\n");
				outputText("You close your eyes as a strange energy fills your body. Nervousness washed away by her voice, you begin to nod off as the energy spreads. Starting from the sides of you head, down to your jaw... It feels extremely comfortable. Unwilling to move a muscle, you relax, drifting off. \n\n");
				outputText("When you wake up, you groan, stretching your limbs. You're filled with a vaguely empty feeling in your muscles, but your brain feels...expanded, somehow. You snap awake, realizing that you're still in the inn. Looking around, there is nobody else in the room, with the door left wide open, almost like madam wanted to say 'return on your own'. Slightly unsatisfied, you return to the drinking hall.\n\n");
				if (AhriStatsToPerksConvertCounter > 0) AhriStatsToPerksConvertCounter += 1;
				else AhriStatsToPerksConvertCounter = 1;
				if (AhriStatsToSuperPerksConvertCounter > 0) {
					AhriStatsToSuperPerksConvertCounter -= 1;
					player.superPerkPoints += 1;
				}
				else AhriStatsToSuperPerksConvertCounter = 1;
				flags[kFLAGS.SPIRIT_STONES] -= 10;
				player.statPoints -= 5;
				player.perkPoints += 1;
				doNext(enteringInn,false);
				advanceMinutes(30);
			}
		}
		private function workHoursTemptress():Boolean {
			return (model.time.hours >= 8 && model.time.hours <= 9) || (model.time.hours >= 18 && model.time.hours <= 23);

		}
		private function visitTemptress():void {
			clearOutput();//Temptress - female displacer devil npc for perk points to stat points conversion outputText("\"<i></i>\"\n\n");
			if (EvelynnTavernTalks) outputText("\"<i>Did you came back longing for more?</i>\" Her eyes glow for a moment under the hood, her gaze piercing through you. \"<i>Another touch? You wish to exchange your experiences and skills for additional potential?</i>\"\n\n");
			else {
				outputText("You see a person covered entirely by a loose robe. She looks around until she finally notices you staring at her.\n\n");
				outputText("A sultry voice, feminine and sizzling, interrupts the silence. \"<i>Hello, customer. I'm Temptress,</i>\" She smiles slightly, beckoning to you with one hand. \"<i>You came to this table seeking my services? I can provide you with 'change'.</i>\"\n\n");
				outputText("Change? Seeing your puzzle expression she continues, \"<i>I would take a bit of your ability to develop mystical abilities to exchange it for increased grown potential. But...</i>\" she make a gesture with one of her hands showing briefly her hand with five outstretched fingers ending with long, sharp finger claws \"<i>...I would only do this ten times.</i>\"\n\n");
				outputText("Just like that? Without any strings attatched?\n\n");
				outputText("\"<i>Of course there would be additional price for my services. Ten spirit stones.</i>\" She pauses before asking \"<i>So are you here to be mesmerized or not?</i>\"\n\n");
				EvelynnTavernTalks = true;
			}
			menu();
			addButton(1, "Convert", visitTemptressConvert);
			addButton(3, "Back", tableNo5);
		}
		private function visitTemptressConvert():void {
			clearOutput();
			if (flags[kFLAGS.SPIRIT_STONES] < 10) {
				outputText("\"<i>Ten Spirit Stones.</i>\" Temptress almost whispers, \"<i>Come back when you have them.</i>\"\n\n");
				doNext(visitTemptress);
			}
			else if (player.perkPoints < 1) {
				outputText("\"<i>Seems your ability to develop your abilities is lacking.</i>\" Temptress sounds... disappointed, \"<i>Come see me again when it increases.</i>\"\n\n");
				doNext(visitTemptress);
			}
			else if (EvelynnPerksToStatsConvertCounter > 9 && EvelynnTavernTalks > 0) {
				outputText("\"<i>Ahh I did told you didn't I?</i>\" Temptress says with a sad voice, \"<i>My services can be repeated only ten times and you used them all.</i>\"\n\n");
				doNext(visitTemptress);
			}
			else {
				outputText("After recieving payment Temptress takes them, bringing them to a pouch at her waist. \"<i>Let's move to a more... private place.</i>\" she leads you into a short corridor at the back of the inn, with several rooms just off it. Opening one of the side room doors, she motions for you to come inside..\n\n");
				outputText("\"<i>Lay down comfortable and close your eyes.</i>\" She points towards a luxurious bed. You lie down, and she sits beside you, taking your head in her hands. \"<i>All it takes is a simple touch.</i>\". She rests your head on the pillows, then taps your chest with one hand. t\n\n");
				outputText("While the closeness is nice, as she touches your chest, it begins to tingle, warmth spreading through your chest and stomach. The warmth seems to dissolve your muscles, soft warmth leaving you barely willing to move a finger. Surprisingly, you're not alarmed, you're comforted. You sigh, closing your eyes and drifting off, the bone-deep warmth spreading further.\n\n");
				outputText("When you wake up, your head feels tighter, and yet at the same time your body feels looser, ready to improve. Looking around there is nobody beside you in the room, the door wide open. Looks like after doing her part, Temptress already left. Slightly unsatisfied you return to the drinking hall.\n\n");
				if (EvelynnPerksToStatsConvertCounter > 0) EvelynnPerksToStatsConvertCounter += 1;
				else EvelynnPerksToStatsConvertCounter = 1;
				if (EvelynnCoreLimitBreakerCounter > 0) EvelynnCoreLimitBreakerCounter += 1;
				else EvelynnCoreLimitBreakerCounter = 1;
				flags[kFLAGS.SPIRIT_STONES] -= 10;
				player.statPoints += 5;
				player.perkPoints -= 1;
				doNext(enteringInn,false);
				advanceMinutes(30);
			}
		}

		public function dianaAtJttEMain():void {
			clearOutput();//\"<i></i>\"
			if (DianaTavernTalks1) outputText("\"<i>You came again.</i>\" Her eyes alight with anticipation. \"<i>Do you need any healing or curing?</i>\"");
			else {
				outputText("\"<i>Greetings, I am a healer. Anyone that has any health problems or issues can come to me and I will lend aid.</i>\" Her eyes dart to her sides before returning to you, \"<i>With an appropriate price, of course.</i>\" The Horse-morph pauses, \"<i>So. Do you need any healing or curing ailments?</i>\"");
				DianaTavernTalks1 = true;
			}
			menu();
			if (player.HP < player.maxOverHP()) addButtonIfTrue(0, "Healing", dianaAtJttEMainHeal, "You need to have 50 gems.", player.gems >= 50);
			else addButtonDisabled(0, "Healing", "You're fully healed already.");
			if ((player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained") || player.statStore.hasBuff("Damaged")) && flags[kFLAGS.DIANA_CURE_COOLDOWN] <= 0) {
				addButtonIfTrue(1, "C.C.(Base)", dianaAtJttEMainCurses1, "You need to have 150 gems.", player.gems >= 150, "Cure curses that affect stats non-multiplier bonuses.");
				addButtonIfTrue(2, "C.C.(Mult)", dianaAtJttEMainCurses2, "You need to have 150 gems.", player.gems >= 150, "Cure curses that affect stats multiplier bonsues.");
			}
			else if (flags[kFLAGS.DIANA_CURE_COOLDOWN] > 0) {
				addButtonDisabled(1, "C.C.(Base)", "Healer is not yet ready to cure your curses again.");
				addButtonDisabled(2, "C.C.(Mult)", "Healer is not yet ready to cure your curses again.");
			}
			else {
				addButtonDisabled(1, "C.C.(Base)", "You don't have any curses to cure. (non-multiplier)");
				addButtonDisabled(2, "C.C.(Mult)", "You don't have any curses to cure. (multiplier)");
			}
			addButton(14, "Back", curry(enteringInn,false));
		}
		public function dianaAtJttEMainHeal():void {
			clearOutput();
			player.gems -= 50;
			outputText("You ask if she could tend to your injuries, to which she perks up, rubbing her hands together with grinning eyes, \"<i>Of course I can!</i>\"\n\n");
			outputText("The horse-morph stands up, walking around you as she stops at your back before moving her hands across your [skin], making you gasp as you feel a strong tingling sensation from her fingertips. Sparks of magic dance across your [skin] as her potent magic washes away your pains and injuries.\n\n");
			outputText("The sparks intensify, becoming almost painful, causing you to grimace, but she quickly hushes you as the sound touch from her on your body soothes the pain. Then, it's all over as Nadia lets go, taking a step back. Your wounds have sealed, and injuries fade as if they never existed.\n\n");
			if (player.hasStatusEffect(StatusEffects.CombatWounds)) {
				if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.2) player.addStatusValue(StatusEffects.CombatWounds, 1, -0.2);
				else player.removeStatusEffect(StatusEffects.CombatWounds);
			}
			HPChange(player.maxOverHP() * 0.25, true);
			EngineCore.changeFatigue( -(Math.round(player.maxFatigue() * 0.125)));
			doNext(dianaAtJttEMain);
			advanceMinutes(15);
		}
		public function dianaAtJttEMainCurses1():void {
			clearOutput();
			player.gems -= 150;
			flags[kFLAGS.DIANA_CURE_COOLDOWN] = 8;
			outputText("You ask if she can cure your curses, to which she nods. The horse-morph stands up and walks around you, stopping at your back. She begins to move her hands across your body, rubbing your [skin], forcing a small gasp as you feel a strong tingling sensation from her fingertips as it washes away your curses.\n\n");
			outputText("The sparks of magic intensify, to an almost painful state. Your grimace, but she quickly hushes you, her soft touch of your body soothing the pain. Then, it's over. She steps back as your curses have lessened.\n\n");
			for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
				player.removeCurse(stat, 5,1);
				player.removeCurse(stat, 5,2);
				player.removeCurse(stat, 5,3);
			}
			doNext(dianaAtJttEMain);
			advanceMinutes(15);
		}
		public function dianaAtJttEMainCurses2():void {
			clearOutput();
			player.gems -= 150;
			flags[kFLAGS.DIANA_CURE_COOLDOWN] = 8;
			outputText("You ask if she can cure your curses, to which she nods. The horse-morph stands up and walks around you, stopping at your back. She begins to move her hands across your body, rubbing your [skin], forcing a small gasp as you feel a strong tingling sensation from her fingertips as it washes away your curses.\n\n");
			outputText("The sparks of magic intensify, to an almost painful state. Your grimace, but she quickly hushes you, her soft touch of your body soothing the pain. Then, it's over. She steps back as your curses have lessened.\n\n");
			for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
				if (stat != "sens")
				{
					player.removeCurse(stat+".mult", 0.05,1);
					player.removeCurse(stat+".mult", 0.05,2);
					player.removeCurse(stat+".mult", 0.05,3);
				}
			}
			doNext(dianaAtJttEMain);
			advanceMinutes(30);
		}

		public function NeisabutPCgotKOd():void {
			clearOutput();
			outputText("As you walk towards Neisa, she does a double take as she sees you alive and well.");
			outputText("\"Well damn. How'd you survive.... never mind. I don't want to know. You still owe me for that expedition, so I'll be waiting here until you're better prepared.\"");
			outputText("Unless... you want to go back in now?")
			menu();
			addButton(1, "Yes", reenteringTheDungeon).hint("That will make you go to the dungeon right away!");
			addButton(3, "No", firstTimeMeetingNeisaNo);
		}
		public function reenteringTheDungeon():void{
			outputText("\n\nWith a nod, you shake her hand, and she gets up from her chair, before the two of you head back towards the dungeon.");
			enterDungeonWithNeisa();
		}

		public function enterDungeonWithNeisa():void {
			var strNeisa:Number = 50;
			strNeisa *= (1 + (0.2 * player.newGamePlusMod()));
			strNeisa = Math.round(strNeisa);
			var meleeAtkNeisa:Number = 12;
			meleeAtkNeisa += (1 + (int)(meleeAtkNeisa / 5)) * player.newGamePlusMod();
			player.createStatusEffect(StatusEffects.CombatFollowerNeisa, strNeisa, meleeAtkNeisa, 0, 0);
			flags[kFLAGS.PLAYER_COMPANION_1] = "Neisa";
			doNext(riverdungeon.enterDungeon);
		}

		public function firstTimeMeetingNeisa():void {
			clearOutput();
			outputText("A woman in heavy armor is sitting on one of the chairs. You can barely see her blue eyes and black hair, hidden under a thick visor attached to her helmet.\n\n");
			outputText("\"<i>What are you looking at? If it's for a job, you came to the right place. Name's Neisa. Pay me right, and my blade is yours. If you're not gonna hire me, then you can get away from me and leave me to my drink.</i>\"\n\n");
			outputText("You sit down, giving Neisa an interested look. She sits up, cracking her knuckles. You tell Neisa that yes, you're looking for a hired sword. One unafraid to enter that cave near the back of He'Din Xiao. \n\n");
			outputText("She rolls her eyes, giving you a wave of the hand. \"<i>Oh this again? Not surprised there. Must've been ten people that went down there alone and never came back. The guards are probably sick of their crap. Sure I could accompany you in there...But for a price. The treasure in that cave? I want it. Hell, it doesn't look like you are getting in otherwise. What'll it be?</i>\"\n\n");
			outputText("Do you purchase the mercenary's Services?\n\n");
			menu();
			addButton(1, "Yes", firstTimeMeetingNeisaYes).hint("That will make you go to the dungeon right away!");
			addButton(3, "No", firstTimeMeetingNeisaNo);
		}
		public function firstTimeMeetingNeisaYes():void {
			outputText("You shake hand with the mercenary sealing the deal.\n\n");
			outputText("\"<i>You won’t regret it. Down there, everything counts. By the way names Neisa try not to forget it too fast.</i>\"\n\n");
			outputText("Well you finally can enter the dungeon. You guess having another warrior with you should at least reduce the chance whatever lives in there gets a shot at using your prone body if your defeated.\n\n");
			outputText("Seeing as you come in pair the guards let you in thought with a final warning.\n\n");
			outputText("\"<i>Try not to die down there. A lot of people went in and never came back.</i>\"\n\n");
			outputText("You will keep that in mind.\n\n");
			flags[kFLAGS.NEISA_FOLLOWER] = 3;
			enterDungeonWithNeisa();
		}
		public function firstTimeMeetingNeisaNo():void {
			outputText("You are not interested into a mercenary right now but you thank her for proposing. She shrugs it off.\n\n");
			outputText("\"<i>No skin off my back. Come back over if ya change your mind.</i>\"\n\n");
			flags[kFLAGS.NEISA_FOLLOWER] = 2;
			doNext(enteringInn,false);
		}
		public function meetingNeisaAfterDecline():void {
			outputText("The mercenary come to attention as you approach her.\n\n");
			outputText("\"<i>So changed your mind about it?</i>\"\n\n");
			outputText("Do you hire her?\n\n");
			menu();
			addButton(1, "Yes", firstTimeMeetingNeisaYes).hint("That will make you go to the dungeon right away!");
			addButton(3, "No", firstTimeMeetingNeisaNo);
		}
		public function meetingNeisaPostDungeonExploration():void {
			if (flags[kFLAGS.NEISA_FOLLOWER] == 5) {
				outputText("You walk up to Neisa who reminds you right away.\n\n");
				outputText("\"<i>I work for 1 spirit stone a day and payment is once per week. This is not negotiable.</i>\"\n\n");
			}
			else {
				outputText("You walk up to Neisa who acknowledges your presence right away.\n\n");
				outputText("\"<i>Aye [name] how's the adventuring going? I've been without a contract for a while now and it so happens I could lend you my services. Only 1 spirit stone a day, paid out once per week, I need something to subsist on.</i>\"\n\n");
				outputText("Do you hire her?\n\n");
			}
			menu();
			addButton(1, "Hire her", meetingNeisaPostDungeonExplorationHireHer);
			addButton(3, "No", meetingNeisaPostDungeonExplorationNo);
		}
		public function meetingNeisaPostDungeonExploration2():void {
			outputText("Neisa gets to the point right away.\n\n");
			outputText("\"<i>I'm still waiting for those 10 spirit stone you owe me [name].</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] >= 10) addButton(1, "Pay", meetingNeisaPostDungeonExplorationPay);
			else addButtonDisabled(1, "Pay", "You still not have 10 spirit stones to pay back.");
			addButton(3, "Don't pay", meetingNeisaPostDungeonExplorationDontPay);
		}
		public function meetingNeisaPostDungeonExplorationDontPay():void {
			outputText("You walk away to go get the cash. You're lucky she doesn't send the city guards on your back.\n\n");
			doNext(enteringInn,false);
		}
		public function meetingNeisaPostDungeonExplorationPay():void {
			flags[kFLAGS.SPIRIT_STONES] -= 10;
			outputText("You hand over the payment, Neisa counting to be sure.\n\n");
			outputText("\"<i>Looks like we're even. I'll pass on the fact you skipped the payment. Feel free to hire me again...so long as you can afford it.</i>\"\n\n");
			menu();
			addButton(1, "Hire her", meetingNeisaPostDungeonExplorationHireHer);
			addButton(3, "No", meetingNeisaPostDungeonExplorationNo);
		}
		public function meetingNeisaPostDungeonExplorationHireHer():void {
			outputText("Neisa packs up her things, ready to accompany you.\n\n");
			outputText("\"<i>Well lead the way, Boss.</i>\"\n\n");
			outputText("(<b>Neisa has been added to the Followers menu!</b>)\n\n");
			if (flags[kFLAGS.NEISA_FOLLOWER] < 6) {
				flags[kFLAGS.NEISA_LVL_UP] = 1;
				flags[kFLAGS.NEISA_DEFEATS_COUNTER] = 0;
				if (flags[kFLAGS.NEISA_AFFECTION] < 10) flags[kFLAGS.NEISA_AFFECTION] = 1;
			}
			flags[kFLAGS.NEISA_FOLLOWER] = 7;
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetingNeisaPostDungeonExplorationNo():void {
			outputText("Nah, you don't have that much right now.\n\n");
			outputText("\"<i>Well, shit. I hope whatever you meet out there doesn't outright kill or fuck the soul out of you then. See me again if you ever change your mind.</i>\"\n\n");
			if (flags[kFLAGS.NEISA_FOLLOWER] == 4) flags[kFLAGS.NEISA_FOLLOWER] = 5;
			doNext(enteringInn,false);
		}

		public function firstTimeMeetingNekomataBoy():void {
			clearOutput();
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 1) {
				outputText("You wave again at the sketchy cat morph.\n\n");
				outputText("\"<i>Hey it's you, the human! Have you thought it through and are you ready to take on my offer? There's 3000 gems down the line if you say yes.</i>\"\n\n");
			}
			else {
				outputText("You wave at the weird cat morph who lifts his eyes from his drink to acknowledge you then opens his eyes wide in surprise.\n\n");
				outputText("\"<i>A real human, here of all places? You just came at the perfect time "+player.mf("mister","miss")+"!</i>\"\n\n");
				outputText("The perfect time?\n\n");
				outputText("\"<i>I am a researcher studying the flow of Chi in the human body, the spiritual energy outsiders calls soulforce. I would like you to assist me in proving my thesis that humans are naturally disposed to soulforce.</i>\"\n\n");
				outputText("What is in it for you?\n\n");
				outputText("\"<i>Gems… how about three thousand? I know you outsiders have no interest in spirit stones and all I need is your collaboration here and now.</i>\"\n\n");
				outputText("Why now… he sure did make an interesting offer. Do you shake hands and seal the deal with him?"+(flags[kFLAGS.PATCHOULI_FOLLOWER] >= 2 ? " Something tells you catmorphs aren't exactly the most trustworthy of people. It might be Patchouli who's getting in your head again.":"")+"\n\n");
			}
			menu();
			addButton(1, "No", firstTimeMeetingNekomataBoyNo);
			addButton(3, "Yes", firstTimeMeetingNekomataBoyYes);
		}
		public function firstTimeMeetingNekomataBoyNo():void {
			outputText("Yeah no, this is looking too good to be true and truth be told it likely is. You tell the sketchy cat you will pass on it for now and head back towards the bar.\n\n");
			flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 1;
			doNext(enteringInn,false);
		}
		public function firstTimeMeetingNekomataBoyYes():void {
			clearOutput();
			outputText("You shake hand with the twin tailed cat morph.\n\n");
			outputText("\"<i>It's a deal! Now come over to my house, I will get those tests done fast and then you can leave three thousand gems richer.</i>\"\n\n");
			outputText("He leads you to a big house at the far side of town and once inside, shows you the way to his lobby.\n\n");
			outputText("\"<i>After you, just go sit in the chair on the side, close your eyes and relax.</i>\"\n\n");
			outputText("You walk down the stairs then head for a chair to the side but just as you head for the seat you're suddenly struck by something heavy behind the head.\n\n");
			flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 2;
			doNext(firstTimeMeetingNekomataBoyYesPart2);
		}
		public function firstTimeMeetingNekomataBoyYesPart2():void {
			clearOutput();
			outputText("You wake up a few minutes later strapped to what appears to be a table. Your mind feels hazy, as if you were floating in the fog.\n\n");
			outputText("\"<i>Awake so soon? Well I guess that’s fine, it’s not like I don't enjoy when they struggle anyway. Can you even hear me in there? Well that's unlikely, what with all the sedative I injected in you, couldn't afford you waking and putting up a fight while I was playing dress up right?</i>\"\n\n");
			outputText("The cat morph chuckles to himself and you indeed notice the guy took his time to rid you of your armor, weaponry and other troublesome equipment. You're now dressed in what appears to be traditional oriental clothes fit for a "+player.mf("man","woman albeit of a somewhat risqué style")+", he even took the time to braid your hair.\n\n");
			outputText("\"<i>See, I have a client up there who is VERY fond of humans… human sex slaves that is. This guy likes his slaves obedient and always ready to serve with the bare minimum willpower yet willing and capable of defending him. Friend, it so happens that the slave market is an ever evolving business, one I intend to get rich with, so you’re going to help me with that. Did you know that by ");
			outputText("violently stripping potential slaves of their life forces, pouring a decent amount of corruption and making them energy dependant, you can create efficient and willing sex zombies? You of all people shall become the fruit of my years of research into creating the perfect slave, I call this new model of sex zombie, Jiangshi. First things first though, let's make you better looking.</i>\"\n\n");
			outputText("You try to protest but before you know it the mad cat grabs what appears to be a paper tag and sticks it to your forehead. The cat chuckles.\n\n");
			outputText("\"<i>Don't you worry it will all be over soon, the suffering is momentary if there is any. All you will think about is sex and within seconds you will be too empty-headed to care about anything else.</i>\"\n\n");
			if (player.gender > 1 && player.biggestTitSize() > 0) {
				outputText("You moan, confused as your breast begins to heat up and inflate, your nipples stiffening as your boobs balloons in to ");
				if (player.biggestTitSize() < 7) {
					outputText("a pretty impressive E.");
					player.growTits((7 - player.biggestTitSize()), 1, false, 3);
				}
				else {
					player.growTits(1, 1, false, 3);
					outputText("a pretty impressive " + player.biggestTitSize() + ".");
				}
				if (player.hasCock()) outputText(" This said the transformation doesn't end there as heat begins to move down to your crotch.");
			}
			if (player.gender == 1) {
				outputText(" Your penis suddenly begins to drip pre as you immediately go erect, the blood vessels pulsing purple as if your cock was possessed while your member inflates in size, gaining " + (player.cocks[0].cockLength <= 12? "five": "two and a half")+" extra inches!");
				player.growCock(0, 5);
			}
			if (player.femininity > 50) player.femininity = 100;
			else player.femininity = 0;
			outputText(" The sexual changes are so intense you cum at once, your expression turning vacant. Your face begins to tingle as the magic alters your hormones, maxing out your "+player.mf("masculinity","femininity")+", you sure must look great right now. It'd be nice if it ended there but it doesn't, you watch in horror as your skin begins to bleach out, becoming paler by the second. You hear the last ");
			outputText("of your heartbeat a few seconds later before it falls silent. Your body stiffens to mimic this inertia, moving your joints is going to be difficult. Despite all this, your sensations don't all die out, instead you begin to hear a different kind of heartbeat, the cat’s cock looks increasingly tempting now. How do you know it has a cock? It'd be a simple guess if not for the fact ");
			outputText("that you can smell and literally see his soulforce accumulating at his crotch. You need to get off this table and get to it, you yearn for it desperately. Food… this thing is food! Your mind begins to recede into a sluggish state, all of your thoughts focusing on sex. You voice your need with a long dim witted moan, trying to reach for the cat morph’s robe with your stiff yet tied up arms.\n\n");
			outputText("\"<i>Looks like the changes are about over, Ahh...I love that vacant, stupid expression of yours, that’s the look of someone who can only think about dicks and cunts. So, since you’re already this eager, how about you have a taste of mine, Eh???</i>\"\n\n");
			outputText("He grins wide and opens up his wizard robe, revealing the hardening cock you have been focusing on all this time before he unstraps you from the table and lets you get up on your own. Without hesitation, you take his cock inside your mouth. He grumbles to himself, annoyed at your sluggish, somewhat stiff motions, but you still manage to wrap your lips around him, rocking back and forth as you suck him off.\n\n");
			outputText("\"<i>Um, I didn't consider rigor mortis in my calculation, I will need to mention this hiccup to the client… at least "+player.mf("he","she")+" makes up for it with enthusiasm.</i>\"\n\n");
			outputText("A few seconds later he finally orgasms, causing that amassed energy in his cock to flood down your throat in a white cascade. You almost faint as pleasure floods your head... You watch his reaction, waiting for an opening...You realize the fog has lifted somewhat! For whatever reason, this seems to not only restore your mind but also sharpen it. You bend your arm, and your range of motion also seems to have returned!. ");
			outputText("It would seem your torturer messed up something in the charm and instead of removing your free will, he only emptied you of it, turning you into some kind of energy vampire that gets dumber when starved. Well your face might be stuck in that zombie like expression right now but your mind is racing as you take full awareness of the situation, and how easily it would be to turn the tables on your captor.\n\n");
			outputText("Satisfied with fucking your throat, the cat morph heads to the back of the room to retrieve a big box, likely the one he intended for you to lay into until he shipped you to whatever asshole serves as his client. Poor guy thinks you're too stupid to attempt anything. He gets one hell of a surprise as you grab his left arm with until now unprecedented agility, immobilizing him and begin ");
			outputText("to drink directly from the tap of his life force through your hand. He did say something about making you capable of guarding your master too, right? Seems he loaded you with quite a few upgrades. Guess he didn't account for the risks of getting overwhelmed by his own creations as you literally drain his soulforce until he passes out. ");
			outputText("You let him fall limply on the ground and look at him, he has foam at the mouth. Geeze your nails are poisonous too? While you doubt you killed him, you don't want him to just get away with this either so you dump him in the box he originally reserved for you and lock him up.\n\n");
			outputText("Thinking your problems to be over, you attempt to remove the cursed spell tag on your forehead. You pull hard, but to your surprise it just doesn't come off. Guess you're stuck into this weird zombie like existence until you can find someone to help you with this. You literally hop out of the mage’s house, arm stretched forward, and head back to camp.\n\n");
			outputText("(<b>Gained Perks: Halted vitals, Super strength, Poison nails, Rigidity, Life leech, Undeath, Energy dependent</b>)\n\n");
			player.skinColor = randomChoice("snow white", "ghostly pale", "light blue");
			CoC.instance.transformations.FaceJiangshi.applyEffect(false);
			player.eyes.type = Eyes.JIANGSHI;
			CoC.instance.transformations.EyesChangeColor(["turquoise"]).applyEffect(false);
			player.horns.type = Horns.SPELL_TAG;
			player.horns.count = 1;
			player.arms.type = Arms.JIANGSHI;
			player.lowerBody = LowerBody.JIANGSHI;
			player.createPerk(PerkLib.HaltedVitals, 0, 0, 0, 0);
			player.createPerk(PerkLib.SuperStrength, 0, 0, 0, 0);
			player.createPerk(PerkLib.PoisonNails, 0, 0, 0, 0);
			player.createPerk(PerkLib.Rigidity, 0, 0, 0, 0);
			player.createPerk(PerkLib.LifeLeech, 0, 0, 0, 0);
			player.createPerk(PerkLib.Undeath, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.RacialParagon))
				flags[kFLAGS.APEX_SELECTED_RACE] = Races.JIANGSHI;
			player.createPerk(PerkLib.EnergyDependent, 0, 0, 0, 0);
			if (flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD]++;
			var item:ItemType;
			if (!player.weapon.isNothing) {
				item = player.unequipWeapon(false,true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = item.id;
			}
			if (!player.weaponRange.isNothing) {
				item = player.unequipWeaponRange(false,true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = item.id;
			}
			if (!player.shield.isNothing) {
				item = player.unequipShield(false,true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID] = item.id;
			}
			if (!player.armor.isNothing) {
				item = player.unequipArmor(false, true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID] = item.id;
			}
			player.setArmor(armors.TRADITC, false, true);
			if (!player.lowerGarment.isNothing) {
				item = player.unequipUnderBottom(false, true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID] = item.id;
			}
			if (!player.upperGarment.isNothing) {
				item = player.unequipUnderTop(false, true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID] = item.id;
			}
			if (!player.headJewelry.isNothing) {
				item = player.unequipHeadJewelry(false, true);
				if (item && !item.isNothing) flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = item.id;
			}
			player.setHeadJewelry(headjewelries.JIANGCT, false, true);
			if (player.hasPerk(PerkLib.BimboBody)) player.removePerk(PerkLib.BimboBody);
			if (player.hasPerk(PerkLib.BimboBrains)) player.removePerk(PerkLib.BimboBrains);
			if (player.hasPerk(PerkLib.BroBody)) player.removePerk(PerkLib.BroBody);
			if (player.hasPerk(PerkLib.BroBrains)) player.removePerk(PerkLib.BroBrains);
			if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
			if (player.hasPerk(PerkLib.FutaFaculties)) player.removePerk(PerkLib.FutaFaculties);
			player.statStore.replaceBuffObject({'str.mult':0.2,'tou.mult':0.2,'lib.mult':0.2,'sens':80}, 'Jiangshi Curse Tag', { text: 'Jiangshi Curse Tag' });
			player.updateRacialAndPerkBuffs();
			awardAchievement("Thriller", kACHIEVEMENTS.EPIC_THRILLER);
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(camp.returnToCampUseFourHours);
		}
	}
}
