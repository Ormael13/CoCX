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
		
		private var _extra:Number = 0;
		private var _roulette1:Number = 0;
		private var _roulette2:Number = 0;
		private var _roulette3:Number = 0;
		
		public function dinahAffection(changes:Number = 0):Number {
			flags[kFLAGS.DINAH_AFFECTION] += changes;
			if (flags[kFLAGS.DINAH_AFFECTION] > 100) flags[kFLAGS.DINAH_AFFECTION] = 100;
			return flags[kFLAGS.DINAH_AFFECTION];
		}
		
		public function DinahIntro1():void {
			clearOutput();//non-camp intro
			_extra = (3 + rand(5));
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
				flags[kFLAGS.DINAH_ASS_HIPS_SIZE] = 1;
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
			_extra = (1 + rand(3));
			if (rand(2) == 0) _roulette1 = rand(4);
			if (rand(2) == 0) _roulette2 = rand(3);
			if (rand(2) == 0) _roulette3 = rand(6);
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
				if (player.hasStatusEffect(StatusEffects.DinahGift)) addButtonDisabled(5, "Gift", "She not feel like she want...");
				else addButton(5, "Gift", recieveGIFTfromDinah);
				addButton(6, "Give Item", giveDinahItem);
				addButton(14, "Back", camp.campFollowers);
			}
			else {
				if (flags[kFLAGS.DINAH_LVL_UP] >= 0.5) addButton(13, "Inv2Camp", DinahMoveToCamp);
				addButton(14, "Leave", camp.returnToCampUseOneHour);
			}
		}
		
		public function DinahAppearance():void {
			clearOutput();
			outputText("Dinah is a 7' 8\" tall cat chimera of seemly all cat races in this realm. Burning eyes, like those of hellcats and fiery hair with colors akin to those of cheshire cats, parted by twin pair of small horns. A pair of blazing tails sway slowly behind her, and two long tentacles similar to that of a calamari. Her four arms complete her chimeric visage.");
			outputText("\n\nShe has " + dinahHips() + " and a " + dinahButt() + ". She has a pair of " + dinahTits() + " on her chest. They have "+dinahNippleSize()+"-inch nipples at their tips and must be at least " + Appearance.breastCup(flags[kFLAGS.DINAH_CUP_SIZE]) + "s.");
			menu();//very long, flowing locks of - between shouled length and ass length - hair desc
			addButton(14, "Back", DinahMainMenu);
		}
		
		public function DinahSparring():void {
			clearOutput();
			outputText("\"<i>Oh, you sensed my slowly building boredom? Not gonna say no to some entertaiment!</i>\" she makes few strenches and assumes a combat pose. \"<i>Let's <b>play</b>, [name]!</i>\".");
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
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 2;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DINAH_LVL_UP] == 2) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 3;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 3 && flags[kFLAGS.DINAH_LVL_UP] == 3) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 4;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 4 && flags[kFLAGS.DINAH_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 5;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 5 && flags[kFLAGS.DINAH_LVL_UP] == 5) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 6;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 6 && flags[kFLAGS.DINAH_LVL_UP] == 6) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 6));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 6), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 7;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 7 && flags[kFLAGS.DINAH_LVL_UP] == 7) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 7));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 7), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 8;
				}
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] == 8 && flags[kFLAGS.DINAH_LVL_UP] == 8) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8));
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8), 0);
					flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.DINAH_LVL_UP] = 9;
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
			if (player.headJewelry == headjewelries.HBHELM && player.armor == armors.HBARMOR) addButton(10, "HB M&U", buyHowlingBansheeMechAndUpgrades);
			else addButtonDisabled(10, "???", "Offers only for those that are wearing HB Armor & HB Helmet.");
			if (flags[kFLAGS.DINAH_LVL_UP] > 0.5) {
				addButton(11, "Roulette", DinahShopMainMenu3).hint("You feelin' lucky champion?");
				addButton(13, "BossTF's", DinahShopMainMenu2);
			}
			else {
				addButtonDisabled(11, "Roulette", "Maybe if merchant would be more interested in you...");
				addButtonDisabled(13, "Boss D.", "Maybe if merchant would be more interested in you...");
			}
			addButton(14, "Back", DinahMainMenu);
		}
		public function DinahShopMainMenu2():void {
			clearOutput();
			outputText("You begin to browse Dinah shop inventory.");
			menu();
			if (flags[kFLAGS.PATCHOULI_AND_WONDERLAND] >= 1) addButton(0, consumables.JABBERS.shortName, buyItem4, 23).hint("Buy a Jabberwocky Scale.");
			else addButtonDisabled(0, "???", "Req. to beat one of bosses in Wonderland to have access to this TF item.");
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				if (player.statusEffectv2(StatusEffects.TFDealer1) > 0) addButton(1, consumables.HYDRASC.shortName, buyItem4, 21).hint("Buy a Hydra Scale.");
				else addButtonDisabled(1, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv3(StatusEffects.TFDealer1) > 0) addButton(2, consumables.FSNAILS.shortName, buyItem4, 22).hint("Buy a Fire Snail Saliva.");
				else addButtonDisabled(2, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv1(StatusEffects.TFDealer1) > 0) addButton(3, consumables.DSLIMEJ.shortName, buyItem4, 20).hint("Buy a Dark Slime Jelly.");
				else addButtonDisabled(3, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv1(StatusEffects.TFDealer2) > 0) addButton(4, consumables.ME_DROP.shortName, buyItem4, 24).hint("Buy a Magic Eye Drop.");
				else addButtonDisabled(3, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
				if (player.statusEffectv2(StatusEffects.TFDealer2) > 0) addButton(5, consumables.M_GOSSR.shortName, buyItem4, 25).hint("Buy a Midnight Black Glossamer.");
				else addButtonDisabled(3, "???", "Req. to beat one of bosses in Ebon Labyrinth to have access to this TF item.");
			}
			addButton(14, "Back", DinahShopMainMenu);
		}
		public function DinahShopMainMenu3():void {
			clearOutput();
			outputText("You begin to browse Dinah shop inventory.");
			menu();
			if (_roulette1 == 0) addButtonDisabled(1, "???", "Dud. Shame, shame.");
			if (_roulette1 == 1) addButton(1, "UnDefKingS", buyItem5, 40).hint("Undefeated King's Signet - Increase max wrath by 100. When worn on right hand (slot 1 and 3 for rings) would have additional effects: increase max wrath by another 100 (with base bonus it's +200), generate 6/3 wrath per turn/hour, increase multiplied on Power Attack damage by 1.");
			if (_roulette1 == 2) addButton(1, "CroUndefKing", buyItem5, 41).hint("Crown of the Undefeated King - You can't lose by HP until your health drops into the negatives any more than 5% of max HP + 500(scalable). When below 0 HP PC would gain additional 1% of max HP per turn regeneration effect.");
			if (_roulette1 == 3) addButton(1, "UnDefKingDest", buyItem5, 42).hint("Undefeated King's Destroyer - Massive mace weapon that will increase PC parry chance by 20%. Have 20% base chance for stun (3 rounds).");
			if (_roulette2 == 0) addButtonDisabled(2, "???", "Dud. Shame, shame.");
			if (_roulette2 == 1) addButton(2, "FlameLizR", buyItem5, 45).hint("Flame Lizard ring - Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.");
			if (_roulette2 == 2) addButton(2, "InferMouseR", buyItem5, 46).hint("Infernal Mouse ring - Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.");
			if (_roulette3 == 0) addButtonDisabled(3, "???", "Dud. Shame, shame.");
			if (_roulette3 == 1) addButton(3, "HBHelmet", buyItem5, 50).hint("HB helmet - Increase armor by 5 and magic resistance by 4.");
			if (_roulette3 == 2) addButton(3, "HBArmor", buyItem5, 51).hint("HB armor - Increasing it armor/resistance when power up by soulforce.");
			if (_roulette3 == 3) addButton(3, "HBShirt", buyItem5, 52).hint("HB Shirt - Increase armor by 4, magic resistance by 3, fire/ice/electric resistance by 10%.");
			if (_roulette3 == 4) addButton(3, "HBShorts", buyItem5, 53).hint("HB Shorts - Increase armor by 4, magic resistance by 3, fire/ice/electric resistance by 10%.");
			//if (_roulette4 == 0) addButtonDisabled(6, "???", "Dud. Shame, shame.");
			//if (_roulette5 == 0) addButtonDisabled(7, "???", "Dud. Shame, shame.");
			//if (_roulette6 == 0) addButtonDisabled(8, "???", "Dud. Shame, shame.");
			addButton(14, "Back", DinahShopMainMenu);
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
			if (item == 5) catChimeraBuy3(consumables.MANTICV);
			if (item == 6) catChimeraBuy3(consumables.VOLTTOP);
			if (item == 7) catChimeraBuy3(consumables.REDVIAL);
		}
		private function buyItem4(item:Number = 0):void {
			if (item == 20) catChimeraBuy4(consumables.DSLIMEJ);
			if (item == 21) catChimeraBuy4(consumables.HYDRASC);
			if (item == 22) catChimeraBuy4(consumables.FSNAILS);
			if (item == 23) catChimeraBuy4(consumables.JABBERS);
			if (item == 24) catChimeraBuy4(consumables.ME_DROP);
			if (item == 25) catChimeraBuy4(consumables.M_GOSSR);
		}
		private function buyItem5(item:Number = 0):void {
			if (item == 40) catChimeraBuy5(jewelries.UNDKINS);
			if (item == 41) catChimeraBuy5(headjewelries.CUNDKIN);
			if (item == 42) catChimeraBuy5(weapons.UDKDEST);
			if (item == 45) catChimeraBuy5(jewelries.FLLIRNG);
			if (item == 46) catChimeraBuy5(jewelries.INMORNG);
			if (item == 50) catChimeraBuy5(headjewelries.HBHELM);
			if (item == 51) catChimeraBuy5(armors.HBARMOR);
			if (item == 52) catChimeraBuy5(undergarments.HBSHIRT);
			if (item == 53) catChimeraBuy5(undergarments.HBSHORT);
			//if (item == 40) catChimeraBuy5();
			//if (item == 40) catChimeraBuy5();
			//if (item == 40) catChimeraBuy5();
		}
		public function catChimeraBuy1(itype:ItemType):void {
			clearOutput();
			outputText("You gesture at " + itype.longName + ".\n\n");
			outputText("\"<i>Oh, this one? It costs " + (itype.value * (1 + _extra)) + " gems.</i>\"");
			if (player.gems < (itype.value * (1 + _extra))) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact1,itype), DinahShopMainMenu);
		}
		public function catChimeraBuy2(itype:ItemType):void {
			clearOutput();
			outputText("You gesture at " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * (2 + _extra)) + " gems.</i>\"");
			if (player.gems < (itype.value * (2 + _extra))) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact2,itype), DinahShopMainMenu);
		}
		public function catChimeraBuy3(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * (4 + _extra)) + " gems.</i>\"");
			if (player.gems < (itype.value * (4 + _extra))) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact3,itype), DinahShopMainMenu);
		}
		public function catChimeraBuy4(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * (6 + _extra)) + " gems.</i>\"");
			if (player.gems < (itype.value * (6 + _extra))) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu2);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact4,itype), DinahShopMainMenu2);
		}
		public function catChimeraBuy5(itype:ItemType):void {
			clearOutput();
			outputText("You point out the " + itype.longName + ".\n\n");
			outputText("\"<i>Oh this one? It costs " + (itype.value * _extra) + " gems.</i>\"");
			if (player.gems < (itype.value * _extra)) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(DinahShopMainMenu3);
				return;
			}
			doYesNo(Utils.curry(catChimeraTransact5,itype), DinahShopMainMenu3);
		}
		public function catChimeraTransact1(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * (1 + _extra);
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
		public function catChimeraTransact2(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * (2 + _extra);
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
		public function catChimeraTransact3(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * (4 + _extra);
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu);
		}
		public function catChimeraTransact4(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * (6 + _extra);
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu2);
		}
		public function catChimeraTransact5(itype:ItemType):void {
			clearOutput();
			player.gems -= itype.value * _extra;
			statScreenRefresh();
			inventory.takeItem(itype, DinahShopMainMenu3);
		}
		
		public function buyHowlingBansheeMechAndUpgrades():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.BuyedHowlingBansheMech)) {
				if (player.hasKeyItem("HB Armor Plating") >= 0) {
					if (player.keyItemvX("HB Armor Plating", 1) == 1) addButton(0, "Armor Plating v2", buyHowlingBansheeMechUpgrade, "Armor Plating v2", 2500).hint("Increase armor by 25.");
					if (player.keyItemvX("HB Armor Plating", 1) == 2) addButton(0, "Armor Plating v3", buyHowlingBansheeMechUpgrade, "Armor Plating v3", 3500).hint("Increase armor by 35.");
					if (player.keyItemvX("HB Armor Plating", 1) == 3) addButton(0, "Armor Plating v3", buyHowlingBansheeMechUpgrade, "Armor Plating v4", 4500).hint("Increase armor by 45.");
					if (player.keyItemvX("HB Armor Plating", 1) == 4) addButtonDisabled(0, "Armor Plating v4", "Your HB Mech already have this upgrade.");
				}
				else addButton(0, "Armor Plating v1", buyHowlingBansheeMechUpgrade, "Armor Plating v1", 1500).hint("Increase armor by 15.");
				if (player.hasKeyItem("HB Leather Insulation") >= 0) {
					if (player.keyItemvX("HB Leather Insulation", 1) == 1) addButton(1, "Leather Insulation v2", buyHowlingBansheeMechUpgrade, "Leather Insulation v2", 2500).hint("Increase magic resistance by 25.");
					if (player.keyItemvX("HB Leather Insulation", 1) == 2) addButton(1, "Leather Insulation v3", buyHowlingBansheeMechUpgrade, "Leather Insulation v3", 3500).hint("Increase magic resistance by 35.");
					if (player.keyItemvX("HB Leather Insulation", 1) == 3) addButton(1, "Leather Insulation v4", buyHowlingBansheeMechUpgrade, "Leather Insulation v3", 4500).hint("Increase magic resistance by 45.");
					if (player.keyItemvX("HB Leather Insulation", 1) == 4) addButtonDisabled(1, "Leather Insulation v4", "Your HB Mech already have this upgrade.");
				}
				else addButton(1, "Leather Insulation v1", buyHowlingBansheeMechUpgrade, "Leather Insulation v1", 1500).hint("Increase magic resistance by 15.");
				if (player.hasKeyItem("HB Agility") >= 0) {
					if (player.keyItemvX("HB Agility", 1) == 1) addButtonDisabled(2, "Agility v2", "Your HB Mech already have this upgrade.");
					else addButton(2, "Agility v2", buyHowlingBansheeMechUpgrade, "Agility v2", 1000).hint("Adding speed scaling similar to Quick Strike perk to melee mech attacks.");
				}
				else addButton(2, "Agility v1", buyHowlingBansheeMechUpgrade, "Agility v1", 500).hint("Adding speed scaling similar to Speed Demon perk to melee mech attacks.");
				if (player.hasKeyItem("HB Rapid Reload") >= 0) {
					if (player.keyItemvX("HB Rapid Reload", 1) == 1) addButtonDisabled(3, "Rapid Reload v2", "Your HB Mech already have this upgrade.");
					else addButton(3, "Rapid Reload v2", buyHowlingBansheeMechUpgrade, "Rapid Reload v2", 1500).hint("Adding speed scaling bonus to damage (half of normal bow dmg scaling based on speed) and increase base range atk by ~25%. +1 more range shoots per turn.");
				}
				else addButton(3, "Rapid Reload v1", buyHowlingBansheeMechUpgrade, "Rapid Reload v1", 750).hint("Adding dmg scaling similar to Sharpshooter perk to range mech attacks. +1 more range shoots per turn.");
				//4 - for next button?
				if (player.hasKeyItem("HB Internal Systems") >= 0) {
					if (player.keyItemvX("HB Internal Systems", 1) == 2) addButtonDisabled(5, "Internal Systems v2", "Your HB Mech already have this upgrade.");
					else addButton(5, "Internal Systems v2", buyHowlingBansheeMechUpgrade, "Internal Systems v2", 1500).hint("Decrease mech SF reserves drain by 20 pts and max SF capacity by 5,000 (when PC wear Ayo armor).");
				}
				else addButton(5, "Internal Systems v1", buyHowlingBansheeMechUpgrade, "Internal Systems v1", 750).hint("Decrease mech SF reserves drain by 10 pts and max SF capacity by 2,000 (when PC wear Ayo armor).");
				if (player.hasKeyItem("HB Dragon's Breath Flamer") >= 0) {
					if (player.keyItemvX("Dragon's Breath Flamer", 1) == 1) addButtonDisabled(6, "DB Flamer v2", "Your HB Mech already have this upgrade.");
					else addButton(6, "DB Flamer v2", buyHowlingBansheeMechUpgrade, "Dragon's Breath Flamer v2", 3000).hint("Instal second Dragon's Breath Flamer weapon - adds second fire attack when using this special and cost of use increase twicefold.");
				}
				else addButton(6, "DB Flamer v1", buyHowlingBansheeMechUpgrade, "Dragon's Breath Flamer v1", 1500).hint("Add Dragon's Breath Flamer weapon - Allow to enter use special dealing fire damage.");
				if (player.hasKeyItem("HB Scatter Laser") >= 0) {
					if (player.keyItemvX("HB Scatter Laser", 1) == 1) addButton(7, "Scatter Laser v2", buyHowlingBansheeMechUpgrade, "Scatter Laser v2", 2500).hint("Adds 2 more units that allow either double shot at lone targets or using all three against groups.");
					if (player.keyItemvX("HB Scatter Laser", 1) == 2) addButton(7, "Scatter Laser v3", buyHowlingBansheeMechUpgrade, "Scatter Laser v3", 3500).hint("Adding 3 more units that allow either four shots at lone targets or using all six against groups.");
					if (player.keyItemvX("HB Scatter Laser", 1) == 3) addButtonDisabled(7, "Scatter Laser v3", "Your HB Mech already have this upgrade.");
				}
				else addButton(7, "Scatter Laser v1", buyHowlingBansheeMechUpgrade, "Scatter Laser v1", 1500).hint("Add Scatter Laser weapon - Allow to enter use special dealing lightning damage.");
				//8
				//9 - for prev button?
				if (player.hasKeyItem("HB Stealth System") >= 0) {
					if (player.keyItemvX("HB Stealth System", 1) >= 1) {
						if (player.keyItemvX("HB Stealth System", 1) == 1) {
							if (player.hasKeyItem("HB Internal Systems") >= 1) addButton(10, "Invisibility Mode v2", buyHowlingBansheeMechUpgrade, "Invisibility Mode v2", 10000).hint("Upgrades Invisibility Mode from v1 to v2. Decrease cost of activating and sustaining this mobe by 20%.");
							else addButtonDisabled(10, "Invisibility Mode v2", "Your need to have installed Internal Systems v2 or better to unlock this upgrade.");
						}
						if (player.keyItemvX("HB Stealth System", 1) == 2) addButtonDisabled(10, "Invisibility Mode v2", "Your HB Mech already have this upgrade.");
					}
					else {
						if (player.hasKeyItem("HB Internal Systems") >= 0) addButton(10, "Invisibility Mode v1", buyHowlingBansheeMechUpgrade, "Invisibility Mode v1", 5000).hint("Upgrades Camouflage Mode to Invisibility Mode. Allow to stay camouflaged without time limit. Sustaining this mode cost 100 SF per turn.");
						else addButtonDisabled(10, "Invisibility Mode v1", "Your need to have installed Internal Systems v1 or better to unlock this upgrade.");
					}
				}
				else addButton(10, "Camouflage Mode", buyHowlingBansheeMechUpgrade, "Camouflage Mode", 2000).hint("Enable Camouflage Mode - Allow to enter 1 turn long camouflage opening option to use Sneak Attack (melee & range) specials.");
				//11
				//12
				//13
			}
			else addButton(0, vehicles.HB_MECH.shortName, buyHowlingBansheeMech).hint("Buy HB Mech - Increase armor by 15, magic resistance by 15.");
			addButton(14, "Back", DinahShopMainMenu);
		}
		public function buyHowlingBansheeMech():void {
			clearOutput();
			outputText("You point out the Howling Banshee Mech.\n\n");
			outputText("\"<i>Oh this one? Luckly you got armor set needed to move this monster around. An it costs only " + (2000 * _extra) + " gems. It's one time deal so not expect me to find more of those.</i>\"");
			if (player.gems < (2000 * _extra)) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(buyHowlingBansheeMechAndUpgrades);
				return;
			}
			doYesNo(Utils.curry(buyHowlingBansheeMech1), buyHowlingBansheeMechAndUpgrades);
		}
		public function buyHowlingBansheeMech1():void {
			clearOutput();
			player.createStatusEffect(StatusEffects.BuyedHowlingBansheMech,0,0,0,0);
			player.gems -= 2000 * _extra;
			statScreenRefresh();
			inventory.takeItem(vehicles.HB_MECH, buyHowlingBansheeMechAndUpgrades);
		}
		public function buyHowlingBansheeMechUpgrade(upgrade:String, cost:Number):void {
			clearOutput();
			outputText("You point out " + upgrade + " upgrade options.\n\n");
			outputText("\"<i>Oh this one? It costs " + (cost * _extra) + " gems to add to the mech. And bit of time for instaling it. Do you still want to proceed?</i>\"");
			if (player.gems < (cost * _extra)) {
				outputText("\n<b>You don't have enough gems...</b>");
				doNext(buyHowlingBansheeMechAndUpgrades);
				return;
			}
			doYesNo(Utils.curry(buyHowlingBansheeMechUpgrade1,upgrade,cost), buyHowlingBansheeMechAndUpgrades);
		}
		public function buyHowlingBansheeMechUpgrade1(upgrade:String, cost:Number):void {
			clearOutput();
			outputText("Fancy Placeholder text how mini blackhole suck in mech and returns it upgraded ^^\n\n");
			player.gems -= cost * _extra;
			statScreenRefresh();
			if (upgrade == "Armor Plating v1") player.createKeyItem("HB Armor Plating",1,0,0,0);
			if (upgrade == "Armor Plating v2") player.addKeyValue("HB Armor Plating",1,1);
			if (upgrade == "Armor Plating v3") player.addKeyValue("HB Armor Plating",1,1);
			if (upgrade == "Armor Plating v4") player.addKeyValue("HB Armor Plating",1,1);
			if (upgrade == "Leather Insulation v1") player.createKeyItem("HB Leather Insulation",1,0,0,0);
			if (upgrade == "Leather Insulation v2") player.addKeyValue("HB Leather Insulation",1,1);
			if (upgrade == "Leather Insulation v3") player.addKeyValue("HB Leather Insulation",1,1);
			if (upgrade == "Leather Insulation v4") player.addKeyValue("HB Leather Insulation",1,1);
			if (upgrade == "Agility v1") player.createKeyItem("HB Agility",0,0,0,0);
			if (upgrade == "Agility v2") player.addKeyValue("HB Agility",1,1);
			if (upgrade == "Rapid Reload v1") player.createKeyItem("HB Rapid Reload",0,0,0,0);
			if (upgrade == "Rapid Reload v2") player.addKeyValue("HB Rapid Reload",1,1);
			if (upgrade == "Internal Systems v1") player.createKeyItem("HB Internal Systems",1,0,0,0);
			if (upgrade == "Internal Systems v2") player.addKeyValue("HB Internal Systems",1,1);
			if (upgrade == "Dragon's Breath Flamer v1") player.createKeyItem("HB Dragon's Breath Flamer",1,0,0,0);
			if (upgrade == "Dragon's Breath Flamer v2") player.addKeyValue("HB Dragon's Breath Flamer",1,1);
			if (upgrade == "Scatter Laser v1") player.createKeyItem("HB Scatter Laser",1,0,0,0);
			if (upgrade == "Scatter Laser v2") player.addKeyValue("HB Scatter Laser",1,1);
			if (upgrade == "Scatter Laser v3") player.addKeyValue("HB Scatter Laser",1,1);
			if (upgrade == "Camouflage Mode") player.createKeyItem("HB Stealth System",0,0,0,0);
			if (upgrade == "Invisibility Mode v1") player.addKeyValue("HB Stealth System",1,1);
			if (upgrade == "Invisibility Mode v2") player.addKeyValue("HB Stealth System",1,1);
			//if (upgrade == "") ;
			//if (upgrade == "") ;
			//if (upgrade == "") ;
			doNext(buyHowlingBansheeMechAndUpgrades);
		}
		
		public function recieveGIFTfromDinah():void {
			clearOutput();
			outputText("\"<i>Lady Godiva says that sometimes, it's good to share something without asking for money so...</i>\" as she talks, she pulls an object from the folds of her robe and tosses it to you. \"<i>...Take this. May Lady Godiva bless this place. Now, forgive me. I have other matters that occupy my time.</i>\" Not giving you chance to say anything, she shoos you away.");
			player.createStatusEffect(StatusEffects.DinahGift, (16+rand(15)), 0, 0, 0);
			/*var gift:Number = rand(20);
			if (gift == 0) inventory.takeItem(consumables.KITGIFT, DinahMainMenu);
			if (gift > 0) */inventory.takeItem(consumables.KITGIFT, DinahMainMenu);
		}
		
		public function giveDinahItem():void {
			clearOutput();
			outputText("Which item do you want to offer to Dinah?");
			menu();
			var haveGift:Boolean = false;
			var button:int = 0;
			if (player.hasItem(consumables.P_S_MLK)) {
				addButton(button++, "P.SuccMilk", giveDinahPurifiedSuccubusMilk);
				haveGift = true;
			}
			if (player.hasItem(consumables.BROWNEG) || player.hasItem(consumables.L_BRNEG)) {
				addButton(button++, "Brown Egg", giveDinahBrownEgg);
				haveGift = true;
			}
			if (player.hasItem(consumables.PURPLEG) || player.hasItem(consumables.L_PRPEG)) {
				addButton(button++, "Purple Egg", giveDinahPurpleEgg);
				haveGift = true;
			}
			if (player.hasItem(consumables.REDUCTO)) {
				addButton(button++, "Reducto", giveDinahReducto);
				haveGift = true;
			}
			addButton(14, "Back", DinahMainMenu);
		}
		public function giveDinahPurifiedSuccubusMilk():void {
			clearOutput();
			outputText("You offer Dinah a bottle of purified succubus milk and tell her that you'd like her to make her bust bigger.");
			if (flags[kFLAGS.DINAH_CUP_SIZE] < 28) {
				outputText("\n\n\"<i>Alright, if you say so.</i>\"  Dinah lifts the bottle to her mouth, and drinks the substance down.  She then drops the empty bottle, allowing it to smash on the ground, clutching her breasts and moaning ecstatically as they visibly swell, her clothes growing tighter as they do. When they finish, she squeezes them with glee. \"<i>Mmm... That feels nice. Did you want something else?</i>\"\n\n");
				dynStats("lus", 10);
				player.consumeItem(consumables.P_S_MLK);
				flags[kFLAGS.DINAH_CUP_SIZE]++;
			}
			else {
				outputText("She looks thoughtful for a moment, then shakes her head reluctantly. \"<i>I'm sorry, but I think I've got big enough breasts as it is.</i>\" She then smirks, and playfully jiggles her abundant cleavage. \"<i>Don't you agree?</i>\" she teases.\n\n");
				outputText("Swallowing hard, you have to agree, which makes Dinah laugh.");
				dynStats("lus", 5);
			}
			doNext(giveDinahItem);
		}
		private function giveDinahBrownEgg():void {
			clearOutput();
			//dinha sprite
			outputText("You hold out a brown egg, telling her that it will make her butt grow.\n\n");
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 35) {
				outputText("\"<i>So, you want me to have a little more junk in the trunk, huh?</i>\" She giggles. \"<i>Well, I guess a little padding down there wouldn't hurt...</i>\" She takes the egg from you, her teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, her hands then press themselves to her butt as she spins around so that it faces you, trying to look over her shoulder as it visibly swells, straining her pants. She pats it a few times, then shakes her head. \"<i>I'm going to have to go and let these pants out a little now.</i>\" She apologizes, and then walks away.\n\n");
				dynStats("lus", 10);
				if (player.hasItem(consumables.BROWNEG)) {
					player.consumeItem(consumables.BROWNEG);
					flags[kFLAGS.DINAH_ASS_HIPS_SIZE] += 1+rand(2);
				}
				else {
					player.consumeItem(consumables.L_BRNEG);
					flags[kFLAGS.DINAH_ASS_HIPS_SIZE] += 2+rand(3);
				}
				if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] > 35) flags[kFLAGS.DINAH_ASS_HIPS_SIZE] = 35;
			}
			else outputText("She looks at the egg, and then shakes her head. \"<i>Sorry, but I've got more than enough junk in my trunk for my taste.</i>\" Sensing she won't back down on this, you put the egg back. \"<i>So, is there anything else you wanted?</i>\" She asks.");
			doNext(giveDinahItem);
		}
		private function giveDinahPurpleEgg():void {
			clearOutput();
			//dinha sprite
			outputText("You hold out a purple egg, telling her that it will make her hips grow.\n\n");
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 20) {
				outputText("She looks at it thoughtfully. \"<i>Wider hips...? Well, if you really want, I guess I can try it.</i>\" She takes the egg from you, her teeth effortlessly biting off the top, whereupon she sucks down the contents in a practiced gulp. Crushing the shell in her hand, she almost loses her balance as her hips suddenly jut wider, the growth happening much faster than she expected. \"<i>I'm going to have to get used to walking like this, now.</i>\" She mutters, and then she awkwardly walks away.\n\n");
				dynStats("lus", 10);
				if (player.hasItem(consumables.PURPLEG)) {
					player.consumeItem(consumables.PURPLEG);
					flags[kFLAGS.DINAH_HIPS_ASS_SIZE] += 1+rand(2);
				}
				else {
					player.consumeItem(consumables.L_PRPEG);
					flags[kFLAGS.DINAH_HIPS_ASS_SIZE] += 2+rand(3);
				}
				if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] > 20) flags[kFLAGS.DINAH_HIPS_ASS_SIZE] = 20;
			}
			else outputText("She looks at you with one eyebrow quirked. \"<i>Any bigger, and I won't be able to run anymore. No thank you; I feel like enough woman already, and they aren't messing with my speed.</i>\" She turns and saunters off, as quickly as she can, but with a deliberate swaying of her hips, as if to prove both her points.");
			doNext(giveDinahItem);
		}
		private function giveDinahReducto():void {
			clearOutput();
			outputText("She wrinkles her nose at the awful smell of the paste you are showing her, even as you explain it's able to shrink down oversized bodyparts, and you can use this to reduce any parts that she thinks are oversized.");
			menu();
			if (flags[kFLAGS.DINAH_CUP_SIZE] > 1) addButton(0, "Breasts", dinahReducto, 0);
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] > 6) addButton(2, "Hips", dinahReducto, 1);
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] > 6) addButton(3, "Butt", dinahReducto, 2);
			addButton(14, "Nevermind", giveDinahItem);
		}
		private function dinahReducto(part:int):void {
			player.consumeItem(consumables.REDUCTO);
			var chosenPart:String = "";
			if (part == 0) { //Breasts
				chosenPart = "breasts";
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 6) flags[kFLAGS.DINAH_CUP_SIZE]--; //Large breasts shrink more!
				flags[kFLAGS.DINAH_CUP_SIZE]--;
				if (flags[kFLAGS.DINAH_CUP_SIZE] < 1) flags[kFLAGS.DINAH_CUP_SIZE] = 1;
			}
			else if (part == 1) { //Hips
				chosenPart = "hips";
				if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] > 12) flags[kFLAGS.DINAH_HIPS_ASS_SIZE]--; //Large hips shrink more!
				flags[kFLAGS.DINAH_HIPS_ASS_SIZE]--;
				if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 6) flags[kFLAGS.DINAH_HIPS_ASS_SIZE] = 6;
			}
			else if (part == 2) { //Butt
				chosenPart = "butt";
				if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] > 10) flags[kFLAGS.DINAH_ASS_HIPS_SIZE]--; //Large butt shrinks more!
				flags[kFLAGS.DINAH_ASS_HIPS_SIZE]--;
				if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 6) flags[kFLAGS.DINAH_ASS_HIPS_SIZE] = 6;
			}
			outputText("Grimacing at the smell - it must be awful, for her sensitive nose - she starts smearing it over the " + chosenPart + ", and you step forward to help her. As the last of it wicks away, the part begins to shrink before your eyes. \"<i>Hmm. Not bad, I guess. So, was there something else you wanted?</i>\" She asks.");
			doNext(giveDinahItem);
		}
		private function dinahTits():String {
			var temp:int = Math.random()*3;
			var descript:String = "";
			//50% of the time size-descript them
			if(rand(2) == 0) {
				if(flags[kFLAGS.DINAH_CUP_SIZE] <= 2) {
					temp = rand(3);
					if(temp == 0) descript += "small ";
					if(temp == 1) descript += "little ";
					if(temp == 2) descript += "perky ";
				}
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 2 && flags[kFLAGS.DINAH_CUP_SIZE] <= 5) descript += "ample ";
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 5 && flags[kFLAGS.DINAH_CUP_SIZE] <= 8) {
					temp = rand(4);
					if(temp == 0) descript += "big ";
					if(temp == 1) descript += "large ";
					if(temp == 2) descript += "pillowy ";
					if(temp == 3) descript += "jiggly ";
				}
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 8 && flags[kFLAGS.DINAH_CUP_SIZE] < 16) {
					temp = rand(4);
					if(temp == 0) descript += "basketball-sized ";
					if(temp == 1) descript += "whorish ";
					if(temp == 2) descript += "pornstar-like ";
					if(temp == 3) descript += "jiggling ";
				}
				if (flags[kFLAGS.DINAH_CUP_SIZE] >= 16 && flags[kFLAGS.DINAH_CUP_SIZE] < 21) descript += "beach-ball sized ";
				if (flags[kFLAGS.DINAH_CUP_SIZE] >= 21) {
					temp = rand(2);
					if(temp == 1) descript += "mountainous ";
					else descript += "immense ";
				}
			}
			//Nouns!
			temp = rand(3);
			if (temp == 0) {
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 6) descript += "love-pillows";
				else descript += "boobs";
			}
			if (temp == 1) {
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 6) descript += "tits";
				else descript += "breasts";
			}
			if (temp == 2) {
				if (flags[kFLAGS.DINAH_CUP_SIZE] > 6) descript += "rack";
				descript += "breasts";
			}
			return descript;
		}
		private function dinahNippleSize():Number {
			var dinahNS:Number = 0.3;
			if (flags[kFLAGS.DINAH_CUP_SIZE] >= 5) dinahNS += 0.2;
			if (flags[kFLAGS.DINAH_CUP_SIZE] >= 10) dinahNS += 0.3;
			if (flags[kFLAGS.DINAH_CUP_SIZE] >= 18) dinahNS += 0.3;
			if (flags[kFLAGS.DINAH_CUP_SIZE] >= 23) dinahNS += 0.4;
			if (flags[kFLAGS.DINAH_CUP_SIZE] >= 28) dinahNS += 0.5;
			return dinahNS;
		}
		private function dinahHips():String {
			var desc:String = "";
			var rando:Number = 0;
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] <= 1) {
				if (rand(2) == 0) desc = "boyish ";
				else desc = "tiny ";
				if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 6) desc = "waspish ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] > 1 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 4) {
				rando = rand(3);
				if (rando == 0) desc = "slender ";
				if (rando == 1) desc = "narrow ";
				if (rando == 2) desc = "thin ";
				if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 6) desc = "waspish ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 4 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 6) {
				rando = rand(3);
				if (rando == 0) desc = "average ";
				if (rando == 1) desc = "normal ";
				if (rando == 2) desc = "plain ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 6 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 10) {
				rando = rand(3);
				if (rando == 0) desc = "ample ";
				if (rando == 1) desc = "noticeable ";
				if (rando == 2) desc = "girly ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 10 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 15) {
				rando = rand(3);
				if (rando == 0) desc = "flared ";
				if (rando == 1) desc = "curvy ";
				if (rando == 2) desc = "wide ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 15 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] < 20) {
				rando = rand(3);
				if (rando == 0) desc = "fertile ";
				if (rando == 1) desc = "child-bearing ";
				if (rando == 2) desc = "voluptuous ";
			}
			if (flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 20) {
				rando = rand(3);
				if (rando == 0) desc = "broodmother-sized ";
				if (rando == 1) desc = "cow-like ";
				if (rando == 2) desc = "inhumanly-wide ";
			}
			rando = rand(2);
			if (rando == 0) {
				if (rand(2) == 0 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 15) desc += "flanks";
				else desc += "hips";
			}
			if (rando == 1) {
				if (rand(2) == 0 && flags[kFLAGS.DINAH_HIPS_ASS_SIZE] >= 15) desc += "flanks";
				else desc += "thighs";
			}
			return desc;
		}
		private function dinahButt():String {
			var desc:String = "";
			var rando:Number = 0;
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] <= 1) {
				if (rand(2) == 0) desc = "pixie-like ";
				else desc = "very small ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] > 1 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 4) {
				rando = rand(3);
				if (rando == 0) desc = "tight ";
				if (rando == 1) desc = "firm ";
				if (rando == 2) desc = "compact ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 4 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 6) {
				rando = rand(2);
				if (rando == 0) desc = "fair ";
				if (rando == 1) desc = "nice ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 6 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 8) {
				rando = rand(3);
				if (rando == 0) return "handful of ass";
				if (rando == 1) desc = "full ";
				if (rando == 2) desc = "shapely ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 8 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 10) {
				rando = rand(3);
				if (rando == 0) desc = "squeezable ";
				if (rando == 1) desc = "large ";
				if (rando == 2) desc = "substantial ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 10 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 13) {
				rando = rand(3);
				if (rando == 0) desc = "jiggling ";
				if (rando == 1) desc = "spacious ";
				if (rando == 2) desc = "heavy ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 13 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 16) {
				rando = rand(3);
				if (rando == 0) desc = "hand-devouring ";
				if (rando == 1) return "generous amount of ass";
				if (rando == 2) desc = "voluminous ";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 16 && flags[kFLAGS.DINAH_ASS_HIPS_SIZE] < 20) {
				rando = rand(3);
				if (rando == 0) desc = "huge ";
				if (rando == 1) desc = "vast ";
				if (rando == 2) return "jiggling expanse of ass";
			}
			if (flags[kFLAGS.DINAH_ASS_HIPS_SIZE] >= 20) {
				rando = rand(3);
				if (rando == 0) desc = "ginormous ";
				if (rando == 1) desc = "colossal ";
				if (rando == 2) desc = "tremendous ";
			}
			rando = rand(2);
			if (rando == 0) desc += "butt";
			if (rando == 1) desc += "ass";
			return desc;
		}
	}
}