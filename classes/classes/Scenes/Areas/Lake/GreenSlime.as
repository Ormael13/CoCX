package classes.Scenes.Areas.Lake
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


	public class GreenSlime extends Monster
	{


		override public function defeated(hpVictory:Boolean):void
		{
			outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.", true);
			//Boobfeed.
			if(player.hasStatusAffect("Feeder") >= 0) {
				//Eligable to rape
				if(player.lust >= 33 && player.gender > 0) {
					outputText("\n\nYou're horny enough to try and rape it, though you'd rather see how much milk you can squirt into it.  What do you do?", false);
					game.simpleChoices("B.Feed",game.lake.greenSlimeScene.rapeOozeWithMilk,"Rape",game.lake.greenSlimeScene.slimeVictoryRape,"",0,"",0,"Leave",game.cleanupAfterCombat);
				}
				//Rapes not on the table.
				else {
					outputText("\n\nYour nipples ache with the desire to forcibly breastfeed the gelatinous beast.  Do you?", false);
					game.doYesNo(game.lake.greenSlimeScene.rapeOozeWithMilk,game.cleanupAfterCombat);
				}
			}
			//Not a breastfeeder
			else if(player.lust >= 33 && player.gender > 0) {
				outputText("  Sadly you realize your own needs have not been met.  Of course, you could always play with the poor thing... Do you rape it?", false);
				game.doYesNo(game.lake.greenSlimeScene.slimeVictoryRape, game.cleanupAfterCombat);
			}
			else game.cleanupAfterCombat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe slime doesn't even seem to notice.\n\n", false);
				doNext(game.lake.greenSlimeScene.slimeLoss);
			} else {
				doNext(game.lake.greenSlimeScene.slimeLoss);
			}
		}

		public function GreenSlime()
		{
			trace("GreenSlime Constructor!");
			init01Names("a ", "green slime", "greenslime", "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.");
			init02Male(new Cock(18, 2, CockTypesEnum.HUMAN), 0, 0, 3, 20);
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED, ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 80, HIP_RATING_AMPLE, BUTT_RATING_LARGE,LOWER_BODY_TYPE_GOO);
			init06Skin("green");
			init07Hair();
			init08Face();
			init09PrimaryStats(25, 20, 10, 5, 50, 60, 20);
			init10Weapon("hands", "slap");
			init11Armor("gelatinous skin");
			init12Combat(30, 30, 1, Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(2, rand(5) + 1);
			init14ChainedDrop()
					.add(weapons.PIPE, 1 / 10)
					.add(consumables.WETCLTH, 1 / 2)
					.elseDrop(useables.GREENGL);
			initX_Specials(5040, 5039, 5039);
		}

	}

}