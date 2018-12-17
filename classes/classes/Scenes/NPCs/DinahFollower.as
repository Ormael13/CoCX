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
			if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] >= 3) {
				flags[kFLAGS.DINAH_LVL_UP] = 0.5;
				outputText("You once again spy the mysterious veiled merchant in the distance. You fast turning around to walk like nothing happened least it would decide to entertain itself with you fighting when the air before you tremble for a moment and you're greet face to face well face to hood covered face with that excentric merchant.");
				outputText("\"<i>You know, I think I might have much more fun been close to you, like you know been hanging around in your camp, in case you need my goods or I need someone to fight with. What do you say?</i>\" asks the merchant.\n\n(Move mysterious veiled merchant into your camp?)");
				doYesNo(DinahMoveToCamp, DinahMoveDecline);
				return;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 0.25) {
				outputText("You spy the mysterious veiled merchant in the distance. While reconsidering if you should just turn back it notice you and already starts to making the same seal you seen before. Looks like you once again become it 'entertainent', but at least it would let you buy something nice as long you got gems for it, right?");
			}
			else {
				outputText("As you travel, you see another person on the road.  It is tethered to a small cart.  It is dressed in long cape with hood covering it body from head to feet to the point you can't be sure if it male or female.  Then it notice your presence and stops it cart.\n\n");
				outputText("\"<i>Greetings, traveler! You come at good moment since my boredom was getting too uncomfortable. IF you entertain me enough I would let you check my items. And buy IF any of them catch your attention.</i>\" Even it voice is neither male or female.\n\n");
				outputText("And when you thinking over it words it rise one of it hands to make some sort of seal in air. Almost instantly from seal jumps out something that almost instantly pounce toward you. Yes, now it's cleary what that person meant by entertaining it so you preparing your [weapon].");
				flags[kFLAGS.DINAH_LVL_UP] = 0.25;
			}
			startCombat(new Dinah());
		}
		private function DinahMoveToCamp():void {
			clearOutput();
			outputText("It smiles happily back at you, showing for the first time a tiny bit of skin, which is somewhat disturbing wide smile under it hood, and begins packing up it equipment.  It mutters over it shoulder, \"<i>That will be so much fun. I just could feel it in my tails. You can head on back and I'll see you within the hour, maybe bit sooner or later.  Oh my, yes.</i>\" ");
			outputText("It stops for a moment as if recalling something and then it pull off it hood revealing head covered with fiery black and purple hair parted by cat ears and twin pair of small horns. Looking at you with her literlay burning eyes she only utter one word, with clearly female voice now, before disapearing, \"<i>Dinah.</i>\" ");
			flags[kFLAGS.DINAH_LVL_UP] = 1;
			flags[kFLAGS.DINAH_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.DINAH_CUP_SIZE] = 1;
			flags[kFLAGS.DINAH_HIPS_ASS_SIZE] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		private function DinahMoveDecline():void {
			clearOutput();
			outputText("It wheezes out a sigh.\n\n\"<i>So much of letdown,</i>\" it mutters as it packs up it goods to travel toward the horizon.");
			doNext(camp.returnToCampUseOneHour);
		}
		public function DinahIntro2():void {
			clearOutput();//camp intro
			outputText("What will be the choice this time? (totaly WIP text) ");
			if (rand(4) > 0 && flags[kFLAGS.DINAH_AFFECTION] < 90) {
				outputText("Get Jinx'd.");
				startCombat(new Dinah());
			}
			else {
				outputText("Get Minx'd.");
				doNext(DinahMainMenu);
			}
		}
		public function DinahMainMenu():void {
			var atCamp:Boolean = (flags[kFLAGS.DINAH_LVL_UP] > 0.5);
			clearOutput();
			if (atCamp) outputText("WIP.");
			else outputText("WIP.");
			menu();
			addButton(2, "Shop", DinahShopMainMenu);
			if (atCamp) {
				addButton(0, "Appearance", DinahAppearance);
				addButton(1, "Spar", DinahSparring);
				addButtonDisabled(3, "Talk", "NYI");
				addButtonDisabled(4, "Sex", "NYI");
				addButtonDisabled(5, "Present", "NYI");//2 i 3 skopiować z MarbleScene.as i dostosować
				addButtonDisabled(6, "Give Item", "NYI");
				//addButton(6, "Give Item", canGiveItem() ? giveItem : null);
				addButton(14, "Back", camp.campFollowers);
			}
			else {
				if (flags[kFLAGS.DINAH_DEFEATS_COUNTER] >= 3) addButton(13, "Inv2Camp", DinahMoveToCamp);
				addButton(14, "Leave", camp.returnToCampUseOneHour);
			}
		}
		
		public function DinahAppearance():void {
			clearOutput();
			outputText("Dinah is seven foot and eight inches tall cat chimera of all known cat races in this realm. (WIP)");
			outputText("");//" + Appearance.breastCup(flags[kFLAGS.DINAH_CUP_SIZE]) + "
			menu();
			addButton(14, "Back", DinahMainMenu);
		}
		
		public function DinahSparring():void {
			clearOutput();
			outputText("WIP.");
			player.createStatusEffect(StatusEffects.CampSparingDinah,0,0,0,0);
			startCombat(new Dinah());
		}
		public function DinahWonSparring():void {
			clearOutput();
			outputText("WIP.");
			menu();
			addButton(14, "Back", camp.returnToCampUseOneHour);
		}
		public function DinahLostSparring():void {
			clearOutput();
			outputText("WIP.");
			menu();
			addButton(14, "Back", camp.returnToCampUseOneHour);
		}
		
		public function DinahShopMainMenu():void {
			clearOutput();
			outputText("You begin to browse veiled merchant shop inventory.");
			menu();
			addButton(0, consumables.AGILI_E.shortName, buyItem1, 0).hint("Buy an agility elixir.");
			addButton(1, consumables.W_FRUIT.shortName, buyItem1, 1).hint("Buy a piece of whisker-fruit.");
			addButton(2, consumables.WOFRUIT.shortName, buyItem2, 2).hint("Buy a Wonder fruit.");
			addButtonDisabled(3, "???", "NYI nekomata tf");
			//addButton(3, consumables..shortName, buyItem2, 3).hint("Buy .");
			addButtonDisabled(4, "???", "NYI displacer beast tf");
			//addButton(4, consumables..shortName, buyItem2, 4).hint("Buy .");
			addButton(5, consumables.MANTICV.shortName, buyItem3, 5).hint("Buy a vial of manticore venom.");
			addButton(6, consumables.VOLTTOP.shortName, buyItem3, 6).hint("Buy a Voltage topaz.");
			addButton(7, consumables.REDVIAL.shortName, buyItem3, 7).hint("Buy a vial of ominous red liquid.");
			addButton(14, "Back", DinahMainMenu);
		}
		private function buyItem1(item:Number = 0):void {
			if (item == 0) catChimeraBuy1(consumables.AGILI_E);
			if (item == 1) catChimeraBuy1(consumables.W_FRUIT);
		}
		private function buyItem2(item:Number = 0):void {
			if (item == 2) catChimeraBuy2(consumables.WOFRUIT);
			//if (item == 3) catChimeraBuy2(consumables.);
			//if (item == 4) catChimeraBuy2(consumables.);
		}
		private function buyItem3(item:Number = 0):void {
			if (item == 5) catChimeraBuy2(consumables.MANTICV);
			if (item == 6) catChimeraBuy2(consumables.VOLTTOP);
			if (item == 7) catChimeraBuy2(consumables.REDVIAL);
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
			//outputText("You bring your purchase to an icy counter and Yu check up her prices list before exchanging it for your gems.\n\n");
			//outputText("\"<i>Thanks for patronage.</i>\"\n\n");
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