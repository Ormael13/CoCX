package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class FetishZealot extends Monster
	{
		

		public function FetishZealot(mainClassPtr:*) 
		{
			
			trace("FetishZealot Constructor!");
		
			this.short="fetish zealot";
			this.imageName="fetishzealot";
			this.plural = false;
			this.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
			this.a ="the ";
			this.capitalA ="The ";
			this.temperment = 2;
			//Lusty teases
			this.special1 = 5103;
			this.special2 = 5104;
			this.special3 = 0;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";
			
			//Clothing/Armor
			this.armorName = "religious clothes";
			this.weaponName = "wavy dagger";
			this.weaponVerb = "stab";
			this.armorDef = 5;
			this.armorPerk = "";
			this.weaponAttack = 3;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			
			//Primary stats
			this.str = 35;
			this.tou = 35;
			this.spe = 30;
			this.inte = 1;
			this.lib = 75;
			this.sens = 80;
			this.cor = 90;
			this.fatigue = 0;
			
			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 25;
			this.lustVuln = 0.75;
			
			//Level Stats
			this.level = 5;
			this.gems = 5+rand(10);
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 72;
			this.hairColor = "black";
			this.hairLength = 4;
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinTone = "tan";
			this.skinDesc = "skin";
			this.faceType = FACE_HUMAN;
			this.hornType = HORNS_NONE;
			this.wingDesc = "non-existant";

			this.wingType = WING_TYPE_NONE;
			//5 - demonic heels
			//6 - demon foot-claws
			this.lowerBody = LOWER_BODY_TYPE_HUMAN;
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
			this.hipRating = 1;
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
			//Create goblin sex attributes
			this.ass.analLooseness = 3;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.ass.analWetness = 0;
			this.createCock();
			this.cocks[0].cockLength = 7;
			this.cocks[0].cockThickness = 1.5;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}