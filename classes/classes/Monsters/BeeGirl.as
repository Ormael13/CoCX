package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class BeeGirl extends Monster
	{
		

		public function BeeGirl(mainClassPtr:*) 
		{
			this.short                            ="bee-girl";
			this.imageName                        ="beegirl";
			this.plural                           = false;
			this.long                             = "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			this.a                                ="a ";
			this.capitalA                         ="A ";
			this.temperment                       = 3;
			this.special1                         = 5036;
			this.special2                         = 0;
			this.special3                         = 0;
			this.pronoun1                         = "she";
			this.pronoun2                         = "her";
			this.pronoun3                         = "her";
			
			//Clothing/Armor
			this.armorName                        = "chitin";
			this.weaponName                       = "chitin-plated fist";
			this.weaponVerb                       = "armored punch";
			this.armorDef                         = 9;
			this.armorPerk                        = "";
			this.weaponAttack                     = 0;
			this.weaponPerk                       = "";
			this.weaponValue                      = 0;
			this.armorValue                       = 0;
			//Primary stats
			this.str                              = 30;
			this.tou                              = 30;
			this.spe                              = 30;
			this.inte                             = 20;
			this.lib                              = 60;
			this.sens                             = 55;
			this.lust                             = 20 + rand(40);
			this.cor                              = 0;
			this.fatigue                          = 0;
			
			//Combat Stats
			this.bonusHP                          = 0;
			this.HP                               = eMaxHP();
			this.lustVuln                         = 0.9;
			
			//Level Stats
			this.level                            = 4;
			this.XP                               = this.totalXP(mainClassPtr.player.level);
			this.gems                             = rand(15) + 1;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                           = 2;
			this.tallness                         = rand(14) + 59;
			//randomly assign hair color
			if(rand(2) == 0) 
				this.hairColor                    = "black";
			else 
				this.hairColor                    = "black and yellow";
			this.hairLength                       = 6;
			this.skinType                         = SKIN_TYPE_PLAIN;
			this.skinTone                         = "yellow";
			this.skinDesc                         = "skin";
			//3 - cowface
			this.faceType                         = FACE_COW_MINOTAUR;
			this.antennae                         = ANTENNAE_BEE;
			this.wingDesc                         = "insect-like wings";

			this.wingType                         = WING_TYPE_BEE_LIKE_SMALL;
			this.lowerBody                        = LOWER_BODY_TYPE_HUMAN;
			//7 - cow!
			this.tailType                         = TAIL_TYPE_BEE_ABDOMEN;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom                        = 100;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge                     = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating                        = 13;
			//buttRating
			//0 - buttless
			//2 - tight
			//4 - average
			//6 - noticable
			//8 - large
			//10 - jiggly
			//13 - expansive
			//16 - huge
			//20 - inconceivably large/big/huge etc
			this.buttRating                       = 13;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating       = 5;
			this.breastRows[0].nipplesPerBreast   = 1;
			this.createVagina();
			this.vaginas[0].virgin                = false;
			this.vaginas[0].vaginalWetness        = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness      = VAGINA_LOOSENESS_GAPING;
			this.cumMultiplier                    = 1.5;
			this.hoursSinceCum                    = 10 + rand(100);
			this.ass.analLooseness                = 4;
			this.ass.analWetness                  = 1;
			trace("BeeGirl Constructor!");
			
			// possible issues accessing flags from this context. 
			
		}

	}

}