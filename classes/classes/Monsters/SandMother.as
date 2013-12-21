package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SandMother extends Monster 
	{
		
		public function SandMother(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Sand Mother";
			this.imageName="sandmother";

			this.long = "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.";
			this.a ="the ";
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
			this.armorName = "robes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";
			this.armorDef = 1;

			this.weaponValue = 150;

			//Primary stats
			this.str = 55;
			this.tou = 55;
			this.spe = 35;
			this.inte = 45;
			this.lib = 55;
			this.sens = 40;
			this.cor = 30;

			//Combat Stats
			this.bonusHP = 130;
			this.HP = eMaxHP();
			this.lustVuln = .6;
			this.lust = 20;

			//Level Stats
			this.level = 7;
			this.XP = totalXP();
			this.gems = rand(15) + 55;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness =  102;
			this.hairColor = "platinum-blonde";
			this.hairLength = 15;

			this.skinTone = "bronzed";
			this.skinDesc = "skin";

			this.wingDesc = "";

			this.hipRating = 10;

			this.buttRating = 8;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createBreastRow();
			this.breastRows[1].breastRating = 5;
			this.breastRows[1].nipplesPerBreast = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin = false;
			this.createStatusAffect("Bonus vCapacity",70,0,0,0);
			this.createStatusAffect("Bonus aCapacity",50,0,0,0);
			this.createPerk("Resolute",0,0,0,0);
			this.createPerk("Focused",0,0,0,0);
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;			
		}
		
	}

}