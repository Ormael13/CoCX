package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * Holli (combat id 68)
	 * @author aimozg
	 */
	public class Holli68 extends Monster 
	{
		
		public function Holli68(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Holli", "holli", "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.");

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "bark";
			this.weaponName = "branches";
			this.weaponVerb = "branchy thwack";
			this.armorDef = 40;

			//Primary stats
			this.str = 150;
			this.tou = 80;
			this.spe = 80;
			this.inte = 85;
			this.lib = 75;
			this.sens = 40;
			this.cor = 80;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lustVuln = .2;
			this.lust = 20;

			//Level Stats
			this.level = 20;
			this.XP = totalXP();
			this.gems = 0;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(12) + 55;
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;

			this.skinTone = "black";
			this.skinDesc = "skin";

			this.wingDesc = "";

			this.hipRating = 10;

			this.buttRating = 8;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 7;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",20,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin = false;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.createCock();
			this.cocks[0].cockLength = 12;
			this.cocks[0].cockThickness = 2;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
		}
		
	}

}