package classes.Monsters 
{
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
			this.short="minotaur";
			this.imageName="minotaurmob";
			if(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] < 20) this.short += " gang";
			else this.short += " tribe";
			this.plural = true;
			this.long = mainClassPtr.Num2Text(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326]) + " shaggy beastmen stand around you in a loose circle.  Their postures aren't exactly threatening.  If anything, they seem to be standing protectively around you, as if their presence would somehow shelter you from the rest of the mountain.  All of their features share a brotherly similarity, though there's still a fair bit of differences between your minotaur sons.  One of them is a head above the rest, a massive hulk of muscle so big he seems to dwarf the rest.  In stark contrast, a feminine minitaur keeps his distance in the rear.";
			if(mainClassPtr.flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 20) this.long += "  The tribe constantly makes hoots and cat-calls, fully expecting to be fucking you soon.";
			this.a ="the ";

			this.temperment = 1;
			this.special1 = 5029;

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

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
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = rand(37) + 84;
			//randomly assign hair color
			if(rand(2) == 0) this.hairColor = "black";
			else this.hairColor = "brown";
			this.hairLength = 3;

			this.skinType = SKIN_TYPE_FUR;
			this.skinTone = "red";
			this.skinDesc = "shaggy fur";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;

			this.lowerBody = LOWER_BODY_TYPE_HOOFED;

			//7 - cow!
			this.tailType = TAIL_TYPE_SHARK;

			this.hipRating = 4;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createCock();
			this.cocks[0].cockLength = rand(13) + 24;
			this.cocks[0].cockThickness = 2 + rand(3);
			this.cocks[0].cockType = CockTypesEnum.HORSE;
			this.balls = 2;
			this.cumMultiplier = 1.5;
			this.ballSize = 2 + rand(13);
			this.hoursSinceCum = mainClassPtr.player.ballSize * 10;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 1;
			this.createStatusAffect("Bonus aCapacity",30,0,0,0);			
		}		
	}

}