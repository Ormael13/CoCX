package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class CumWitch extends Monster 
	{
		
		public function CumWitch(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "Cum Witch", "cumwitch", "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.");

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5133;
			this.special2 = 5134;
			this.special3 = 5135;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "robes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 35;
			this.tou = 35;
			this.spe = 35;
			this.inte = 85;
			this.lib = 55;
			this.sens = 40;
			this.cor = 30;

			//Combat Stats
			this.bonusHP = 100;
			this.HP = eMaxHP();
			this.lustVuln = .8;
			this.lust = 30;

			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(15) + 5;

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