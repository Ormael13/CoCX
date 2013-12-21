package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends Monster 
	{
		
		public function CorruptedDrider(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="corrupted drider";
			this.imageName="corrupteddrider";
			this.plural = false;
			
			this.a ="the ";
			
			this.temperment = 2;
			//Lusty teases
			this.special1 = 0;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";
			
			//Clothing/Armor
			this.armorName = "carapace";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 55;
			this.armorPerk = "";
			this.weaponAttack = 30;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 70;
			//Primary stats
			this.str = 100;
			this.tou = 50;
			this.spe = 70;
			this.inte = 100;
			this.lib = 80;
			this.sens = 50;
			this.cor = 90;
			this.fatigue = 0;
			this.lustVuln = .4;
			
			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();
			
			this.lust = 30;
			
			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = rand(10) + 20;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 120;
			var temp:int = rand(3);
			if(temp == 0) this.hairColor = "red";
			else if(temp == 1) this.hairColor = "orange";
			else if(temp == 2) this.hairColor = "green";
			this.hairLength = 24;
			//Skintype
			//0 - skin
			//1 - furry
			//2 - scaley
			this.skinType = SKIN_TYPE_PLAIN;
			//SKINTONE USED FOR EYES ON DRIDAH!
			temp = rand(4);
			if(temp == 0) this.skinTone = "yellow";
			else if(temp == 1) this.skinTone = "purple";
			else if(temp == 2) this.skinTone = "red";
			else if(temp == 3) this.skinTone = "turquoise";
			this.skinDesc = "scales";
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
			//5 - demonic heels
			//6 - demon foot-claws
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
			this.hipRating = 12;
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
			if(rand(2) == 0) {
				this.nipplesPierced = 1;
				this.lustVuln = .25;
				//Combat Stats
				this.bonusHP = 325;
				this.HP = eMaxHP();
				this.lust = 35;
				//Level Stats
				this.level = 15;
				this.XP = totalXP();
				this.gems = rand(10) + 30;

			}
			this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  ";
			if(this.nipplesPierced > 0) this.long += "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ";
			this.long += "On her face and forehead, a quartet of lust-filled, " + this.skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + this.hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + this.hairColor + " stripes - a menacing display if ever you've seen one.";
			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.createCock();
			this.cocks[0].cockLength = 9;
			this.cocks[0].cockThickness = 2;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",70,0,0,0);
			this.createStatusAffect("Bonus vCapacity",70,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}