package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ImpLord extends Monster 
	{
		
		public function ImpLord(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="imp lord";
			this.imageName="implord";
			this.plural = false;
			this.long = "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works it's way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wears very little clothing, only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.";
			this.a ="the ";
			
			this.temperment = 1;
			this.special1 = 5019;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";
			
			//Clothing/Armor
			this.armorName = "leathery skin";
			this.weaponName = "fist";
			this.weaponVerb = "punch";
			this.armorDef = 5;
			this.armorPerk = "";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 55;
			this.tou = 40;
			this.spe = 75;
			this.inte = 42;
			this.lib = 55;
			this.sens = 35;
			this.cor = 100;
			this.fatigue = 0;
			
			//Combat Stats
			this.bonusHP
			this.HP = eMaxHP();
			this.lust = 30;
			this.lustVuln = .65;
			
			//Level Stats
			this.level = 7;
			this.XP = totalXP();
			this.gems = rand(15) + 25;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = rand(14) + 40;
			this.hairColor = "black";
			this.hairLength = 0;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "red";
			this.skinDesc = "skin";
			//Facetype:
			//0 - human
			//1 - horse
			//2 - dogface
			this.faceType = FACE_HUMAN;
			this.wingDesc = "small";
			//Wingtype
			//0 - none
			//1 - bee
			//2 - large bee
			//3 - faerie?
			//4 - avian
			//5 - dragoooon?
			this.wingType = WING_TYPE_IMP;
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
			this.hipRating = 0;
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
			this.buttRating = 2;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 0;
			this.createCock();
			this.cocks[0].cockLength = rand(2) + 11;
			this.cocks[0].cockThickness = 2.5;

			// Imps now only have demon dicks. 
			// Not sure if I agree with this, I can imagine the little fuckers abusing the 
			// shit out of any potions they can get their hands on.
			this.cocks[0].cockType = CockTypesEnum.DEMON;
			this.balls = 2;
			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 1;			
		}
		
	}

}