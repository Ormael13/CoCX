package classes.Monsters
{
	import classes.CoC;
	import classes.Monster;

	/**
	 * ...
	 * @author aimozg
	 */
	public class TamanisDaughters extends Monster
	{

		override protected function performCombatAction():void
		{
			//Tamani's Daughters have special AI in tamanisDaughters.as
			game.tamanisDaughtersAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.combatWinAgainstDaughters();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes seem visibly disgusted and leave, telling you to, \"<i>quit being so fucking gross...</i>\"");
				game.cleanupAfterCombat();
			} else {
				game.loseToDaughters();
			}
		}

		public function TamanisDaughters(game:CoC)
		{
			super(game);
			init01Names("the group of ","Tamani's daughters","tamanisdaughters","A large grouping of goblin girls has gathered around you, surrounding you on all sides.  Most have varying shades of green skin, though a few have yellowish or light blue casts to their skin.  All are barely clothed, exposing as much of their flesh as possible in order to excite a potential mate.  Their hairstyles are as varied as their clothing and skin-tones, and the only things they seem to have in common are cute faces and curvy forms.  It looks like they want something from you.",true);
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_TIGHT,40);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,25);
			init05Body(40,HIP_RATING_AMPLE+1,BUTT_RATING_NOTICEABLE+1);
			init06Skin("greenish gray");
			init07Hair("pink",16);
			init08Face();
			init09PrimaryStats(55,30,45,50,70,70,50);
			init10Weapon("fists","tiny punch");
			init11Armor("leather straps");
			var bonusHP:Number = 50 + (int(player.statusAffectv2("Tamani")/2)*15);
			init12Combat(bonusHP,30,.65,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			var level:int = 8 + (Math.floor(player.statusAffectv2("Tamani")/2/10));
			init13Level(level,rand(15) + 5);


		}

	}

}