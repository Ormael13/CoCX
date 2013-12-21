package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Marble extends Monster
	{
		

		public function Marble(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Marble Constructor!");
			this.short="Marble";
			this.imageName="marble";

			this.long = "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger then she may appear to be.";
			this.a ="";

			this.temperment = 2;
			//Regular attack
			this.special1 = 5092;
			//Lust attack
			this.special2 = 5093;

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "tough hide";
			this.weaponName = "large hammer";
			this.weaponVerb = "hammer-blow";
			this.armorDef = 5;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 75;
			this.tou = 70;
			this.spe = 35;
			this.inte = 40;
			this.lib = 25;
			this.sens = 45;
			this.cor = 40;

			//Combat Stats

			this.HP = eMaxHP();

			this.lust = 0;

			//Level Stats
			this.level = 7;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5) + 25;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 76;
			this.hairColor = "brown";
			this.hairLength = 13;

			this.skinTone = "pale";
			this.skinDesc = "skin";

			this.lowerBody = LOWER_BODY_TYPE_CENTAUR;

			this.tailType = TAIL_TYPE_COW;

			this.hipRating = 10;

			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 11;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_NORMAL;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 0;
			this.ass.analWetness = 0;

		}

	}

}