package classes.Scenes.Areas.Mountain
{
	import classes.CoC_Settings;
	import classes.Cock;
	import classes.Monster;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class InfestedHellhound extends HellHound
	{
		//[Extra special attack]
		private function hellHoundWormCannon():void
		{
			outputText("The thing rears up onto its hind legs, revealing its more humanoid stature, and allowing it to use its flexible paws to caress its twinned-penises.  It lurches forwards powerfully, its thickness twitching and flaring as it launches a wave of worm-filled canine cum at you.", false);
			outputText("\n", false);
			if (rand(2) == 0) {
				//Get hit – 10+ lust
				game.dynStats("lus", 5 + player.lib / 20);
				outputText("Taken off-guard by the unexpected sexual display, you fail to move out of the way, and the wormy jism splatters you from the chest down.", false);
				if (player.hasStatusAffect("infested") >= 0 && player.totalCocks() > 0) {
					outputText("  The worms inside you begin moving and squirming. A few of your cum-soaked parasites crawl out from your shivering " + multiCockDescriptLight() + " as if attempting to meet the new arrivals.  You desperately want to brush them away, but the pleasure in your crotch is too good to fight, and you find yourself staying your hand as each and every one of the new worms makes it way into your " + multiCockDescriptLight() + ".", false);
					if (player.balls > 0) outputText("  Your " + ballsDescriptLight() + " grow weightier as the worms settle into their new home, arousing you beyond measure.", false);
					else outputText("  You can feel them shifting around inside you as they adjust to their new home, arousing you beyond measure.", false);
					game.dynStats("lus", 10);
				}
				else if (player.totalCocks() > 0) {
					outputText("  The worms wriggle and squirm all over you, working their way towards your groin.  It tickles pleasantly, but you brush them away before they can get inside you.  The thought of being turned into a worm-dispensing cum fountain is horrifying, but it leaves you hard.", false);
					game.dynStats("lus", (5 + Math.round(player.cor / 20)));
				}
				else if (player.hasVagina()) outputText("  Thankfully, the worms don't seem to want anything to do with you, and rapidly drop down to the ground.", false);
			}
			//Sidestep
			else {
				outputText("You sidestep the gush of wormy fluid, letting it splatter against the rocks behind you.", false);
				//(If infested +10 lust:  
				if (player.hasStatusAffect("infested") >= 0  && player.hasCock()) {
					if (player.hasCock()) {
						outputText("  Despite avoiding the torrent of infected seed, your own wormy ", false);
						if (player.balls > 0) outputText(ballsDescriptLight(), false);
						else outputText(multiCockDescriptLight(), false);
						outputText(" wriggle", false);
						if (player.balls == 0 && player.cockTotal() == 1) outputText("s", false);
						outputText(" hotly, expelling a few of your own worms in response along with a dribble of thick pre-cum.   You wonder what it would feel like to let his worms crawl inside you…", false);
						game.dynStats("lus", 10);
					} else {
						CoC_Settings.error("Infested but no cock!");
						game.dynStats("lus", 5);
						outputText("  The idea of being covered in the beast's infested seed arouses you slightly, but you shake your head violently and clear away the unwelcome thought.", false);
					}
				}
				//if aroused by worms +5 lust:
				else if (player.hasStatusAffect("wormsOn") >= 0 && player.hasStatusAffect("wormsHalf") < 0) {
					game.dynStats("lus", 5);
					outputText("  The idea of being covered in the beast's infested seed arouses you slightly, but you shake your head violently and clear away the unwelcome thought.", false);
				}
			}
			lust -= 25;
			if (lust < 40) lust = 40;
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated, unconscious, and yet still drooling worms.", true);
				game.cleanupAfterCombat();
			} else {
				outputText("Unable to bear its unnatural arousal, the infested hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you.  Do you?", false);
					game.simpleChoices("Fuck it", game.mountain.hellHoundScene.hellHoundGetsRaped, "", 0, "", 0, "", 0, "Leave", game.cleanupAfterCombat);
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer from such a beast.", false);
					game.cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe infested hellhound's heads both grin happily as it advances towards you...", false);
				doNext(game.mountain.infestedHellhoundScene.infestedHellhoundLossRape);
			} else if (hpVictory) {
				game.mountain.infestedHellhoundScene.infestedHellhoundLossRape();
			} else {
				game.mountain.infestedHellhoundScene.infestedHellhoundLossRape();
			}
		}

		public function InfestedHellhound()
		{
			super(true);
			trace("InfestedHellhound Constructor!");
			init01Names("the ", "infested hellhound", "infestedhellhound", "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.");
			init02Male([new Cock(9, 2), new Cock(9, 2)], 2, 5, 8);
			init03BreastRows([0], [0], [0]);
			init04Ass(ANAL_LOOSENESS_NORMAL, ANAL_WETNESS_NORMAL);
			init05Body(47, HIP_RATING_AVERAGE, BUTT_RATING_AVERAGE + 1);
			init06Skin("black", SKIN_TYPE_FUR);
			init07Hair("red", 3);
			init08Face();
			init09PrimaryStats(65, 60, 50, 1, 95, 20, 100);
			init10Weapon("claws", "claw", 5);
			init11Armor("thick fur");
			init12Combat(0, 50, 0.87, Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(5, 10 + rand(10));
            init14WeightedDrop()
            					.add(consumables.CANINEP, 3)
            					.addMany(1, consumables.BULBYPP,
            							consumables.KNOTTYP,
            							consumables.BLACKPP,
            							consumables.DBLPEPP,
            							consumables.LARGEPP);
			initX_Specials(hellhoundFire, hellhoundScent, hellHoundWormCannon);
			initX_Tail(TAIL_TYPE_DOG);
		}

	}

}