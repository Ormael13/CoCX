package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class WormMass extends Monster
	{
		

		public function WormMass(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("WormMass Constructor!");
			init1Names("the ","worms","worms","Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.");
			this.plural = true;

			this.temperment = 3;
			//Regular attack
			this.special1 = 5054;
			//Lust attack
			this.special2 = 5055;

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "worm";
			this.weaponVerb = "slap";

			//Primary stats
			this.str = 35;
			this.tou = 5;
			this.spe = 10;
			this.inte = 1;
			this.lib = 90;
			this.sens = 60;
			this.cor = 90;

			//Combat Stats
			this.HP = 40;
			this.lust = 30;
			this.lustVuln = 0;

			//Level Stats
			this.level = 3;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = 0;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 1;
			this.hairColor = "none";
			this.hairLength = 0;

			this.skinTone = "white";
			this.skinDesc = "skin";

			this.hipRating = 2;

			this.buttRating = 0;
			//Create imp sex attributes

			this.cumMultiplier = 3;
			this.ballSize = 0;
			this.ass.analLooseness = 0;
			this.ass.analWetness = 0;

		}

	}

}