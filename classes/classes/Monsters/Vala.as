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
			this.short="Vala";
			this.imageName="vala";

			this.long = "While the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat.  She seems fixated on mating with you, and won't take no for an answer.";
			this.a ="";

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "fists";
			this.weaponVerb = "caresses";

			//Primary stats
			this.str = 40;
			this.tou = 50;
			this.spe = 50;
			this.inte = 60;
			this.lib = 55;
			this.sens = 35;
			this.cor = 50;

			this.lustVuln = .5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.lustVuln += .25;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.lustVuln += .5;

			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();

			this.lust = 30 + mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] * 10;
			if(this.lust > 80) this.lust = 80;

			//Level Stats
			this.level = 11;
			this.XP = totalXP() + 50;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0) this.XP = 5;
			if(mainClassPtr.flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 2) this.XP = 1;
			this.gems = 1;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 48;
			this.hairColor = "purple";
			this.hairLength = 22;

			this.skinTone = "fair";
			this.skinDesc = "skin";

			this.wingDesc = "shimmering wings";

			this.wingType = WING_TYPE_BEE_LIKE_LARGE;

			this.hipRating = 10;

			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 7;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",25,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING_WIDE;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 4;
			this.createStatusAffect("Bonus aCapacity",10,0,0,0);
			this.ass.analWetness = 0;

		}
		
	}

}