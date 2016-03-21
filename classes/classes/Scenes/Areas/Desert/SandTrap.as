package classes.Scenes.Areas.Desert
{
	import classes.*;
	import classes.internals.*;

	public class SandTrap extends Monster
	{
		//Wait:
		public function sandTrapWait():void {
			clearOutput();
			game.spriteSelect(97);
			if (findStatusEffect(StatusEffects.Climbed) < 0) createStatusEffect(StatusEffects.Climbed,0,0,0,0);
			outputText("Instead of attacking, you turn away from the monster and doggedly attempt to climb back up the pit, digging all of your limbs into the soft powder as you climb against the sandslide.");
			if (trapLevel() == 4) {
				outputText("\n\nYou eye the ground above you.  The edge of the pit is too sheer, the ground too unstable... although it looks like you can fight against the currents carrying you further down, it seems impossible to gain freedom with the sand under the monster's spell.");
			}
			else {
				//Strength check success: [Player goes up one level, does not go down a level this turn]
				if (player.str/10 + rand(20) > 10) {
					outputText("\n\nSweat beads your forehead - trying to clamber out of this pit is like running against the softest treadmill imaginable.  Nonetheless, through considerable effort you see you've managed to pull further clear of the sandtrap's grasp.  \"<i>Watching you squirm around like that gets me so hot,</i>\" it calls up to you.  Turning around you see that the creature is rubbing its hands all over its lean body whilst watching you struggle.  \"<i>Such an energetic little mating dance, just for me... mmm, prey who do that are always the best!</i>\"");
					trapLevel(2);
				}
				else {
					//Strength check fail:  [Player goes down as normal]
					outputText("\n\nSweat beads your forehead - trying to clamber out of this pit is like running against the softest treadmill imaginable.  You feel like you're going to burst and you eventually give up, noting wearily that you've managed to get nowhere. \"<i>Watching you squirm around like that gets me so hot,</i>\" the sandtrap calls to you.  Turning around you see that the creature is rubbing its hands all over its lean body whilst watching you struggle.  \"<i>Such an energetic little mating dance, just for me... mmm, prey who do that are always the best!</i>\"");
					trapLevel(1);
				}
			}
			outputText("\n\n");
			doAI();
			//combatRoundOver();
		}

		public function trapLevel(adjustment:Number = 0):Number {
			if (findStatusEffect(StatusEffects.Level) < 0) createStatusEffect(StatusEffects.Level,4,0,0,0);
			if (adjustment != 0) {
				addStatusValue(StatusEffects.Level,1,adjustment);
				//Keep in bounds ya lummox
				if (statusEffectv1(StatusEffects.Level) < 1) changeStatusValue(StatusEffects.Level,1,1);
				if (statusEffectv1(StatusEffects.Level) > 4) changeStatusValue(StatusEffects.Level,1,4);
			}
			return statusEffectv1(StatusEffects.Level);
		}


		//sandtrap pheromone attack:
		private function sandTrapPheremones():void {
			game.spriteSelect(97);
			outputText("The sandtrap puckers its lips.  For one crazed moment you think it's going to blow you a kiss... but instead it spits clear fluid at you!   You desperately try to avoid it, even as your lower half is mired in sand.");
			if (player.spe/10 + rand(20) > 10 || player.getEvasionRoll(false)) {
				outputText("  Moving artfully with the flow rather than against it, you are able to avoid the trap's fluids, which splash harmlessly into the dune.");
			}
			else {
				var damage:Number = (10 + player.lib/10);
				outputText("  Despite ducking away from the jet of fluid as best you can, you cannot avoid some of the stuff splashing upon your arms and face.  The substance feels oddly warm and oily, and though you quickly try to wipe it off it sticks resolutely to your skin and the smell hits your nose.  Your heart begins to beat faster as warmth radiates out from it; you feel languid, light-headed and sensual, eager to be touched and led by the hand to a sandy bed...  Shaking your head, you try to stifle what the foreign pheromones are making you feel.");
				game.dynStats("lus", damage);
				damage = Math.round(damage * player.lustPercent() / 10) / 10;
				outputText(" <b>(<font color=\"#ff00ff\">" + damage +" lust</font>)</b>");
			}
		}

		//sandtrap quicksand attack:
		private function nestleQuikSandAttack():void {
			game.spriteSelect(97);
			outputText("The sandtrap smiles at you winningly as it thrusts its hands into the sifting granules.  The sand beneath you suddenly seems to lose even more of its density; you're sinking up to your thighs!");
			//Quicksand attack fail:
			if (player.spe/10 + rand(20) > 10  || player.getEvasionRoll(false)) {
				outputText("  Acting with alacrity, you manage to haul yourself free of the area affected by the sandtrap's spell, and set yourself anew.");
			}
			//Quicksand attack success: (Speed and Strength loss, ability to fly free lost)
			else {
				outputText("  You can't get free in time and in a panic you realize you are now practically wading in sand.  Attempting to climb free now is going to be very difficult.");
				if (player.canFly()) outputText("  You try to wrench yourself free by flapping your wings, but it is hopeless.  You are well and truly snared.");
				trapLevel(-1);
				if (findStatusEffect(StatusEffects.Climbed) < 0) createStatusEffect(StatusEffects.Climbed,0,0,0,0);
			}
		}

		override protected function performCombatAction():void
		{
			if (findStatusEffect(StatusEffects.Level) >= 0) {
				if (trapLevel() == 4 && findStatusEffect(StatusEffects.Climbed) < 0) nestleQuikSandAttack();
				else sandTrapPheremones();
//PC sinks a level (end of any turn in which player didn't successfully \"<i>Wait</i>\"):
				if (findStatusEffect(StatusEffects.Climbed) < 0) {
					outputText("\n\nRivulets of sand run past you as you continue to sink deeper into both the pit and the sand itself.");
					trapLevel(-1);
				}
				else removeStatusEffect(StatusEffects.Climbed);
				combatRoundOver();
			} else super.performCombatAction();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.desert.sandTrapScene.pcBeatsATrap();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe sand trap seems bemused by the insects your body houses...");
				doNext(game.combat.endLustLoss);
			} else {
				game.desert.sandTrapScene.sandtrapmentLoss(true);
			}
		}

		public function SandTrap()
		{
			//1/3 have fertilized eggs!
			if (rand(3) == 0) this.createStatusEffect(StatusEffects.Fertilized,0,0,0,0);
			this.a = "the ";
			if (game.silly())
				this.short = "sand tarp";
			else
				this.short = "sandtrap";
			this.imageName = "sandtrap";
			this.long = "You are fighting the sandtrap.  It sits half buried at the bottom of its huge conical pit, only its lean human anatomy on show, leering at you from beneath its shoulder length black hair with its six equally sable eyes.  You cannot say whether its long, soft face with its pointed chin is very pretty or very handsome - every time the creature's face moves, its gender seems to shift.  Its lithe, brown flat-chested body supports four arms, long fingers playing with the rivulets of powder sand surrounding it.  Beneath its belly you occasionally catch glimpses of its insect half: a massive sand-coloured abdomen which anchors it to the desert, with who knows what kind of anatomy.";
			// this.plural = false;
			this.createCock(10,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createBreastRow(0,0);
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 150;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "fair";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(55, 10, 45, 55);
			initLibSensCor(60, 45, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.armorName = "chitin";
			this.armorDef = 20;
			this.bonusHP = 100;
			this.lust = 20;
			this.lustVuln = .55;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 4;
			this.gems = 2 + rand(5);
			this.drop = new ChainedDrop(consumables.TRAPOIL).add(consumables.OVIELIX,1/3);
			this.tailType = TAIL_TYPE_DEMONIC;
			createStatusEffect(StatusEffects.Level,4,0,0,0);
			checkMonster();
		}
		
	}

}