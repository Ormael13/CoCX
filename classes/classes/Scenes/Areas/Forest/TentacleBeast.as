package classes.Scenes.Areas.Forest
{
	import classes.CoC;
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class TentacleBeast extends Monster
	{
		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n", false);
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(temp < 0) temp = 0;
			//Miss
			if(temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.", false);
			}
			//Hit
			else {
				temp = player.takeDamage(temp);
				outputText("The tentacles crash upon your body mercilessly for " + temp + " damage.", false);
			}
			combatRoundOver();
		}
		private function tentacleEntwine():void {
			outputText("The beast lunges its tentacles at you from all directions in an attempt to immobilize you.\n", false);
			//Not Trapped yet
			if(player.hasStatusAffect("TentacleBind") < 0) {
				//Success
				if(int(Math.random()*(((player.spe)/2))) > 15 || (player.hasPerk("Evade") >= 0 && int(Math.random()*(((player.spe)/2))) > 15)) {
					outputText("In an impressive display of gymnastics, you dodge, duck, dip, dive, and roll away from the shower of grab-happy arms trying to hold you. Your instincts tell you that this was a GOOD thing.\n", false);
				}
				//Fail
				else {
					outputText("While you attempt to avoid the onslaught of pseudopods, one catches you around your " + player.foot() + " and drags you to the ground. You attempt to reach for it to pull it off only to have all of the other tentacles grab you in various places and immobilize you in the air. You are trapped and helpless!!!\n\n", false);
					//Male/Herm Version:
					if(player.hasCock()) outputText("The creature, having immobilized you, coils a long tendril about your penis. You shudder as the creature begins stroking your cock like a maid at a dairy farm in an attempt to provoke a response from you. Unable to resist, your " + player.cockDescript(0) + " easily becomes erect, signaling the creature you are responsive to harsher stimulation.\n", false);
					//Female Version:
					else if(player.hasVagina()) outputText("The creature quickly positions a long tentacle with a single sucker over your clitoris. You feel the power of the suction on you, and your body quickly heats up.  Your clit engorges, prompting the beast to latch the sucker onto your " + player.clitDescript() + ".\n", false);
					//Genderless
					else outputText("The creature quickly positions a long tentacle against your " + game.assholeDescript() + ". It circles your pucker with slow, delicate strokes that bring unexpected warmth to your body.\n", false);
					game.dynStats("lus", (8+player.sens/20));
					player.createStatusAffect("TentacleBind",0,0,0,0);
				}
			}
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.", false);
			}
			if (hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				game.desert.antsScene.phyllaTentacleDefeat();
			}
			else {
				if(!hpVictory && player.gender > 0) {
					outputText("  Perhaps you could use it to sate yourself?", true);
					game.doYesNo(game.forest.tentacleBeastScene.tentacleVictoryRape,game.cleanupAfterCombat);
				} else {
					game.cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
				if (hasStatusAffect("PhyllaFight") >= 0) {
					removeStatusAffect("PhyllaFight");
					outputText("...and make it into the nearby tunnel.  ");
					game.desert.antsScene.phyllaTentaclePCLoss();
				} else
					game.forest.tentacleBeastScene.tentacleLossRape();
			} else {
				outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
				if(hasStatusAffect("PhyllaFight") >= 0) {
					removeStatusAffect("PhyllaFight");
					outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
					game.desert.antsScene.phyllaTentaclePCLoss();
				} else
					doNext(game.forest.tentacleBeastScene.tentacleLossRape);
			}
		}

		override protected function performCombatAction():void
		{
			//tentacle beasts have special AI
			if (rand(2) == 0 || hasStatusAffect("TentacleCoolDown") >= 0) game.eventParser(special1);
			else game.eventParser(special2);
		}

		public function TentacleBeast()
		{
			trace("TentacleBeast Constructor!");
			init01Names("the ", "tentacle beast", "tentaclebeast", "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.");
			init02Male([new Cock(40,1.5),new Cock(60,1.5),new Cock(50,1.5),new Cock(20,1.5)],0,0,3);
			init02Genderless();
			init03BreastRows();
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 70,HIP_RATING_BOYISH,BUTT_RATING_BUTTLESS);
			init06Skin("green",SKIN_TYPE_PLAIN,"bark");
			init07Hair("green",1);
			init08Face();
			init09PrimaryStats(58,25,45,45,90,20,100);
			init10Weapon("whip-tendril","thorny tendril",1);
			init11Armor("rubbery skin",1);
			init12Combat(350,10,0.8,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(6,rand(15)+5);
			init14FixedDrop();
			initX_Specials(tentaclePhysicalAttack,tentacleEntwine,tentaclePhysicalAttack);


			initX_Tail(TAIL_TYPE_DEMONIC);
		}

	}

}