package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Vala extends Monster 
	{
		
		public function Vala(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init01Names("", "Vala", "vala", "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.");
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_GAPING_WIDE,25);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,10);
			init05Body("4'",HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("fair");
			init07Hair("purple",22);
			init08Face();
			init09PrimaryStats(40,50,50,60,55,35,50);
			init10Weapon("fists","caresses");
			init11Armor("skin");
			var lustVuln:Number = .5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) lustVuln += .25;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) lustVuln += .5;
			var lust:Number = 30 + mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] * 10;
			if(lust > 80) lust = 80;
			init12Combat(350,lust,lustVuln,Monster.TEMPERMENT_RANDOM_GRAPPLES,fatigue);
			init13Level(11,1);
			this.XP += 50;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.XP = 5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.XP = 1;
			initX_Specials(special1,special2,special3);


			var wingDesc:String = "shimmering wings";

			initX_Wings(WING_TYPE_BEE_LIKE_LARGE,wingDesc);


		}
		
	}

}