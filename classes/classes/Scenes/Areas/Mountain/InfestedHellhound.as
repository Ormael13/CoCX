package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author Fake-Name
	 */


	public class InfestedHellhound extends HellHound
	{
		//[Extra special attack]
		private function hellHoundWormCannon():void
		{
			outputText("The thing rears up onto its hind legs, revealing its more humanoid stature, and allowing it to use its flexible paws to caress its twinned-penises.  It lurches forwards powerfully, its thickness twitching and flaring as it launches a wave of worm-filled canine cum at you.");
			outputText("\n");
			if (rand(2) == 0) {
				//Get hit – 10+ lust
				player.dynStats("lus", 5 + player.lib / 20);
				outputText("Taken off-guard by the unexpected sexual display, you fail to move out of the way, and the wormy jism splatters you from the chest down.");
				if (player.hasStatusEffect(StatusEffects.Infested) && player.cockTotal() > 0) {
					outputText("  The worms inside you begin moving and squirming. A few of your cum-soaked parasites crawl out from your shivering [cocks] as if attempting to meet the new arrivals.  You desperately want to brush them away, but the pleasure in your crotch is too good to fight, and you find yourself staying your hand as each and every one of the new worms makes it way into your [cocks].");
					if (player.balls > 0) outputText("  Your [balls] grow weightier as the worms settle into their new home, arousing you beyond measure.");
					else outputText("  You can feel them shifting around inside you as they adjust to their new home, arousing you beyond measure.");
					player.dynStats("lus", 10);
				}
				else if (player.cockTotal() > 0) {
					outputText("  The worms wriggle and squirm all over you, working their way towards your groin.  It tickles pleasantly, but you brush them away before they can get inside you.  The thought of being turned into a worm-dispensing cum fountain is horrifying, but it leaves you hard.");
					player.dynStats("lus", (5 + Math.round(player.cor / 20)));
				}
				else if (player.hasVagina()) outputText("  Thankfully, the worms don't seem to want anything to do with you, and rapidly drop down to the ground.");
			}
			//Sidestep
			else {
				outputText("You sidestep the gush of wormy fluid, letting it splatter against the rocks behind you.");
				//(If infested +10 lust:  
				if (player.hasStatusEffect(StatusEffects.Infested) && player.hasCock()) {
					if (player.hasCock()) {
						outputText("  Despite avoiding the torrent of infected seed, your own wormy ");
						if (player.balls > 0) outputText(ballsDescriptLight());
						else outputText(multiCockDescriptLight());
						outputText(" wriggle");
						if (player.balls == 0 && player.cockTotal() == 1) outputText("s");
						outputText(" hotly, expelling a few of your own worms in response along with a dribble of thick pre-cum.   You wonder what it would feel like to let his worms crawl inside you...");
						player.dynStats("lus", 10);
					} else {
						CoC_Settings.error("Infested but no cock!");
						player.dynStats("lus", 5);
						outputText("  The idea of being covered in the beast's infested seed arouses you slightly, but you shake your head violently and clear away the unwelcome thought.");
					}
				}
				//if aroused by worms +5 lust:
				else if (player.hasStatusEffect(StatusEffects.WormsOn) && !player.hasStatusEffect(StatusEffects.WormsHalf)) {
					player.dynStats("lus", 5);
					outputText("  The idea of being covered in the beast's infested seed arouses you slightly, but you shake your head violently and clear away the unwelcome thought.");
				}
			}
			lust -= 25;
			if (lust < 40) lust = 40;
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated, unconscious, and yet still drooling worms.", true);
				SceneLib.mountain.hellHoundScene.hellHoundPostFightOptions();
			} else {
				outputText("Unable to bear its unnatural arousal, the infested hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you.  Do you?");
					SceneLib.mountain.hellHoundScene.hellHoundPostFightSexScenes();
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer from such a beast.");
					SceneLib.mountain.hellHoundScene.hellHoundPostFightOptions();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe infested hellhound's heads both grin happily as it advances towards you...");
				doNext(SceneLib.mountain.infestedHellhoundScene.infestedHellhoundLossRape);
			} else if (hpVictory) {
				SceneLib.mountain.infestedHellhoundScene.infestedHellhoundLossRape();
			} else {
				SceneLib.mountain.infestedHellhoundScene.infestedHellhoundLossRape();
			}
		}

		public function InfestedHellhound()
		{
			super(true);
			trace("InfestedHellhound Constructor!");
			this.a = "the ";
			this.short = "infested hellhound";
			this.imageName = "infestedhellhound";
			this.long = "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.";
			// this.plural = false;
			this.createCock(9, 2);
			this.createCock(9, 2);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 8;
			this.createBreastRow();
			this.createBreastRow();
			this.createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 47;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.skin.growFur({color:"black"});
			this.hairColor = "red";
			this.hairLength = 3;
			initStrTouSpeInte(75, 64, 50, 1);
			initWisLibSensCor(1, 95, 20, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 5;
			this.armorName = "thick fur";
			this.armorDef = 7;
			this.armorMDef = 1;
			this.bonusLust = 10;
			this.lust = 50;
			this.lustVuln = 0.87;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 10;
			this.gems = 15 + rand(12);
            this.drop = new WeightedDrop().add(consumables.CANINEP, 3)
            					.addMany(1, consumables.BULBYPP,
            							consumables.KNOTTYP,
            							consumables.BLACKPP,
            							consumables.DBLPEPP,
            							consumables.LARGEPP);
			this.special1 = hellhoundFire;
			this.special2 = hellhoundScent;
			this.special3 = hellHoundWormCannon;
			this.tailType = Tail.DOG;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
