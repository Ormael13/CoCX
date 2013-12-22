package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Ember extends Monster 
	{
		
		public function Ember(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names(" ", "Ember", "ember", "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + mainClassPtr.emberMF("he", "she") + " lashes " + mainClassPtr.emberMF("his", "her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.");
			var gender:int = mainClassPtr.flags[kFLAGS.EMBER_GENDER];
			if (gender==0){
				init2Genderless("she","her","her");
			}
			if(gender >= 2) {
				init2Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			}
			if(gender == 1 || gender == 3) {
				init2Male(new Cock(16,2,CockTypesEnum.DRAGON),2,4,3);
			}
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);
			init5Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);

			this.temperment = 3;
			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 40;

			this.weaponAttack = 30;

			//Primary stats
			this.str = 75;
			this.tou = 75;
			this.spe = 75;
			this.inte = 75;
			this.lib = 50;
			this.sens = 35;
			this.cor = mainClassPtr.flags[kFLAGS.EMBER_COR];

			this.lustVuln = .25;

			//Combat Stats
			this.bonusHP = 600;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 15;
			this.XP = totalXP();
			this.gems = 0;

			//Appearance Variables
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;
			//Create imp sex attributes
		}
		
	}

}