package classes.Scenes.Areas.Forest
{
	import classes.Appearance;
	import classes.CoC;
	import classes.Creature;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.internals.Utils;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class BeeGirl extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			if(player.gender > 0) {
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				} else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully, and you see an easy way to relieve it..\n\nWhat do you do to her?", true);
				}
				player.lust = 98;
				game.dynStats("lus", 1);
				var temp2:Function =null;
				var temp3:Function =null;
				if(player.hasStatusAffect("Feeder") >= 0) temp3 = game.forest.beeGirlScene.milkAndHoneyAreKindaFunny;
				if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = kGAMECLASS.beeGirlsGetsDildoed;
				game.simpleChoices("Rape",game.forest.beeGirlScene.rapeTheBeeGirl,"Dildo Rape",temp2,"",0,"B. Feed",temp3,"Leave",game.cleanupAfterCombat);
			}
			//Genderless can still breastfeed
			else if(player.hasStatusAffect("Feeder") >= 0) {
				if (hpVictory){
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				} else {
					outputText("You smile in satisfaction as the " + short + " spreads her legs and starts frigging her honey-soaked cunt.  The sweet scent oozing from between her legs is too much to bear, arousing you painfully.\n\nWhat do you do?", true);
				}
				game.simpleChoices("B. Feed", game.forest.beeGirlScene.milkAndHoneyAreKindaFunny,"",0,"",0,"",0,"Leave",game.cleanupAfterCombat);
			} else {
                game.finishCombat();
            }
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe bee-girl goes white and backs away with a disgusted look on her face.\n\n", false);
				game.cleanupAfterCombat();
			} else {
				game.forest.beeGirlScene.beeRapesYou();
			}
		}

		public function BeeGirl()
		{
			super();
			init01Names("a ", "bee-girl", "beegirl", "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL);
			init05Body(rand(14) + 59,HIP_RATING_CURVY+3,BUTT_RATING_EXPANSIVE,LOWER_BODY_TYPE_BEE);
			init06Skin("yellow");
			init07Hair(randomChoice("black","black and yellow"),6);
			init08Face();
			init09PrimaryStats(30,30,30,20,60,55,0);
			init10Weapon("chitin-plated fist","armored punch");
			init11Armor("chitin",9);
			init12Combat(0,20 + rand(40),0.9,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(4,rand(15) + 1);
			init14WeightedDrop()
					.add(consumables.BEEHONY,4)
					.add(consumables.OVIELIX,1)
					.addMany(1,consumables.W__BOOK,
							useables.B_CHITN,
							null,1);
			initX_Antennae(ANTENNAE_BEE);
			initX_Wings(WING_TYPE_BEE_LIKE_SMALL);
			initX_Tail(TAIL_TYPE_BEE_ABDOMEN,100);
			initX_Specials(5036);
		}

	}

}