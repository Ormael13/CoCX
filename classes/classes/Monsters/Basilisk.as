package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{
		
		public function Basilisk(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="basilisk";
			this.imageName="basilisk";

			this.long = "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  It has a thin but ropy build, its tightly muscled yellow underbelly the only part of its frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind its skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at its face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.";
			this.a ="the ";

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 10;

			this.weaponAttack = 30;

			this.armorValue = 70;
			//Primary stats
			this.str = 85;
			this.tou = 70;
			this.spe = 35;
			this.inte = 70;
			this.lib = 50;
			this.sens = 35;
			this.cor = 60;

			this.lustVuln = .5;

			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 12;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 90;
			this.hairColor = "none";
			this.hairLength = 0;

			this.skinType = SKIN_TYPE_SCALES;
			this.skinTone = "gray";
			this.skinDesc = "scales";

			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			this.hipRating = 3;

			this.buttRating = 4;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.createCock();
			this.cocks[0].cockLength = 6;
			this.cocks[0].cockThickness = 2;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",30,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}