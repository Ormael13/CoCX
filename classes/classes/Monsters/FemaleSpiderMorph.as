package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FemaleSpiderMorph extends Monster 
	{
		
		public function FemaleSpiderMorph(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="female spider-morph";
			this.imageName="femalespidermorph";

			this.long = "The female spider-morph is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The spider-girl is currently eyeing you with a strange expression and her fangs bared.";
			this.a ="the ";

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "exoskeleton";
			this.weaponName = "dagger";
			this.weaponVerb = "stab";
			this.armorDef = 14;

			this.weaponAttack = 15;

			this.armorValue = 50;
			//Primary stats
			this.str = 60;
			this.tou = 50;
			this.spe = 99;
			this.inte = 99;
			this.lib = 35;
			this.sens = 35;
			this.cor = 20;

			this.lustVuln = .6;

			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();

			this.lust = 20;

			//Level Stats
			this.level = 13;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 90;
			this.hairColor = "red";
			this.hairLength = 13;

			this.skinTone = "dusky";
			this.skinDesc = "skin";

			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			this.hipRating = 12;

			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 8;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",40,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 0;
			this.createStatusAffect("Bonus aCapacity",30,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}