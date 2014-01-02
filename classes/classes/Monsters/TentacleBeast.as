package classes.Monsters
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


		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
			} else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.", false);
			}
			if (hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				game.phyllaTentacleDefeat();
			}
			else {
				if(!hpVictory && player.gender > 0) {
					outputText("  Perhaps you could use it to sate yourself?", true);
					game.doYesNo(5078,game.cleanupAfterCombat);
				}
				game.cleanupAfterCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
				if (hasStatusAffect("PhyllaFight") >= 0) {
					removeStatusAffect("PhyllaFight");
					outputText("...and make it into the nearby tunnel.  ");
					game.phyllaTentaclePCLoss();
				} else
					game.eventParser(5074);
			} else {
				outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
				if(hasStatusAffect("PhyllaFight") >= 0) {
					removeStatusAffect("PhyllaFight");
					outputText("...but an insistent voice rouses you from your stupor.  You manage to run into a nearby tunnel.  ");
					game.phyllaTentaclePCLoss();
				} else
					game.doNext(5074);
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
			initX_Specials(5072,5073,5072);


			initX_Tail(TAIL_TYPE_DEMONIC);
		}

	}

}