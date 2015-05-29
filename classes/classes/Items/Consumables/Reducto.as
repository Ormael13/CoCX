/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.CockTypesEnum;
	import classes.PerkLib;
	import classes.Player;
	import classes.internals.Utils;

	public final class Reducto extends Consumable {
		
		public function Reducto() {
			super("Reducto", "Reducto", "a salve marked as 'Reducto'", 30, "This container full of paste can be used to shrink a body part down by a significant amount.");
		}

		override public function canUse():Boolean {
			return true;
		}
		
//		override public function hasSubMenu():Boolean { return true; } //Only GroPlus and Reducto use this.
		
		override public function useItem():Boolean {
			var rdtBalls:Function	= (game.player.balls > 0 && game.player.ballSize > 1 ? reductoBalls : null);
			var rdtBreasts:Function	= (game.player.breastRows.length > 0 && game.player.biggestTitSize() > 0 ? reductoBreasts : null);
			var rdtButt:Function	= (game.player.buttRating > 1 ? reductoButt : null);
			var rdtClit:Function	= (game.player.vaginas.length > 0 && game.player.clitLength > 0.25 ? reductoClit : null);
			var rdtCock:Function	= (game.player.cockTotal() > 0 && game.player.biggestCockArea() > 6 ? reductoCock : null);
			var rdtHips:Function	= (game.player.hipRating > 2 ? reductoHips : null);
			var rdtNipples:Function	= (game.player.nippleLength > 0.25 ? reductoNipples : null);
			var rdtHorns:Function	= (game.player.horns > 2 ? shrinkHorns : null);
			clearOutput();
			outputText("You ponder the paste in your hand and wonder what part of your body you would like to shrink.  What will you use it on?");
			game.choices("Balls", rdtBalls, "Breasts", rdtBreasts, "Butt", rdtButt, "Clit", rdtClit, "Cock", rdtCock,
				"Hips", rdtHips, "Nipples", rdtNipples, "Horns", rdtHorns, "", null, "Nevermind", reductoCancel);
			return(true);
		}
		
		private function reductoBalls():void {
			clearOutput();
			outputText("You smear the foul-smelling paste onto your " + game.player.sackDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			game.player.ballSize -= Utils.rand(4) + 2;
			if (game.player.ballSize < 1) game.player.ballSize = 1;
			outputText("You feel your scrotum shift, shrinking down along with your " + game.player.ballsDescriptLight() + ".  Within a few seconds the paste has been totally absorbed and the shrinking stops.");
			game.dynStats("lib", -2, "lus", -10);
			game.inventory.itemGoNext();
		}
		
		private function reductoBreasts():void {
			clearOutput();
			outputText("You smear the foul-smelling ointment all over your " + game.player.allBreastsDescript() + ", covering them entirely as the paste begins to get absorbed into your " + game.player.skinDesc + ".\n");
			game.player.shrinkTits(true);
			if (Utils.rand(2) == 0 && game.player.biggestTitSize() >= 1) {
				outputText("\nThe effects of the paste continue to manifest themselves, and your body begins to change again...");
				game.player.shrinkTits(true);
			}
			outputText("\nThe last of it wicks away into your skin, completing the changes.");
			game.dynStats("sen", -2, "lus", -5);
			game.inventory.itemGoNext();
		}
		
		private function reductoButt():void {
			clearOutput();
			outputText("You smear the foul-smelling paste onto your " + game.player.buttDescript() + ".  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			if (game.player.buttRating >= 15) {
				game.player.buttRating -= (3 + int(game.player.buttRating / 3));
				outputText("Within seconds you feel noticeably lighter, and a quick glance shows your ass is significantly smaller.");
			}
			else if (game.player.buttRating >= 10) {
				game.player.buttRating -= 3;
				outputText("You feel much lighter as your " + game.player.buttDescript() + " jiggles slightly, adjusting to its smaller size.");
			}
			else {
				game.player.buttRating -= Utils.rand(3) + 1;
				if (game.player.buttRating < 1) game.player.buttRating = 1;
				outputText("After a few seconds your " + game.player.buttDescript() + " has shrunk to a much smaller size!");
			}
			game.dynStats("lib", -2, "lus", -10);
			game.inventory.itemGoNext();
		}
		
		private function reductoClit():void {
			clearOutput();
			outputText("You carefully apply the paste to your " + game.player.clitDescript() + ", being very careful to avoid getting it on your " + game.player.vaginaDescript(0) + ".  It burns with heat as it begins to make its effects known...\n\n");
			game.player.clitLength /= 1.7;
			//Set clitlength down to 2 digits in length
			game.player.clitLength = int(game.player.clitLength * 100) / 100;
			outputText("Your " + game.player.clitDescript() + " shrinks rapidly, dwindling down to almost half its old size before it finishes absorbing the paste.");
			game.dynStats("sen", 2, "lus", 10);
			game.inventory.itemGoNext();
		}
		
		private function reductoCock():void {
			clearOutput();
			if (game.player.cocks[0].cockType == CockTypesEnum.BEE) {
				outputText("The gel produces an odd effect when you rub it into your " + game.player.cockDescript(0) + ".  It actually seems to calm the need that usually fills you.  In fact, as your " + game.player.cockDescript(0) + " shrinks, its skin tone changes to be more in line with yours and the bee hair that covered it falls out.  <b>You now have a human cock!</b>");
				game.player.cocks[0].cockType = CockTypesEnum.HUMAN;
			}
			else {
				outputText("You smear the repulsive smelling paste over your " + game.player.multiCockDescriptLight() + ".  It immediately begins to grow warm, almost uncomfortably so, as your " + game.player.multiCockDescriptLight() + " begins to shrink.\n\n");
				if (game.player.cocks.length == 1) {
					outputText("Your " + game.player.cockDescript(0) + " twitches as it shrinks, disappearing steadily into your " + (game.player.hasSheath() ? "sheath" : "crotch") + " until it has lost about a third of its old size.");
					game.player.cocks[0].cockLength *= 2 / 3;
					game.player.cocks[0].cockThickness *= 2 / 3;
				}
				else { //MULTI
					outputText("Your " + game.player.multiCockDescriptLight() + " twitch and shrink, each member steadily disappearing into your " + (game.player.hasSheath() ? "sheath" : "crotch") + " until they've lost about a third of their old size.");
					for (var i:int = 0; i < game.player.cocks.length; i++) {
						game.player.cocks[i].cockLength		*= 2 / 3;
						game.player.cocks[i].cockThickness	*= 2 / 3;
					}
				}
			}
			game.dynStats("sen", -2, "lus", -10);
			game.inventory.itemGoNext();
		}
		
		private function reductoHips():void {
			clearOutput();
			outputText("You smear the foul-smelling paste onto your [hips].  It feels cool at first but rapidly warms to an uncomfortable level of heat.\n\n");
			if (game.player.hipRating >= 15) {
				game.player.hipRating -= (3 + int(game.player.hipRating / 3));
				outputText("Within seconds you feel noticeably lighter, and a quick glance at your hips shows they've gotten significantly narrower.");
			}
			else if (game.player.hipRating >= 10) {
				game.player.hipRating -= 3;
				outputText("You feel much lighter as your [hips] shift slightly, adjusting to their smaller size.");
			}
			else {
				game.player.hipRating -= Utils.rand(3) + 1;
				if (game.player.hipRating < 1) game.player.hipRating = 1;
				outputText("After a few seconds your [hips] have shrunk to a much smaller size!");
			}
			game.dynStats("lib", -2, "lus", -10);
			game.inventory.itemGoNext();
		}
		
		private function reductoNipples():void {
			clearOutput();
			outputText("You rub the paste evenly over your " + game.player.nippleDescript(0) + "s, being sure to cover them completely.\n\n");
			//Shrink
			if (game.player.nippleLength / 2 < 0.25) {
				outputText("Your nipples continue to shrink down until they stop at 1/4\" long.");
				game.player.nippleLength = 0.25;
			}
			else {
				outputText("Your " + game.player.nippleDescript(0) + "s get smaller and smaller, stopping when they are roughly half their previous size.");
				game.player.nippleLength /= 2;
			}
			game.dynStats("sen", -5, "lus", -5);
			game.inventory.itemGoNext();
		}
		
		public function shrinkHorns():void {
			outputText("You doubt if the reducto is going to work but you apply the foul-smelling paste all over your horns anyways.\n\n");
			outputText("Incredibly, it works and you can feel your horns receding by an inch.")
			game.player.horns -= 1;
			game.inventory.itemGoNext();
		}
		
		private function reductoCancel():void {
			clearOutput();
			outputText("You put the salve away.\n\n");
			game.inventory.returnItemToInventory(this);
		}
	}
}
