package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class GreenSlime extends Monster
	{
		

		public function GreenSlime(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("GreenSlime Constructor!");
			this.short="green slime";
			this.imageName="greenslime";

			this.long = "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.";
			this.a ="a ";

			this.temperment = 3;
			this.special1 = 5040;
			this.special2 = 5039;
			this.special3 = 5039;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";

			//Clothing/Armor
			this.armorName = "gelatinous skin";
			this.weaponName = "hands";
			this.weaponVerb = "slap";

			//Primary stats
			this.str = 25;
			this.tou = 20;
			this.spe = 10;
			this.inte = 5;
			this.lib = 50;
			this.sens = 60;
			this.cor = 20;

			//Combat Stats
			this.bonusHP = 30;
			this.HP = eMaxHP();
			this.lust = 30;

			//Level Stats
			this.level = 2;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5)+1;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = rand(8) + 80;
			this.hairColor = "green";
			this.hairLength = 0;

			this.skinTone = "green";
			this.skinDesc = "skin";

			this.hipRating = 6;

			this.buttRating = 8;
			//Create imp sex attributes
			this.createCock();
			this.cocks[0].cockLength = 18;
			this.cocks[0].cockThickness = 2;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;

		}

	}

}