package classes.Monsters 
{
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Ember extends Monster 
	{
		
		public function Ember(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Ember";
			this.imageName="ember";
			this.plural = false;
			this.long = "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + mainClassPtr.emberMF("he","she") + " lashes "+ mainClassPtr.emberMF("his","her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
			this.a =" ";
			
			this.temperment = 3;
			//Regular attack
			this.special1 = 0;
			//Lust attack
			this.special2 = 0;
			this.special3 = 0;
			this.pronoun1 = mainClassPtr.emberMF("he","she");
			this.pronoun2 = mainClassPtr.emberMF("him","her");
			this.pronoun3 = mainClassPtr.emberMF("his","her");
			
			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 40;
			this.armorPerk = "";
			this.weaponAttack = 30;
			this.weaponPerk = "";
			this.weaponValue = 0;
			this.armorValue = 0;
			//Primary stats
			this.str = 75;
			this.tou = 75;
			this.spe = 75;
			this.inte = 75;
			this.lib = 50;
			this.sens = 35;
			this.cor = mainClassPtr.flags[kFLAGS.EMBER_COR];
			this.fatigue = 0;
			this.lustVuln = .25;
			
			//Combat Stats
			this.bonusHP = 600;
			this.HP = eMaxHP();
			this.lust = 20;
			
			//Level Stats
			this.level = 15;
			this.XP = totalXP();
			this.gems = 0;
			
			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = mainClassPtr.flags[kFLAGS.EMBER_GENDER];
			this.tallness = rand(8) + 70;
			this.hairColor = "black";
			this.hairLength = 15;
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
			this.hornType = HORNS_DEMON;
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
			this.tailType = TAIL_TYPE_DEMONIC;
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
			//Create imp sex attributes
			if(mainClassPtr.flags[kFLAGS.EMBER_GENDER] >= 2) {
				this.createVagina();
				this.vaginas[0].virgin = false;
				this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
				this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			}
			if(mainClassPtr.flags[kFLAGS.EMBER_GENDER] == 1 || mainClassPtr.flags[kFLAGS.EMBER_GENDER] == 3) {
				this.balls = 2;
				this.createCock();
				this.cocks[0].cockLength = 16;
				this.cocks[0].cockThickness = 2;
				this.cocks[0].cockType = CockTypesEnum.DRAGON;
				this.ballSize = 4;
			}
			this.cumMultiplier = 3;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 0;			
		}
		
	}

}