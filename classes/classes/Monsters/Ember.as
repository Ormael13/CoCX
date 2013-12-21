package classes.Monsters 
{
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

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = mainClassPtr.emberMF("he","she");
			this.pronoun2 = mainClassPtr.emberMF("him","her");
			this.pronoun3 = mainClassPtr.emberMF("his","her");

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
			//Gender 1M, 2F, 3H
			this.gender = mainClassPtr.flags[kFLAGS.EMBER_GENDER];
			this.tallness = rand(8) + 70;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create imp sex attributes
			if(mainClassPtr.flags[kFLAGS.EMBER_GENDER] >= 2) {
				this.createVagina();
				this.vaginas[0].virgin = false;
				this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
				this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			}
			if(mainClassPtr.flags[kFLAGS.EMBER_GENDER] == 1 || mainClassPtr.flags[kFLAGS.EMBER_GENDER] == 3) {
				this.balls = 2;
				this.createCock();
				this.cocks[0].cockLength = 16;
				this.cocks[0].cockThickness = 2;
				this.cocks[0].cockType = CockTypesEnum.DRAGON;
				this.ballSize = 4;
			}
			this.cumMultiplier = 3;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 0;			
		}
		
	}

}