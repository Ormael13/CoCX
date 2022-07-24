/**
 * Created by aimozg on 11.01.14.
 */
package classes.Items.Consumables
{
import classes.BaseContent;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.view.ButtonDataList;

public final class GroPlus extends Consumable {
		/**
		 * Displays a selection to call the function with a number
		 * @param fun Function to call
		 * @param from Minimum number (inclusive)
		 * @param to Maximum number (inclusive)
		 * @param back "Back" button function (optional)
		 */
		protected function pickANumber(fun:Function, from:int, to:int, back:Function = null):void {
			var bd:ButtonDataList = new ButtonDataList();
			for (var i:int = from; i <= to; ++i) bd.add(i.toString(), curry(fun, i))
			BaseContent.submenu(bd, back, 0, false);
		}

		private function pickDoses(fun:Function):void {
			var cnt:int = player.itemCount(game.consumables.GROPLUS) + 1;
			if (cnt == 0) fun(1);
			else {
				clearOutput();
				outputText("How many doses would you like to use?");
				pickANumber(fun, 1, cnt, useItem);
			}
		}
		
		public function GroPlus() {
			super("GroPlus", "GroPlus", "a needle filled with Gro+", 50, "This is a small needle with a reservoir full of blue liquid.  A faded label marks it as 'GroPlus'.  Its purpose seems obvious.");
		}

		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			EngineCore.menu();
			outputText("You ponder the needle in your hand knowing it will enlarge the injection site.  What part of your body will you use it on?");
			if (player.hasCock()) EngineCore.addButton(0, "Cock", growPlusCock);
			if (player.hasBalls()) EngineCore.addButton(1, "Balls", growPlusBalls);
			EngineCore.addButton(2, "Breasts", growPlusBreasts);
			EngineCore.addButton(3, "Nipples", growPlusNipples);
			if (player.hasCock()) EngineCore.addButton(4, "Cock", growPlusCock);
			if (player.hasVagina()) EngineCore.addButton(0, "Balls", growPlusClit);
			EngineCore.addButton(14, "Nevermind", growPlusCancel);
			return true;
		}
		
		private function growPlusBalls():void {
			clearOutput();
			game.player.slimeFeed();
			outputText("You sink the needle deep into your " + game.player.sackDescript() + ".  It hurts like hell, but you push down the plunger and the pain vanishes as the needles contents flow into you.\n\n");
			//1 in 4 BIG growth.
			if (Utils.rand(4) == 0) {
				outputText("You feel a trembling in your " + game.player.ballsDescriptLight() + " as the chemicals start to go to work.  You can tell they're going to be VERY effective.\n");
				game.player.ballSize += Utils.rand(4) + 2;
				outputText("They shift, stretching your " + game.player.sackDescript() + " tight as they gain inches of size.  You step to steady yourself as your center of balance shifts due to your newly enlarged " + game.player.ballsDescriptLight() + ".  ");
			}
			else {
				game.player.ballSize += Utils.rand(2) + 1;
				outputText("You feel your testicles shift, pulling the skin of your " + game.player.sackDescript() + " a little bit as they grow to " + game.player.ballsDescriptLight() + ".  ");
			}
			if (game.player.ballSize > 10) outputText("Walking gets even tougher with the swollen masses between your legs.  Maybe this was a bad idea.");
			game.player.dynStats("lus", 10);
			SceneLib.inventory.itemGoNext();
		}

		private function growPlusBreasts():void {
			clearOutput();
			game.player.slimeFeed();
			outputText("You sink the needle into the flesh of your " + game.player.allBreastsDescript() + " injecting each with a portion of the needle.\n\n");
			if (game.player.breastRows.length == 1)
				game.player.growTits(Utils.rand(5) + 1, 1, true, 1);
			else
				game.player.growTits(Utils.rand(2) + 1, game.player.breastRows.length, true, 2);
			game.player.dynStats("lus", 10);
			SceneLib.inventory.itemGoNext();
		}

		private function growPlusClit():void {
			clearOutput();
			game.player.slimeFeed();
			outputText("You sink the needle into your clit, nearly crying with how much it hurts.  You push down the plunger and the pain vanishes as your clit starts to grow.\n\n");
			game.player.clitLength++;
			outputText("Your " + game.player.clitDescript() + " stops growing after an inch of new flesh surges free of your netherlips.  It twitches, feeling incredibly sensitive.");
			game.player.dynStats("lus", 10);
			player.addCurse("sen", 2, 1);
			SceneLib.inventory.itemGoNext();
		}

		private function growPlusCock():void {
			if (player.cocks.length == 1) pickPlace(1);
			else {
				clearOutput();
				outputText("Which dick would you want to use Gro+ on?");
				pickANumber(pickPlace, 1, player.cocks.length, useItem);
			}
			//==========================

			function pickPlace(dick1:int):void {
				clearOutput();
				outputText("Where would you like to inject the needle?");
				EngineCore.menu();
				EngineCore.addButton(0, "Tip(+Len)", pickDoses, curry(inject, dick1-1, "tip"));
				EngineCore.addButton(1, "Side(+Thick)", pickDoses, curry(inject, dick1-1, "side"));
				EngineCore.addButton(2, "Base(+Both)", pickDoses, curry(inject, dick1-1, "base"));
				EngineCore.addButton(4, "Back", useItem);
			}

			function inject(dick:int, part:String, dose:int):void {
				var d:int = dose;
				clearOutput();
				player.slimeFeed();
				outputText("You sink the needle into the "+part+" of your [cock " + (dick+1) + "].  It hurts like hell, but as you depress the plunger, the pain vanishes, replaced by a tingling pleasure as the chemicals take effect.\n\n");

				if (part == "tip") {
					outputText("Your [cock " + (dick+1) + "] twitches, pouring more than an inch of new length from your " + (game.player.hasSheath() ? "sheath." : "crotch."));
					while (d --> 0) {
						player.increaseCock(dick, 6);
						player.cocks[dick].cockLength += 1.5;
					}
				} else if (part == "side") {
					outputText("Your [cock " + (dick+1) + "] now feels noticeably wider.");
					while (d --> 0) game.player.cocks[dick].cockThickness += 0.75;
				} else if (part == "base") {
					outputText("Your [cock " + (dick+1) + "] twitches, becoming thicker and longer at the same time");
					while (d --> 0) {
						player.increaseCock(0, 4);
						player.cocks[dick].cockLength += 1;
						player.cocks[dick].cockThickness += 0.5;
					}

				}
				game.player.dynStats("lus", 10 * dose);
				player.addCurse("sen", 2 * dose, 1);
				//eat up more gros
				if (dose > 1) player.consumeItem(game.consumables.GROPLUS, dose - 1);
				SceneLib.inventory.itemGoNext();
			}
		}

		private function growPlusNipples():void {
			clearOutput();
			game.player.slimeFeed();
			outputText("You sink the needle into each of your " + game.player.nippleDescript(0) + "s in turn, dividing the fluid evenly between them.  Though each injection hurts, the pain is quickly washed away by the potent chemical cocktail.\n\n");
		//Grow nipples
			outputText("Your nipples engorge, prodding hard against the inside of your " + game.player.armorName + ".  Abruptly you realize they've grown more than an additional quarter-inch.\n\n");
			game.player.nippleLength += (Utils.rand(2) + 3) / 10;
			game.player.dynStats("lus", 15);
			//NIPPLECUNTZZZ
			if (game.transformations.NipplesFuckable.isPossible() && Utils.rand(4) == 0) {
				game.transformations.NipplesFuckable.applyEffect();
			}
			SceneLib.inventory.itemGoNext();
		}

		private function growPlusCancel():void {
			clearOutput();
			outputText("You put the vial away.\n\n");
			SceneLib.inventory.returnItemToInventory(this);
		}
	}
}