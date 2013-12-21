package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class BeeGirl extends Monster
	{
		

		public function BeeGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("a ", "bee-girl", "beegirl", "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.");
			init2Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = 10 + rand(100);

			this.temperment = 3;
			this.special1 = 5036;

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "chitin";
			this.weaponName = "chitin-plated fist";
			this.weaponVerb = "armored punch";
			this.armorDef = 9;

			//Primary stats
			this.str = 30;
			this.tou = 30;
			this.spe = 30;
			this.inte = 20;
			this.lib = 60;
			this.sens = 55;
			this.lust = 20 + rand(40);
			this.cor = 0;

			//Combat Stats

			this.HP = eMaxHP();
			this.lustVuln = 0.9;

			//Level Stats
			this.level = 4;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(15) + 1;

			//Appearance Variables
			this.tallness = rand(14) + 59;
			//randomly assign hair color
			if(rand(2) == 0) 
				this.hairColor = "black";
			else 
				this.hairColor = "black and yellow";
			this.hairLength = 6;

			this.skinTone = "yellow";
			this.skinDesc = "skin";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;
			this.antennae = ANTENNAE_BEE;
			this.wingDesc = "insect-like wings";

			this.wingType = WING_TYPE_BEE_LIKE_SMALL;

			//7 - cow!
			this.tailType = TAIL_TYPE_BEE_ABDOMEN;

			this.tailVenom = 100;

			this.hipRating = 13;

			this.buttRating = 13;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.breastRows[0].nipplesPerBreast = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 1;
			trace("BeeGirl Constructor!");

			// possible issues accessing flags from this context.

		}

	}

}