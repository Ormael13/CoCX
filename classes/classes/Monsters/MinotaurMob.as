package classes.Monsters 
{
	import classes.Appearance;
	import classes.Cock;
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MinotaurMob extends Monster 
	{
		
		public function MinotaurMob(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init01Names("the ","minotaur"+(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] < 20?" gang":" tribe"),"minotaurmob",mainClassPtr.Num2Text(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326]) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear."+(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 20?"  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon.":""),true);
			var ballSize:Number = 2 + rand(13);
			init02Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2, ballSize,1.5,ballSize * 10);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,30);
			init05Body(rand(37) + 84,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);
			init06Skin("red",SKIN_TYPE_FUR,"shaggy fur");
			init07Hair(Appearance.randomChoice("black","brown"),3);
			init08Face(FACE_COW_MINOTAUR);
			init09PrimaryStats(65,60,30,20,40,15,35);
			init10Weapon("fists","punches");
			init11Armor("thick fur");
			var bonusHP:Number = 340 + 50 * (mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3);
			var lustVuln:Number = 0.45;
			if((mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3) * 2 > 13) lustVuln = .3;
			else lustVuln -= (mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3) * 0.02;
			init12Combat(bonusHP,30,lustVuln,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			var level:int = 11 + Math.round((mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3)/2);
			if(level > 14) level = 14;
			init13Level(level,rand(15) + 45);
			initX_Tail(TAIL_TYPE_COW);
			initX_Specials(5029);

		}
	}

}