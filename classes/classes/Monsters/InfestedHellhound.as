package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class InfestedHellhound extends Monster
	{
		

		public function InfestedHellhound(mainClassPtr:*) 
		{
			
			trace("InfestedHellhound Constructor!");
			this.short                                 ="infested hellhound";
			this.imageName                             ="infestedhellhound";
			this.plural                                = false;
			this.long                                  = "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.";
			this.a                                     ="the ";
			this.capitalA                              ="The ";
			this.temperment                            = 3;
			//Regular attack
			this.special1                              = 5066;
			//Lust attack
			this.special2                              = 5067;
			this.special3                              = 5107;
			this.pronoun1                              = "he";
			this.pronoun2                              = "him";
			this.pronoun3                              = "his";
			
			//Clothing/Armor
			this.armorName                             = "thick fur";
			this.weaponName                            = "claws";
			this.weaponVerb                            = "claw";
			this.armorDef                              = 0;
			this.armorPerk                             = "";
			this.weaponAttack                          = 5;
			this.weaponPerk                            = "";
			this.weaponValue                           = 0;
			this.armorValue                            = 0;
			//Primary stats
			this.str                                   = 65;
			this.tou                                   = 60;
			this.spe                                   = 50;
			this.inte                                  = 1;
			this.lib                                   = 95;
			this.sens                                  = 20;
			this.cor                                   = 100;
			this.fatigue                               = 0;
			
			//Combat Stats
			this.HP                                    = this.tou*2 + 50;
			this.lust                                  = 50;
			this.lustVuln                              = 0.87;
			
			//Level Stats
			this.level                                 = 5;
			this.gems                                  = 10+rand(10);
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender                                = 1;
			this.tallness                              = 47;
			this.hairColor                             = "red";
			this.hairLength                            = 3;
			this.skinType                              = SKIN_TYPE_PLAIN;
			this.skinTone                              = "black";
			this.skinDesc                              = "fur";
			this.faceType                              = FACE_HUMAN;
			this.hornType                              = HORNS_NONE;
			this.wingDesc                              = "non-existant";

			this.wingType                              = WING_TYPE_NONE;
			this.lowerBody                             = LOWER_BODY_TYPE_HUMAN;
			this.tailType                              = TAIL_TYPE_DOG;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom                             = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge                          = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating                             = 4;
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
			this.buttRating                            = 5;
			//Create imp sex attributes
			this.balls                                 = 2;
			this.ballSize                              = 5;
			this.createCock();
			this.createCock();
			this.cocks[0].cockLength                   = 9;
			this.cocks[1].cockLength                   = 9;
			this.cocks[0].cockThickness                = 2;
			this.cocks[1].cockThickness                = 2;
			this.cumMultiplier                         = 8;
			this.ass.analLooseness                     = 2;
			this.ass.analWetness                       = 1;
			
			this.XP                                    = this.totalXP(mainClassPtr.player.level);
		}

	}

}