package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class FetishCultist extends Monster
	{
		

		public function FetishCultist(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("GenericMonstah Constructor!");
			init1Names("the ", "fetish cultist", "fetishcultist", "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath. She is wearing a religious outfit that closely hugs her curvacious shape, with a skirt so short that you can clearly see her pussy's lips.\n\nShe has clealy lost her grasp on sanity, and filled the void with pure perversion.");
			init2Female(VAGINA_LOOSENESS_GAPING, VAGINA_WETNESS_WET);
			this.cumMultiplier = 3;
			init3BreastRows("DD");
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);

			this.temperment = 3;
			//Regular attack
			this.special1 = 5062;
			//Lust attack
			this.special2 = 5063;
			this.special3 = 5062;

			//Clothing/Armor
			this.armorName = "fetishy outfit";
			this.weaponName = "whip";
			this.weaponVerb = "whip-crack";

			//Primary stats
			this.str = 35;
			this.tou = 25;
			this.spe = 30;
			this.inte = 1;
			this.lib = 75;
			this.sens = 80;
			this.cor = 90;

			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 25;

			//Level Stats
			this.level = 2;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = 5+rand(10);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 67;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "pale";
			this.skinDesc = "skin";

			this.hipRating = 6;

			this.buttRating = 8;
			//Create imp sex attributes

		}

	}

}