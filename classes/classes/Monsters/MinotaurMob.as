package classes.Monsters 
{
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
			init1Names("the ","minotaur"+(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] < 20?" gang":" tribe"),"minotaurmob",mainClassPtr.Num2Text(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326]) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear."+(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 20?"  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon.":""),true);
			init2Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2,2 + rand(13),1.5,mainClassPtr.player.ballSize * 10);
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,30);
			init5Body(rand(37) + 84,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);

			this.temperment = 1;
			this.special1 = 5029;

			//Clothing/Armor
			this.armorName = "thick fur";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 65;
			this.tou = 60;
			this.spe = 30;
			this.inte = 20;
			this.lib = 40;
			this.sens = 15;
			this.cor = 35;

			//Combat Stats
			this.bonusHP = 340 + 50 * (mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3);
			this.HP = eMaxHP();
			this.lustVuln = 0.45;
			if((mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3) * 2 > 13) this.lustVuln = .3;
			else this.lustVuln -= (mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3) * 0.02;
			this.lust = 30;

			//Level Stats
			this.level = 11 + Math.round((mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] - 3)/2);
			if(this.level > 14) this.level = 14;
			this.XP = totalXP();
			this.gems = rand(15) + 45;

			//Appearance Variables
			//randomly assign hair color
			if(rand(2) == 0) this.hairColor = "black";
			else this.hairColor = "brown";
			this.hairLength = 3;

			this.skinType = SKIN_TYPE_FUR;
			this.skinTone = "red";
			this.skinDesc = "shaggy fur";

			this.faceType = FACE_COW_MINOTAUR;

			this.tailType = TAIL_TYPE_SHARK;

		}
	}

}