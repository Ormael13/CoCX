package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ChameleonGirl extends Monster 
	{
		
		public function ChameleonGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="chameleon girl";
			this.imageName="chameleongirl";
			this.plural = false;
			this.skinTone = "red";
			this.skinAdj = "";
			var temp:int = rand(6);
			switch(temp) {
				case 0:
					this.skinTone = "red";
					this.skinAdj = "black";
					break;
				case 1:
					this.skinTone = "green";
					this.skinAdj = "yellowish";
					break;
				case 2:
					this.skinTone = "blue";
					this.skinAdj = "lighter blue";
					break;
				case 3:
					this.skinTone = "purple";
					this.skinAdj = "bright yellow";
					break;
				case 4:
					this.skinTone = "orange";
					this.skinAdj = "brown";
					break;
				case 5:
					this.skinTone = "tan";
					this.skinAdj = "white";
					break;
				default:
					this.skinTone = "Fudgup";
					this.skinAdj = "Error";
					break;
			}
			this.long = "You're faced with a tall lizard-like girl with smooth " + this.skinTone + " skin and long, " + this.skinAdj + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.";

			this.a ="the ";
			
			this.temperment = 3;
			//Regular attack
			this.special1 = 0;
			//Lust attack
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 20;
			this.armorPerk = "";
			this.weaponAttack = 30;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 65;
			this.tou = 65;
			this.spe = 95;
			this.inte = 85;
			this.lib = 50;
			this.sens = 45;
			this.cor = mainClassPtr.flags[kFLAGS.EMBER_COR];
			this.fatigue = 0;
			this.lustVuln = .25;
			
			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			this.lust = 30;
			
			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = 10 + rand(50);
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(2) + 68;
			this.hairColor = "black";
			this.hairLength = 15;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
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
			this.tailRecharge = 0;
			//hipRating
			//0 - boyish
			//2 - slender
			//4 - average
			//6 - noticable/ample
			//10 - curvy//flaring
			//15 - child-bearing/fertile
			//20 - inhumanly wide
			this.hipRating = 8;
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
			this.buttRating = 8;
			this.createVagina();
			this.vaginas[0].virgin = false;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.cumMultiplier = 3;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 0;
			
		}
		
	}

}