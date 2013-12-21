package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Zetaz extends Monster 
	{
		
		public function Zetaz(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short = "Zetaz";
			this.imageName = "zetaz";
			this.long="Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past ";
			if(mainClassPtr.model.time.days < 60) this.long += "weeks";
			else this.long += "months";
			this.long += ".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.";
			this.plural = false;
			this.a ="";
			
			this.temperment = 1;
			this.special1 = 0;
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";
			
			//Clothing/Armor
			this.armorName = "leathery skin";
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.armorDef = 0;
			this.armorPerk = "";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 65;
			this.tou = 60;
			this.spe = 45;
			this.inte = 52;
			this.lib = 55;
			this.sens = 35;
			this.cor = 100;
			this.fatigue = 0;
			this.lustVuln = .35;
			
			//Combat Stats
			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			this.lust = 40;
			
			//Level Stats
			this.level = 12;
			this.XP = totalXP() + 100;
			this.gems = rand(55) + 150;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 49;
			this.hairColor = "black";
			this.hairLength = 5;
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
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
			this.balls = 2;
			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.hoursSinceCum = 20;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;			
		}
		
	}

}