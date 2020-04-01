/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.Items.Consumable;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Dinah;
import classes.internals.Utils;

	public class DinahFollower extends NPCAwareContent
	{
		
		public function DinahFollower() 
		{}
		
		public function dinahAffection(changes:Number = 0):Number {
			flags[kFLAGS.DINAH_AFFECTION] += changes;
			if (flags[kFLAGS.DINAH_AFFECTION] > 100) flags[kFLAGS.DINAH_AFFECTION] = 100;
			return flags[kFLAGS.DINAH_AFFECTION];
		}
		
		public function DinahIntro1():void {
			clearOutput();//non-camp intro
			//Camp offer!
			if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] >= 3 && flags[kFLAGS.DINAH_LVL_UP] < 0.5) {
				flags[kFLAGS.DINAH_LVL_UP] = 0.5;
				outputText("You, once again, spot the mysterious veiled merchant in the distance. You turn around curtly to walk like nothing happened, lest they would decide to entertain themself with you fighting again.  Then the air trembles for a moment; and you're greeted face to face, well, face to hood-covered face with that eccentric merchant.\n\n");
				outputText("\"<i>You know, I think I might have much more fun being close to you.  Like, you know, hanging around in your camp, in case you need my goods. Or if I need someone to fight with. What do you say?</i>\" asks the merchant.\n\n(Move mysterious veiled merchant into your camp?)");
				doYesNo(DinahMoveToCamp, DinahMoveDecline);
				return;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 0.25) {
				outputText("You spot the mysterious veiled merchant in the distance. While reconsidering if you should just turn back; they notice you, and start to cast the same magic seal you saw before. Looks like you, once again, become their 'entertainent', but at least they will let you buy something nice as long you have the gems for it, right?");
			}
			else {
				outputText("As you travel; you see another person on the road, they are tethered to a small cart.  The figure is dressed in long cape with a hood covering their body from head to feet. You can't be sure if they're male or female.  Then they notice your presence and stops the cart suddenly.\n\n");
				outputText("\"<i>Greetings, traveler! You come at a good moment, my boredom was getting too uncomfortable. Maybe, if you entertain me enough, I might let you browse my wares. You will be able to PURCHASE them if any of them catch your attention.</i>\" Even it voice is neither male or female.\n\n");
				outputText("When you thinking over, they mutter some words and raise one of their hands to make some sort of magical seal in the air.  Almost instantly; something from the magical seal jumps out.  Something that almost instantly pounces toward you. Yes, now it's cleary what that person meant by entertaining them, so you prepare your [weapon].");
				flags[kFLAGS.DINAH_LVL_UP] = 0.25;
				flags[kFLAGS.DINAH_CUP_SIZE] = 1;
				flags[kFLAGS.DINAH_HIPS_ASS_SIZE] = 1;
			}
			startCombat(new Dinah());
		}
		private function DinahMoveToCamp():void {
			clearOutput();
			outputText("They smile happily back at you, showing for the first time a tiny bit of skin. The wide smile is somewhat disturbing under their hood, and they begin packing up their equipment.  They mutter over their shoulder, \"<i>This will be so much fun. I could just feel the excitement in my tails. You can head on back and I'll see you within the hour, maybe a bit sooner or a bit later.  Oh my, yeah.</i>\" ");
			outputText(" They stop for a moment as if recalling something and then they pull off their hood, revealing a head covered with fiery black and purple hair parted by cat ears, and  two pairs of small horns. Looking at you, with her literally burning eyes, she only utters one word, with a clearly female voice now, before disapearing, \"<i>Dinah.</i>\"");
			outputText("\n\n(<b>Dinah has been added to the Followers menu!</b>)\n\n");
			if (flags[kFLAGS.CODEX_ENTRY_CHIMERA] <= 0) {
					flags[kFLAGS.CODEX_ENTRY_CHIMERA] = 1;
					outputText("<b>New codex entry unlocked: Chimera!</b>\n\n");
				}
			flags[kFLAGS.DINAH_LVL_UP] = 1;
			flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.DINAH_AFFECTION] = 0;
			doNext(camp.returnToCampUseOneHour);
		}
		private function DinahMoveDecline():void {
			clearOutput();
			outputText("They wheeze out an exaggerated sigh.\n\n\"<i>So much of letdown.</i>\" they mutter, as they pack up their goods to travel toward the horizon.");
			doNext(camp.returnToCampUseOneHour);
		}
		public function DinahIntro2():void {
			clearOutput();//camp intro
			outputText("\"<i>Oh, Great Lady Godiva, tell us your will!</i>\" With religious zeal, Dinah pulls a coin out of nowhere and throws it into the air. But before it can fall on the ground, it vanishes. ");
			if (rand(4) > 0 && flags[kFLAGS.DINAH_AFFECTION] < 90) {
				outputText("\"<i>The Coin Told Me To <b>Cuddle</b> You.</i>\" her smile becomes even wider. You've got a <i>very</i> bad feeling about this. It looks like there is no other choice. You've gotta to beat some sense into her before getting back to buisness.");
				startCombat(new Dinah());
			}
			else {
				outputText("\"<i>Seems the odds where in your favor this time.</i>\" she remarks with a somewhat disappointed voice.");
				doNext(DinahMainMenu);
			}
		}
		public function DinahMainMenu():void {
			var atCamp:Boolean = (flags[kFLAGS.DINAH_LVL_UP] > 0.5);
			var weather_choice:Array = ["sunny", "rainy", "snowy", "windy", "dankest", "reeking with undistilled lust"];
			clearOutput();
			if (atCamp) outputText("\"<i>What can I do for you, [name], this " + randomChoice(weather_choice) + " day?</i>\" Dinha asks you with a disturbingly wide and briliant smile on her face.");
			else outputText("\"<i>Will you gaze at me the whole day or will you buy something?</i>\" They grumble to themselves.");
			menu();
			addButton(2, "Shop", DinahShopMainMenu);
			if (atCamp) {
				addButton(0, "Appearance", DinahAppearance);
				addButton(1, "Spar", DinahSparring);
				addButtonDisabled(3, "Talk", "NYI");
				addButtonDisabled(4, "Sex", "NYI");
				addButtonDisabled(5, "Present", "NYI");//5 i 6 skopiować z MarbleScene.as i dostosować
				addButtonDisabled(6, "Give Item", "NYI");
				//addButton(6, "Give Item", canGiveItem() ? giveItem : null);
				addButton(14, "Back", camp.campFollowers);
			}
			else {
				if (flags[kFLAGS.DINAH_LVL_UP] >= 0.5) addButton(13, "Inv2Camp", DinahMoveToCamp);
				addButton(14, "Leave", camp.returnToCampUseOneHour);
			}
		}
		
		public function DinahAppearance():void {
			clearOutput();
			outputText("Dinah is a 7' 8\" tall cat chimera of seemly all cat races in this realm. Burning eyes like those of hellcats and, fiery hair with colors like those of cheshire cats, parted by twin pair of small horns. Behind her slowly moves two blazing tails, and two long tentacles similar to that of a calamari. Her four arms completes her chimeric visage.");
			outputText("");//She has " + amilyHips() + " and a " + amilyButt() + ". She has a pair of " + amilyTits() + " on her chest. They have " + flags[kFLAGS.AMILY_NIPPLE_LENGTH] + "-inch nipples at their tips and must be at least " + Appearance.breastCup(flags[kFLAGS.AMILY_CUP_SIZE]) + "s.	" + Appearance.breastCup(flags[kFLAGS.DINAH_CUP_SIZE]) + "
			menu();//very long, flowing locks of - between shouled length and ass length - hair desc
			addButton(14, "Back", DinahMainMenu);
		}
		
		public function DinahSparring():void {
			clearOutput();
			outputText("\"<i>Oh, you sensed my slowly building boredom? Not gonna say no to some entertaiment!</i>\" she makes few strenches and assumes a combat pose. \"<i>Let's <b>play</b> [name]!</i>\".");
			player.createStatusEffect(StatusEffects.CampSparingDinah,0,0,0,0);
			startCombat(new Dinah());
		}
		public function DinahWonSparring():void {
			clearOutput();
			outputText("\"<i>Point for the House Griff... Err I mean for the team of Dinah and Lady Godiva!</i>\" she giggles while doing a short victory dance.");
			cleanupAfterCombat();
		}
		public function DinahLostSparring():void {
			clearOutput();
			outputText("\"<i>Was that your will, Lady Godiva?</i>\" she mumbles under her breath.");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] >= 1) flags[kFLAGS.DINAH_DEFEATS_COUNTER]++;
				else flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DINAH_LVL_UP] == 1) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, 6);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, 6, 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 2;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DINAH_LVL_UP] == 2) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, 12);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, 12, 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 3;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 3 && flags[kFLAGS.DINAH_LVL_UP] == 3) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, 18);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, 18, 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 4;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 4 && flags[kFLAGS.DINAH_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, 24);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, 24, 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 5;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 5 && flags[kFLAGS.DINAH_LVL_UP] == 5) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, 30);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, 30, 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 6;
				}
			}
			cleanupAfterCombat();
		}
		
		public function DinahShopMainMenu():void {
			clearOutput();
			outputText("You begin to browse "+(flags[kFLAGS.DINAH_LVL_UP] > 0.5 ?"Dinah":"veiled merchant")+" shop inventory.");
			menu();
			addButton(0, consumables.AGILI_E.shortName, buyItem1, 0).hint("Buy an agility elixir.");
			addButton(1, consumables.W_FRUIT.shortName, buyItem1, 1).hint("Buy a piece of whisker-fruit.");
			addButton(2, consumables.WOFRUIT.shortName, buyItem2, 2).hint("Buy a Wonder fruit.");
			addButton(3, consumables.G_FRUIT.shortName, buyItem2, 3).hint("Buy a Ghastly Fruit");
			addButton(4, consumables.D_FRUIT.shortName, buyItem2, 4).hint("Buy a Displacement Fruit.");
			addButton(5, consumables.MANTICV.shortName, buyItem3, 5).hint("Buy a vial of manticore venom.");
			addButton(6, consumables.VOLTTOP.shortName, buyItem3, 6).hint("Buy a Voltage topaz.");
			addButton(7, consumables.REDVIAL.shortName, buyItem3, 7).hint("Buy a vial of ominous red liquid.");
			addButton(8, consumables.STRASCA.shortName, buyItem2, 8).hint("Buy a Strawberry shortcake.");
			addButton(9, consumables.BCHCAKE.shortName, buyItem2, 9).hint("Buy a Big chocolate cake.");
			if (flags[kFLAGS.PATCHOULI_AND_WONDERLAND] >= 1) addButton(10, consumables.JABBERS.shortName, buyItem3, 13).hint("Buy a Jabberwocky scale.");
			else addButtonDisabled(10, "???", "Req. to beat one of bosses in Wonderland to have access to this TF item.");
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				if (player.statusEffectv2(StatusEffects.TFDealer1) > 0) addButton(11, consumables.HYDRASC.shortName, buyItem3, 11).hint("Buy a hydra scale.");
				else addButtonDisabled(11, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv3(StatusEffects.TFDealer1) > 0) addButton(12, consumables.FSNAILS.shortName, buyItem3, 12).hint("Buy a Fire snail Saliva.");
				else addButtonDisabled(12, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv1(StatusEffects.TFDealer1) > 0) addButton(13, consumables.DSLIMEJ.shortName, buyItem3, 10).hint("Buy a Big Dark slime jelly.");
				else addButtonDisabled(13, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
			}
			addButton(14, "Back", DinahMainMenu);
		}
		private function buyItem1(item:Number = 0):void {
			if (item == 0) catChimeraBuy1(consumables.AGILI_E);
			if (item == 1) catChimeraBuy1(consumables.W_FRUIT);
		}
		private function buyItem2(item:Number = 0):void {
			if (item == 2) catChimeraBuy2(consumables.WOFRUIT);
			if (item == 3) catChimeraBuy2(consumables.G_FRUIT);
			if (item == 4) catChimeraBuy2(consumables.D_FRUIT);
			if (item == 8) catChimeraBuy2(consumables.STRASCA);
			if (item == 9) catChimeraBuy2(consumables.BCHCAKE);
		}
		private function buyItem3(item:Number = 0):void {
			if (item == 5) catChimeraBuy2(consumables.MANTICV);
			if (item == 6) catChimeraBuy2(consumables.VOLTTOP);
			if (item == 7) catChimeraBuy2(consumables.REDVIAL);
			if (item == 10) catChimeraBuy2(consumables.DSLIMEJ);
			if (item == 11) catChimeraBuy2(consumables.HYDRASC);
			if (item == 12) catChimeraBuy2(consumables.FSNAILS);
			if (item == 13) catChimeraBuy2(consumables.JABBERS);
		}
		public function catChimeraBuy1(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + itype.value + " gems.</i>\"");
			if (player.gems < itype.value) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact1,itype), DinahShopMainMenu);
		}
		public function catChimeraBuy2(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * 2) + " gems.</i>\"");
			if (player.gems < (itype.value * 2)) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact2,itype), DinahShopMainMenu);
		}
		public function catChimeraBuy3(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * 4) + " gems.</i>\"");
			if (player.gems < (itype.value * 4)) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact3,itype), DinahShopMainMenu);
		}
		public function catChimeraTransact1(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
		public function catChimeraTransact2(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * 2;
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
		public function catChimeraTransact3(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * 4;
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
	}
}