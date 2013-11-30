package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Imp extends Monster
	{
		

		public function Imp(playerPtr:*) 
		{
			
			trace("Imp Constructor!");
			this.short                          = "imp";
			this.imageName                      = "imp";
			this.plural                         = false;
			this.long                           = "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
			this.a                              ="the ";
			this.capitalA                       ="The ";
			this.temperment                     = 1;
			this.special1                       = 5019;
			this.special2                       = 0;
			this.special3                       = 0;
			this.pronoun1                       = "he";
			this.pronoun2                       = "him";
			this.pronoun3                       = "his";
			
			//Clothing/Armor
			this.armorName                      = "leathery skin";
			this.weaponName                     = "claws";
			this.weaponVerb                     = "claw-slash";
			this.armorDef                       = 0;
			this.armorPerk                      = "";
			this.weaponAttack                   = 0;
			this.weaponPerk                     = "";
			this.weaponValue                    = 0;
			this.armorValue                     = 0;
			//Primary stats
			this.str                            = 20;
			this.tou                            = 10;
			this.spe                            = 25;
			this.inte                           = 12;
			this.lib                            = 45;
			this.sens                           = 45;
			this.cor                            = 100;
			this.fatigue                        = 0;
			
			//Combat Stats
			this.HP                             = tou * 2 + 50;
			this.lust                           = 40;
			
			//Level Stats
			this.level                          = 1;
			this.XP                             = this.totalXP(playerPtr.level);
			this.gems                           = rand(5) + 5;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                         = 1;
			this.tallness                       = rand(24) + 25;
			this.hairColor                      = "black";
			this.hairLength                     = 5;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType                       = SKIN_TYPE_PLAIN;
			this.skinTone                       = "red";
			this.skinDesc                       = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType                       = FACE_HUMAN;
			this.wingDesc                       = "small";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType                       = WING_TYPE_IMP;
			this.buttRating                     = 2;

			this.createBreastRow();
			this.breastRows[0].breastRating     = 0;
			this.breastRows[0].nipplesPerBreast = 0;
			this.createCock();
			this.cocks[0].cockLength            = rand(2) + 11;
			this.cocks[0].cockThickness         = 2.5;
			this.cocks[0].cockType              = CockTypesEnum.HUMAN;
			
		}

	}

}