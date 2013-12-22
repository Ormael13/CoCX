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
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,30);
			this.cumMultiplier = 3;
			init3BreastRows("DD");

			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;

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

			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;
		}
	}

}