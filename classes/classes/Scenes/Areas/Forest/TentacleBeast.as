package classes.Scenes.Areas.Forest
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kFLAGS;

	public class TentacleBeast extends Monster
	{
		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n", false);
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if (temp < 0) temp = 0;
			//Miss
			if (temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.", false);
			}
			//Hit
			else {
				outputText("The tentacles crash upon your body mercilessly. ", false);
				player.takeDamage(temp, true);
			}
			combatRoundOver();
		}
		private function tentacleEntwine():void {
			outputText("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n", false);
			//Not Trapped yet
			if (player.findStatusEffect(StatusEffects.TentacleBind) < 0) {
				//Success
				if (int(Math.random()*(((player.spe)/2))) > 15 || (player.findPerk(PerkLib.Evade) >= 0 && int(Math.random()*(((player.spe)/2))) > 15)) {
					outputText("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n", false);
				}
				//Fail
				else {
					outputText("While you attempt to avoid the onslaught of pseudopods, one catches you around your " + player.foot() + " and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n", false);
					//Male/Herm Version:
					if (player.hasCock()) outputText("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, your " + player.cockDescript(0) + " easily becomes erect, signaling to the creature that you are responsive to harsher stimulation.\n", false);
					//Female Version:
					else if (player.hasVagina()) outputText("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your " + player.clitDescript() + ".\n", false);
					//Genderless
					else outputText("The creature quickly positions a long tentacle against your " + player.assholeDescript() + ". It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n", false);
					game.dynStats("lus", (8+player.sens/20));
					player.createStatusEffect(StatusEffects.TentacleBind,0,0,0,0);
				}
			}
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
				game.awardAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.", false);
			}
			if (findStatusEffect(StatusEffects.PhyllaFight) >= 0) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				game.desert.antsScene.phyllaTentacleDefeat();
			}
			else {
				if (!hpVictory && player.gender > 0 && flags[kFLAGS.SFW_MODE] <= 0) {
					outputText("  Perhaps you could use it to sate yourself?", true);
					game.doYesNo(game.forest.tentacleBeastScene.tentacleVictoryRape,game.combat.cleanupAfterCombat);
				} else {
					game.combat.cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
				if (findStatusEffect(StatusEffects.PhyllaFight) >= 0) {
					removeStatusEffect(StatusEffects.PhyllaFight);
					outputText("...and make it into the nearby tunnel.  ");
					game.desert.antsScene.phyllaTentaclePCLoss();
				} else
					game.forest.tentacleBeastScene.tentacleLossRape();
			} else {
				outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
				if (findStatusEffect(StatusEffects.PhyllaFight) >= 0) {
					removeStatusEffect(StatusEffects.PhyllaFight);
					outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
					game.desert.antsScene.phyllaTentaclePCLoss();
				} else
					doNext(game.forest.tentacleBeastScene.tentacleLossRape);
			}
		}

		override protected function performCombatAction():void
		{
			//tentacle beasts have special AI
			if (rand(2) == 0 || findStatusEffect(StatusEffects.TentacleCoolDown) >= 0)
				special1();
			else special2();
		}

		public function TentacleBeast()
		{
			trace("TentacleBeast Constructor!");
			this.a = "the ";
			this.short = "tentacle beast";
			this.imageName = "tentaclebeast";
			this.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
			// this.plural = false;
			this.createCock(40,1.5);
			this.createCock(60,1.5);
			this.createCock(50,1.5);
			this.createCock(20,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.createBreastRow(0,0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skinTone = "green";
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinDesc = "bark";
			this.hairColor = "green";
			this.hairLength = 1;
			initStrTouSpeInte(58, 25, 35, 45);
			initLibSensCor(90, 20, 100);
			this.weaponName = "whip-tendril";
			this.weaponVerb="thorny tendril";
			this.weaponAttack = 1;
			this.armorName = "rubbery skin";
			this.armorDef = 1;
			this.bonusHP = 250;
			this.lust = 10;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 6;
			this.gems = rand(15) +5;
			this.drop = new WeightedDrop(null, 1);
			this.special1 = tentaclePhysicalAttack;
			this.special2 = tentacleEntwine;
			this.special3 = tentaclePhysicalAttack;
			this.tailType = TAIL_TYPE_DEMONIC;
			checkMonster();
		}

	}

}