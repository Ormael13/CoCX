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
			
			trace("WormMass Constructor!");
			this.short="worms";
			this.imageName="worms";
			this.plural = true;
			this.long = "Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.";
			this.a ="the ";
			this.capitalA ="The ";
			this.temperment = 3;
			//Regular attack
			this.special1 = 5054;
			//Lust attack
			this.special2 = 5055;
			this.special3 = 0;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			
			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "worm";
			this.weaponVerb = "slap";
			this.armorDef = 0;
			this.armorPerk = "";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 35;
			this.tou = 5;
			this.spe = 10;
			this.inte = 1;
			this.lib = 90;
			this.sens = 60;
			this.cor = 90;
			this.fatigue = 0;
			
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
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "white";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "non-existant";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType = WING_TYPE_NONE;
			//lowerBody:
			//0 - normal
			//1 - hooves
			//2 - paws
			//3 - snakelike body
			//4 - centaur!
			this.lowerBody = LOWER_BODY_TYPE_HUMAN;
			//tailType:
			//0 - none
			//1 - horse
			//2 - dog
			//3 - demon
			//4 - cow!
			//5 - spider!
			//6 - bee!
			this.tailType = TAIL_TYPE_NONE;
			//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
			this.tailVenom = 0;
			//Tail recharge determines how fast venom/webs comes back per hour.
			this.tailRecharge = 5;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating = 2;
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
			this.buttRating = 0;
			//Create imp sex attributes
			this.balls = 0;
			this.cumMultiplier = 3;
			this.ballSize = 0;
			this.ass.analLooseness = 0;
			this.ass.analWetness = 0;
			
			
		}

	}

}