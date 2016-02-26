package classes.Scenes.Areas.Mountain
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class WormMass extends Monster
	{
		public function wormAttack():void {
			//Dodged!
			if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80) {
				outputText("The worm colony flails at you with its simulated arms, but its lack of coordination allows you to easily dodge its attack.\n", false);
				combatRoundOver();
				return;
			}
			//Evade
			if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "' attacks.\n", false);
				combatRoundOver();
				return;
			}
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou+player.armorDef));
			if (temp <= 0) temp = 1;
			if (temp > 0) player.takeDamage(temp);
			outputText("The worm colony strikes at you with its makeshift limbs. It strikes you for ", false);
			outputText(String(temp), false);
			outputText(" damage and the limb splatters, dispersing the worms comprising the false arm.", false);	
			statScreenRefresh();
			outputText("\n", false);
			combatRoundOver();
			return;
		}
		
		public function wormsEntice():void {
			//FAIL
			if (rand(2) == 0) {
				if (player.lust < 50) outputText("The worm colony stands before you and begins secreting a significant amount of slime. You are perplexed as to why the worms have done this. You shrug your shoulders and remain on guard.\n", false);
				else outputText("The worm colony shambles over to you and attempts to grapple you. Quickly sidestepping the clumsy movements of the creature, you avoid what could have been a horrible fate as the mass falls over and splatters in its failed attempt to engulf you.\n", false);
				combatRoundOver();
				return;
			}
			//SUCCESS
			if (player.lust < 50) {
				outputText("The worm colony stands before you and begins secreting a significant amount of slime. Inexplicably, you find that your " + player.cockDescript(0) + " is already erect and is throbbing. The erection is quite meddlesome and you find yourself distracted by the unwanted arousal.\n", false);
				game.dynStats("lus", 10+player.lib/20+player.cor/20);
			}
			else {
				outputText("The worm colony shambles over to you and attempts to grapple you. Attempting to dodge, you fail to get away fast enough and fall to the ground engulfed by the mass. You are completely covered in the slimy worms!!! Incapable of avoiding any of their movements, you feel their slime coat every inch of your body and you feel the struggle and strain of each individual worm as they crawl all over you. You immediately begin flailing wildly as you cannot even breathe!", false);
				//Chance of insta-loss if infested twice
				if (player.findStatusEffect(StatusEffects.InfestAttempted) >= 0) {
					outputText("  Struggle as you might, the creatures overwhelm your body and prevent you from any conceivable opportunity to get them off you, Your head quickly becomes visible, allowing you to breathe as you stare helplessly at the cocoon of worms trapping you.\n\n", false);
					game.mountain.wormsScene.infest1();
					return;
				}
				//Escaped!
				else {
					outputText("\n\nYou struggle wildly as you fight the worm colony for both air and to get the things off you. The sticky slime secreted by the individual worms greatly increases your task. After freeing one of your arms, you uncover your face, allowing you to breathe, and begin sweeping the beasts from your body. Stunned by your renewed vigor, the mass loses its cohesion, allowing your to quickly clear the worms from your body. The disbanded colony retreats a distance from you and begins reforming itself as you purge your body of the annelids.", false);
					player.createStatusEffect(StatusEffects.InfestAttempted,0,0,0,0);
				}
			}
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			//Worms have different AI
			if (rand(2) == 0)
				special1();
			else special2();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			outputText("Overcome by your "+(hpVictory?"wounds":"lust") +", you sink to your knees as the colony of worms swarms all over your body...\n\n", true);
			game.mountain.wormsScene.infest1();
		}
		
		override public function eMaxHP():Number
		{
			return 40 + (player.newGamePlusMod() * 20);
		}

		public function WormMass()
		{
			trace("WormMass Constructor!");
			this.a = "the ";
			this.short = "worms";
			this.imageName = "worms";
			this.long = "Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.";
			this.plural = true;
			initGenderless();
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createBreastRow(0,0);
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = 1;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skinTone = "white";
			initStrTouSpeInte(35, 5, 10, 1);
			initLibSensCor(90, 60, 90);
			this.weaponName = "worm";
			this.weaponVerb="slap";
			this.armorName = "skin";
			this.lust = 30;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 3;
			this.gems = 0;
			this.special1 = wormAttack;
			this.special2 = wormsEntice;
			this.drop = NO_DROP;
			checkMonster();
		}

	}

}