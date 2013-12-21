package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SecretarialSuccubus extends Monster {
		public function SecretarialSuccubus(mainClassPtr :*) {
			super(mainClassPtr);
			init1Names("the ", "secretarial succubus", "secretarialsuccubus", "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.");

			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "demonic skin";
			this.weaponName = "claws";
			this.weaponVerb = "slap";
			this.armorDef = 4;

			this.weaponAttack = 10;

			this.weaponValue = 150;

			//Primary stats
			this.str = 50;
			this.tou = 40;
			this.spe = 75;
			this.inte = 35;
			this.lib = 80;
			this.sens = 70;
			this.cor = 80;

			//Combat Stats
			this.bonusHP = 100;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 7;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+10;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(9) + 60;
			this.hairColor = "blond";
			this.hairLength = 13;

			this.skinTone = "blue";
			this.skinDesc = "skin";

			this.wingDesc = "tiny hidden";

			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 10;

			this.buttRating = 9;
			//Create succubus sex attributes
			this.createStatusAffect("Bonus vCapacity",30,0,0,0);
			this.createVagina();
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;

			this.cumMultiplier = 3;
			this.ballSize = 0;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;
		}
	}

}