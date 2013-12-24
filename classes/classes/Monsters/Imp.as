package classes.Monsters
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Imp extends Monster
	{
		

		public function Imp(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Imp Constructor!");
			init01Names("the ","imp","imp","An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.");
			init02Male([new Cock(rand(2) + 11,2.5,CockTypesEnum.DEMON)],2,1);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL);
			init05Body(rand(24) + 25,HIP_RATING_BOYISH,BUTT_RATING_TIGHT);
			init06Skin("red");
			init07Hair("black",5);
			init09PrimaryStats(20,10,25,12,45,45,100);
			init08Face();
			init10Weapon("claws","claw-slash");
			init11Armor("leathery skin");
			init12Combat(0,40,1,1);
			init13Level(1,rand(5) + 5);
			initX_Specials(5019);
			initX_Wings(WING_TYPE_IMP);

		}

	}

}