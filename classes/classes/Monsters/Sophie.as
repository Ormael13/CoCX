package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Sophie extends Monster
	{
		

		public function Sophie(mainClassPtr:*) 
		{
			
			trace("Sophie Constructor!");
		
			this.short                                     ="Sophie";
			this.imageName                                 ="sophie";
			this.plural                                    = false;
			this.long                                      = "Sophie is approximately the size of a normal human woman, not counting the large feathery wings that sprout from her back.  Her face is gorgeous, with large rounded eyes and glimmering amber lip-gloss painted on her lush, kissable lips.  In spite of her beauty, it's clear from the barely discernible laugh lines around her mouth that she's been around long to enough to have quite a few children.  Her feathers are light pink, though the downy plumage that comprises her 'hair' is brighter than the rest.  She moves with practiced grace despite the large, jiggling breasts that hang from her chest.  Judging from her confident movements, she's an experienced fighter.";
			this.a                                         ="";
			this.capitalA                                  ="";
			this.temperment                                = 2;
			//Uber
			this.special1                                  = 5136;
			//Lust attack
			this.special2                                  = 5137;
			this.special3                                  = 0;
			this.pronoun1                                  = "she";
			this.pronoun2                                  = "her";
			this.pronoun3                                  = "her";
			
			//Clothing/Armor
			this.armorName                                 = "feathers";
			this.weaponName                                = "talons";
			this.weaponVerb                                = "slashing talons";
			this.armorDef                                  = 5;
			this.armorPerk                                 = "";
			this.weaponAttack                              = 20;
			this.weaponPerk                                = "";
			this.weaponValue                               = 0;
			this.armorValue                                = 0;
			//Primary stats
			this.str                                       = 55;
			this.tou                                       = 40;
			this.spe                                       = 110;
			this.inte                                      = 60;
			this.lib                                       = 60;
			this.sens                                      = 50;
			this.cor                                       = 60;
			this.fatigue                                   = 0;
			this.lustVuln                                  = .3;
			
			//Combat Stats
			//int(player.statusAffectv2("Tamani")/2)
			this.bonusHP                                   = 250;
			this.HP                                        = eMaxHP();
			
			this.lust                                      = 10;
			
			//Level Stats
			this.level                                     = 11;
			this.gems                                      = 20 + rand(25);
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                                    = 2;
			this.tallness                                  = 65;
			this.hairColor                                 = "pink";
			this.hairLength                                = 16;
			this.skinType                                  = SKIN_TYPE_PLAIN;
			this.skinTone                                  = "pink";
			this.skinDesc                                  = "feathers";
			this.faceType                                  = FACE_HUMAN;
			this.hornType                                  = HORNS_NONE;
			this.wingDesc                                  = "large feathery wings";

			this.wingType                                  = WING_TYPE_HARPY;
			//5 - demonic heels
			//6 - demon foot-claws
			this.lowerBody                                 = LOWER_BODY_TYPE_HUMAN;
			this.tailType                                  = TAIL_TYPE_NONE;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom                                 = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge                              = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating                                 = 20;
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
			this.buttRating                                = 13;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating                = 5;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",40,0,0,0);
			this.vaginas[0].vaginalWetness                 = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness               = VAGINA_LOOSENESS_GAPING_WIDE;
			this.vaginas[0].virgin                         = false;
			this.ass.analLooseness                         = 1;
			this.createStatusAffect("Bonus aCapacity",10,0,0,0);
			this.ass.analWetness                           = 0;
			
			this.XP                                        = this.totalXP(mainClassPtr.player.level);
		}

	}

}