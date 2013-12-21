package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class TentacleBeast extends Monster
	{
		

		public function TentacleBeast(mainClassPtr:*) 
		{
			
			trace("TentacleBeast Constructor!");
			this.short                            ="tentacle beast";
			this.imageName                        ="tentaclebeast";
			this.plural                           = false;
			this.long                             = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
			this.a                                ="the ";
			this.capitalA                         ="The ";
			this.temperment                       = 3;
			//Regular attack
			this.special1                         = 5072;
			//Lust attack
			this.special2                         = 5073;
			this.special3                         = 5072;
			this.pronoun1                         = "it";
			this.pronoun2                         = "it";
			this.pronoun3                         = "its";
			
			//Clothing/Armor
			this.armorName                        = "rubbery skin";
			this.weaponName                       = "whip-tendril";
			this.weaponVerb                       = "thorny tendril";
			this.armorDef                         = 1;
			this.armorPerk                        = "";
			this.weaponAttack                     = 1;
			this.weaponPerk                       = "";
			this.weaponValue                      = 0;
			this.armorValue                       = 0;
			//Primary stats
			this.str                              = 58;
			this.tou                              = 25;
			this.spe                              = 45;
			this.inte                             = 45;
			this.lib                              = 90;
			this.sens                             = 20;
			this.cor                              = 100;
			this.fatigue                          = 0;
			
			//Combat Stats
			this.bonusHP                          = 350;
			this.HP                               = eMaxHP();
			this.lustVuln                         = 0.8;
			
			this.lust                             = 10;
			
			//Level Stats
			this.level                            = 6;
			this.XP                               = this.totalXP(mainClassPtr.player.level);
			this.gems                             = rand(15)+5;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                           = 0;
			this.tallness                         = rand(9) + 70;
			this.hairColor                        = "green";
			this.hairLength                       = 1;
			this.skinType                         = SKIN_TYPE_PLAIN;
			this.skinTone                         = "green";
			this.skinDesc                         = "bark";
			this.faceType                         = FACE_HUMAN;
			this.hornType                         = HORNS_NONE;
			this.wingDesc                         = "non-existant";

			this.wingType                         = WING_TYPE_NONE;
			//5 - demonic heels
			//6 - demon foot-claws
			this.lowerBody                        = LOWER_BODY_TYPE_HUMAN;
			this.tailType                         = TAIL_TYPE_DEMONIC;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom                        = 0;
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
			this.hipRating                        = 0;
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
			this.buttRating                       = 0;
			//Create succubus sex attributes
			this.cumMultiplier                    = 3;
			this.createCock();
			this.cocks[0].cockLength              = 40;
			this.cocks[0].cockThickness           = 1.5;
			this.createCock();
			this.cocks[1].cockLength              = 60;
			this.cocks[1].cockThickness           = 1.5;
			this.createCock();
			this.cocks[2].cockLength              = 50;
			this.cocks[2].cockThickness           = 1.5;
			this.createCock();
			this.cocks[3].cockLength              = 20;
			this.cocks[3].cockThickness           = 1.5;
			this.ass.analLooseness                = 1;
			this.ass.analWetness                  = 35;		

		}

	}

}