package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Shouldra extends Monster 
	{
		
		public function Shouldra(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="plain girl";
			this.imageName="shouldra";

			this.long = "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.";
			this.a ="the ";
			this.temperment = 1;

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "comfortable clothes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 45;
			this.tou = 30;
			this.spe = 5;
			this.inte = 110;
			this.lib = 100;
			this.sens = 0;
			this.cor = 33;

			//Combat Stats
			this.bonusHP = 30;
			this.HP = eMaxHP();
			this.lustVuln = 1;
			this.lust = 10;

			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = 0;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 65;
			this.hairColor = "white";
			this.hairLength = 3;

			this.skinTone = "white";
			this.skinDesc = "skin";

			//3 - cowface

			//7 - cow!

			this.hipRating = 6;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 4;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;

			this.ass.analLooseness = 1;
			this.ass.analWetness = 0;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.createStatusAffect("Bonus vCapacity",40,0,0,0);			
		}
		
	}

}