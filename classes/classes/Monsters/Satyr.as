package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Satyr extends Monster 
	{
		
		public function Satyr(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("a ", "satyr", "satyr", "From the waist up, your opponent is perfectly human, save his curling, goat-like horns and his pointed, elven ears.  His muscular chest is bare and glistening with sweat, while his coarsely rugged, masculine features are contorted into an expression of savage lust.  Looking at his waist, you notice he has a bit of a potbelly, no doubt the fruits of heavy drinking, judging by the almost overwhelming smell of booze and sex that emanates from him.  Further down you see his legs are the coarse, bristly-furred legs of a bipedal goat, cloven hooves pawing the ground impatiently, sizable manhood swaying freely in the breeze.");
			init2Male(new Cock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN),	2,2 + rand(13),1.5,mainClassPtr.player.ballSize * 10);
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,20);
			init5Body(rand(37) + 64,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);

			this.temperment = 1;
			this.special1 = 5029;

			//Clothing/Armor
			this.armorName = "thick fur";
			this.weaponName = "fist";
			this.weaponVerb = "punch";

			//Primary stats
			this.str = 75;
			this.tou = 70;
			this.spe = 110;
			this.inte = 70;
			this.lib = 60;
			this.sens = 35;
			this.cor = 45;

			this.lust = 20;

			this.lustVuln = 0.30;
			//Combat Stats
			this.bonusHP = 300;
			this.HP = eMaxHP();

			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = rand(25) + 25;

			//Appearance Variables
			//randomly assign hair color
			if(rand(2) == 0) this.hairColor = "black";
			else this.hairColor = "brown";
			this.hairLength = 3+rand(20);

			this.skinTone = "tan";
			this.skinDesc = "skin";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;

			//7 - cow!
			this.tailType = TAIL_TYPE_SHARK;

		}
		
	}

}