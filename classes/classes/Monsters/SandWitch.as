package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class SandWitch extends Monster
	{
		

		public function SandWitch(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("SandWitch Constructor!");
			init1Names("the ","sand witch",mainClassPtr.silly()?"sandwidch":"sandwitch","A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.");
			this.temperment                     = 1;
			this.special1                       = 5020;

			this.pronoun1                       = "she";
			this.pronoun2                       = "her";
			this.pronoun3                       = "her";

			//Clothing/Armor
			this.armorName                      = "robes";
			this.weaponName                     = "kick";
			this.weaponVerb                     = "kick";

			//Primary stats
			this.str                            = 25;
			this.tou                            = 25;
			this.spe                            = 35;
			this.inte                           = 45;
			this.lib                            = 55;
			this.sens                           = 40;
			this.cor                            = 30;
			this.fatigue                        = 0;

			//Combat Stats
			this.bonusHP                        = 20;
			this.HP                             = eMaxHP();
			this.lust                           = 30;

			//Level Stats
			this.level                          = 3;
			this.XP                             = this.totalXP(mainClassPtr.player.level);
			this.gems                           = rand(15) + 5;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                         = 2;
			this.tallness                       = rand(12) + 55;
			this.hairColor                      = "sandy-blonde";
			this.hairLength                     = 15;

			this.skinTone                       = "bronzed";
			this.skinDesc                       = "skin";

			this.hipRating                      = 10;

			this.buttRating                                 = 8;
			this.createBreastRow();
			this.createBreastRow();
			this.breastRows[0].breastRating                 = 5;
			this.breastRows[0].nipplesPerBreast             = 1;
			this.breastRows[1].breastRating                 = 5;
			this.breastRows[1].nipplesPerBreast             = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness                  = VAGINA_WETNESS_WET;
			this.vaginas[0].vaginalLooseness                = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin                          = false;
			this.cumMultiplier                              = 3;
			this.hoursSinceCum                              = 20;
			this.ass.analLooseness                          = 1;
			this.ass.analWetness                            = 1;

		}

	}

}