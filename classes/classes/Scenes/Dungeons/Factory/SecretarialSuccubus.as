package classes.Scenes.Dungeons.Factory
{
	import classes.Monster;
	import classes.Scenes.Monsters.AbstractSuccubus;

	/**
	 * ...
	 * @author aimozg
	 */
	public class SecretarialSuccubus extends AbstractSuccubus {
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.gender > 0){
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you rape her?", true);
					game.dynStats("lus", 1);
					var temp2:int = 0;
					if (player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2266;
					game.simpleChoices("Yes", 11023, "Dildo Rape", temp2, "", 0, "", 0, "No", game.cleanupAfterCombat);
				} else if (player.lust>=33){
					outputText("You smile in satisfaction as the " + short + " gives up on fighting you and starts masturbating, begging for you to fuck her.  Now would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?", true);
					game.dynStats("lus", 1);
					temp2 = 0;
					if(player.hasKeyItem("Deluxe Dildo") >= 0) temp2 = 2266;
					game.simpleChoices("Yes",11023,"Dildo Rape",temp2,"",0,"",0,"No",game.cleanupAfterCombat);
				} else {
					game.finishCombat();
				}
			} else {
				game.finishCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				game.eventParser(11024);
			}
		}

		public function SecretarialSuccubus() {
			init01Names("the ", "secretarial succubus", "secretarialsuccubus", "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.");
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,30);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 60,HIP_RATING_CURVY,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS);
			init06Skin("blue");
			init07Hair("blond",13);
			init08Face();
			init09PrimaryStats(50,40,75,35,80,70,80);
			init10Weapon("claws","slap",10,"",150);
			init11Armor("demonic skin",4);
			init12Combat(100,30,1,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(7,rand(25)+10,50);
			init14FixedDrop(consumables.LACTAID);
			initX_Wings(WING_TYPE_BAT_LIKE_TINY,"tiny hidden");
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Specials(kissAttack,seduceAttack,whipAttack);
		}

	}

}