package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Amily extends Monster 
	{
		
		public function Amily(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Amily", "amily", "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.");

			this.temperment = 0;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "rags";
			this.weaponName = "knife";
			this.weaponVerb = "slash";
			this.armorDef = 1;

			this.weaponAttack = 6;

			//Primary stats
			this.str = 30;
			this.tou = 30;
			this.spe = 85;
			this.inte = 60;
			this.lib = 45;
			this.sens = 45;
			this.cor = 10;

			this.lustVuln = .85;

			//Combat Stats
			this.bonusHP = 20;
			this.HP = eMaxHP();

			this.lust = 20;
		
			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = 2 + rand(5);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 48;
			this.hairColor = "brown";
			this.hairLength = 5;

			this.skinType = SKIN_TYPE_FUR;
			this.skinTone = "tawny";
			this.skinDesc = "fur";

			this.hipRating = 6;

			this.buttRating = 2;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 3;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 0;
			this.createStatusAffect("Bonus vCapacity",48,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}