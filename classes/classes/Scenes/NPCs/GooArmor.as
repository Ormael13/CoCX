package classes.Scenes.NPCs
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.Scenes.Areas.Lake.GooGirl;

	/**
	 * ...
	 * @author aimozg
	 */
	public class GooArmor extends GooGirl
	{

		override protected function performCombatAction():void
		{
			game.gooArmorAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hasStatusAffect("spar") >= 0) game.valeria.pcWinsValeriaSpar();
			else game.beatUpGooArmor();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe armored goo sighs while you exhaust yourself...");
				doNext(game.endLustLoss);
			} else {
				if(hasStatusAffect("spar") >= 0) game.valeria.pcWinsValeriaSparDefeat();
				else game.gooArmorBeatsUpPC();
			}
		}

		public function GooArmor()
		{
			super(false);
			init01Names("a ", "Goo Armor", "gooarmor", "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING_WIDE);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("blue",SKIN_TYPE_GOO);
			init07Hair("black",15,HAIR_GOO);
			init08Face();
			init09PrimaryStats(60,50,50,40,60,35,50);
			init10Weapon("goo sword","slash",60);
			init11Armor("armor",50);
			init12Combat(500,0,.35,Monster.TEMPERMENT_LOVE_GRAPPLES,fatigue);
			init13Level(16,rand(25)+40);
			if(flags[kFLAGS.TIMES_PC_DEFEATED_VALA] == 0) init14FixedDrop(consumables.NUMBROX);
			else init14FixedDrop();
		}
		
	}

}