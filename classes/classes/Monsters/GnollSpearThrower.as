package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GnollSpearThrower extends Monster 
	{
		
		public function GnollSpearThrower(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="gnoll spear-thrower";
			this.imageName="gnollspearthrower";

			this.long = "You are fighting a gnoll.  An amalgam of voluptuous, sensual lady and snarly, pissed off hyena, she clearly intends to punish you for trespassing.  Her dark-tan, spotted hide blends into a soft cream-colored fur covering her belly and two D-cup breasts, leaving two black nipples poking through the fur.  A crude loincloth is tied around her waist, obscuring her groin from view.  A leather strap cuts between her heavy breasts, holding a basket of javelins on her back.  Large, dish-shaped ears focus on you, leaving no doubt that she can hear every move you make.  Sharp, dark eyes are locked on your body, filled with aggression and a hint of lust.";
			this.a ="the ";

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5147;
			this.special2 = 5146;
			this.special3 = 5145;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "teeth";
			this.weaponVerb = "bite";
			this.armorDef = 2;

			this.weaponValue = 25;

			//Primary stats
			this.str = 85;
			this.tou = 60;
			this.spe = 100;
			this.inte = 50;
			this.lib = 65;
			this.sens = 45;
			this.cor = 60;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();

			this.lust = 30;
		
			//Level Stats
			this.level = 10;
			this.XP = totalXP();
			this.gems = 10 + rand(5);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 72;
			this.hairColor = "black";
			this.hairLength = 22;

			this.skinTone = "tawny";
			this.skinDesc = "fur";

			this.hipRating = 6;

			this.buttRating = 2;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 3;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 4;
			this.createStatusAffect("Bonus aCapacity",25,0,0,0);
			this.ass.analWetness = 0;
		}		
	}
}