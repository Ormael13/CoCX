package classes.Monsters 
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Imp extends Monster
	{
		

		public function Imp(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Imp Constructor!");
			init1Names("the ","imp","imp","An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.");
			init2Male([new Cock(rand(2) + 11,2.5)]);
			this.temperment                     = 1;
			this.special1                       = 5019;
			this.pronoun1                       = "he";
			this.pronoun2                       = "him";
			this.pronoun3                       = "his";

			//Clothing/Armor
			this.armorName                      = "leathery skin";
			this.weaponName                     = "claws";
			this.weaponVerb                     = "claw-slash";
			//Primary stats
			this.str                            = 20;
			this.tou                            = 10;
			this.spe                            = 25;
			this.inte                           = 12;
			this.lib                            = 45;
			this.sens                           = 45;
			this.cor                            = 100;

			//Combat Stats
			this.HP                             = tou * 2 + 50;
			this.lust                           = 40;

			//Level Stats
			this.level                          = 1;
			this.XP                             = this.totalXP(mainClassPtr.player.level);
			this.gems                           = rand(5) + 5;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                         = 1;
			this.tallness                       = rand(24) + 25;
			this.hairColor                      = "black";
			this.hairLength                     = 5;

			this.skinType                       = SKIN_TYPE_PLAIN;
			this.skinTone                       = "red";
			this.skinDesc                       = "skin";

			this.wingDesc                       = "small";

			this.wingType                       = WING_TYPE_IMP;
			this.buttRating                     = 2;

			this.createBreastRow();
			this.breastRows[0].breastRating     = 0;
			this.breastRows[0].nipplesPerBreast = 0;

		}

	}

}