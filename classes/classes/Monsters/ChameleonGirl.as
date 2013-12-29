package classes.Monsters 
{
	import classes.Appearance;
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ChameleonGirl extends Monster 
	{


		override protected function performCombatAction():void
		{
			mainClassPtr.chameleonAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			mainClassPtr.defeatChameleonGirl();
		}

		/**
		 * Pairs of skinTone/skinAdj
		 */
		private const SKIN_VARIATIONS:Array = [
			["red","black"],
			["green","yellowish"],
			["blue","lighter blue"],
			["purple","bright yellow"],
			["orange","brown"],
			["tan","white"]];
		public function ChameleonGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			var skinToneAdj:Array = Appearance.randomChoice(SKIN_VARIATIONS);
			init01Names("the ", "chameleon girl", "chameleongirl", "You're faced with a tall lizard-like girl with smooth " + skinToneAdj[0] + " skin and long, " + skinToneAdj[1] + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);
			init05Body(rand(2) + 68,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin(skinToneAdj[0],SKIN_TYPE_PLAIN,"skin",skinToneAdj[1]);
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(65,65,95,85,50,45,50);
			init10Weapon("claws","claw",30);
			init11Armor("skin",20);
			init12Combat(350,30,.25,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(14,10 + rand(50));
		}
		
	}

}